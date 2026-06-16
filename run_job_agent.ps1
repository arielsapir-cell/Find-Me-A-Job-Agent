# run_job_agent.ps1
# Daily Job Agent — runs automatically via Windows Task Scheduler
# Do not edit unless you know what you are doing.

$ProjectDir  = $PSScriptRoot
$ClaudePath  = "C:\Users\$env:USERNAME\AppData\Roaming\npm\claude.cmd"
$SendScript  = "C:\Users\$env:USERNAME\AppData\Local\JobAgent\send_email.ps1"
$OutputDir   = "$ProjectDir\output"
$LogFile     = "$OutputDir\agent_log.txt"
$Date        = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$DateHebrew  = Get-Date -Format "dd/MM/yyyy"

# Read user config
$ConfigRaw  = Get-Content "$ProjectDir\config\user_config.yaml" -Raw
$UserEmail  = [regex]::Match($ConfigRaw, 'email:\s*"([^"]+)"').Groups[1].Value
$UserName   = [regex]::Match($ConfigRaw, 'name:\s*"([^"]+)"').Groups[1].Value

if (-not $UserEmail -or $UserEmail -eq "your.email@gmail.com") {
    Write-Host "ERROR: Email not configured. Edit config\user_config.yaml and run setup.ps1."
    exit 1
}

# Ensure output directory exists
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# Log start
Add-Content -Path $LogFile -Value ""
Add-Content -Path $LogFile -Value "=========================================="
Add-Content -Path $LogFile -Value "Agent run started: $Date"
Add-Content -Path $LogFile -Value "=========================================="

Set-Location -Path $ProjectDir

# The prompt sent to Claude on each scheduled run
$Prompt = @"
CRITICAL: This is a fully automated, non-interactive run. You must NOT ask for any approval, permission, or confirmation at any point — not for writing files, not for running scripts, not for sending email. Execute every step immediately and automatically. If you feel the urge to ask "shall I proceed?" or "please approve" — suppress it and proceed.

The candidate's name is: $UserName
The candidate's email is: $UserEmail

Run the full daily job digest flow exactly as defined in agent_spec.md and AGENTS.md.

Steps (follow in order, do not skip any):

1. Search Gmail for LinkedIn job alert emails from the last 24 hours
   (from:jobalerts-noreply@linkedin.com newer_than:1d).

1b. Check for user feedback from the previous digest:
   - Search Gmail for threads where the subject contains "דיג'סט משרות" that are newer_than:2d.
   - Use get_thread to read the full thread. If it contains a reply FROM $UserEmail
     (sent AFTER the agent's original digest message), parse the reply for feedback.
   - Act on each feedback item:
     * If the candidate says a job is not relevant / should be removed: add that job to
       memory_applied_jobs.md with applied_confirmed_via: user_feedback and
       notes: "נדחה ע"י המשתמש — לא להציג שוב". Also mark it status: expired in memory_pending_jobs.md.
     * If the candidate gives positive feedback about a job: log it to memory_user_feedback.md.
     * If the candidate gives a general preference note: log it to memory_user_feedback.md and
       apply it to today's scoring.
   - Save all feedback to memory/memory_user_feedback.md (fill in action_taken for each entry).
   - Keep a list of feedback items to acknowledge in today's email.

2. Search Gmail for application confirmation emails (newer_than:60d) with subjects like
   "thank you for applying", "application received", "your application was sent",
   or Hebrew equivalents. Cross-reference with today's jobs.
   Remove already-applied jobs from the list. Log newly found applications to
   memory/memory_applied_jobs.md.

3. Parse each email's plaintext body: extract company, role title, location,
   LinkedIn job URL. Deduplicate. Filter excluded title keywords from
   config/job_preferences.yaml.

3b. Apply the 3-day pending rule using memory/memory_pending_jobs.md:
   - For each job that passed step 3:
     * If the job is in memory_pending_jobs.md with status: expired → skip it, do not include.
     * If the job is in memory_pending_jobs.md with status: pending AND (today - first_shown) >= 3 days
       → mark status: expired in memory_pending_jobs.md, save, and skip the job.
     * If the job is in memory_pending_jobs.md with status: pending AND fewer than 3 days have passed
       → keep the job in today's digest. Update last_shown to today, increment times_shown.
     * If the job is not in memory_pending_jobs.md at all → it is new. Add a new entry:
       job_id (URL or company__role), company, role_title, linkedin_job_url,
       first_shown: today, last_shown: today, times_shown: 1, status: pending.
   - Save memory_pending_jobs.md after processing all jobs.

4. For each remaining job:
   - Fetch the job description via WebFetch if accessible.
   - Score using job_matching_skill.md (1-10).
   - Search LinkedIn for a recruiter or hiring manager at the company.

5. Include only jobs with score 6 or higher.

6. For each qualifying job, write a full Hebrew paragraph per job_summary_skill.md:
   header (company + role), paragraph (company description, role focus, requirements,
   fit analysis), match score, LinkedIn URL, contact person or "לא נמצא איש קשר".

7. Save the complete digest to:
   output/daily_digest_$(Get-Date -Format 'yyyy-MM-dd').md

8. After saving the digest:
   a. Write the full HTML body to the file: $ProjectDir\output\email_body.html
      The HTML must include: <html dir="rtl"><body dir="rtl" style="direction:rtl;text-align:right;font-family:Arial,sans-serif;font-size:15px;line-height:1.8;">
      IMPORTANT: If any user feedback was processed in step 1b, add this section at the VERY TOP of the HTML body
      (before any job entries), inside a styled div:
        <div style="background:#f0f7ff;border-right:4px solid #2563eb;padding:12px 16px;margin-bottom:24px;border-radius:4px;">
        <strong>📬 פידבק שטופל:</strong><br>
        • [one bullet per action taken]
        </div>
      Each job entry must use separate <p> tags for: company description, role focus, requirements, and fit — with a blank line between them.
      English terms within Hebrew sentences stay inline — do not put them on separate lines.
   b. Use the Bash tool to run this exact command (replace X with the actual job count):
      powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$SendScript" -Subject "דיג'סט משרות — $DateHebrew | X משרות חדשות" -HtmlBodyFile "$ProjectDir\output\email_body.html"
   c. Do NOT just describe this step — actually execute it using your Bash tool.
   d. After sending successfully, update all feedback entries processed in step 1b:
      set acknowledged_in_digest to today's date in memory_user_feedback.md.

   Send to $UserEmail. Do not send to anyone else.

Do not apply to jobs. Do not contact recruiters. Complete all steps without waiting
for user input. Do not ask for permission before writing files or running scripts — just do it.
"@

# Write prompt to file to avoid command-line length limits, then pipe to Claude
$PromptFile = "$OutputDir\current_prompt.txt"
[System.IO.File]::WriteAllText($PromptFile, $Prompt, [System.Text.Encoding]::UTF8)
Get-Content $PromptFile -Raw | & $ClaudePath -p --dangerously-skip-permissions 2>&1 | Tee-Object -FilePath $LogFile -Append

$ExitCode = $LASTEXITCODE

# Log finish
$EndDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $LogFile -Value ""
Add-Content -Path $LogFile -Value "Agent run finished: $EndDate (exit code: $ExitCode)"
Add-Content -Path $LogFile -Value "=========================================="
