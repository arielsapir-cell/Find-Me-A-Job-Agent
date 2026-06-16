# LinkedIn Job Agent — Daily Digest via Claude Code

An automated job search agent that runs every morning, reads your LinkedIn job alert emails via Gmail, scores each role against your CV and preferences, and sends you a structured Hebrew digest by email — with match scores, key requirements, and a relevant contact person at each company.

Built on [Claude Code](https://claude.ai/code) (Anthropic's CLI). Runs on Windows via Task Scheduler. No coding required to use.

---

## What it does

- Searches Gmail for LinkedIn job alert emails from the last 24 hours
- Scores each job 1–10 against your CV and preferences
- Skips jobs you already applied to (auto-detected from Gmail confirmations)
- Skips jobs marked "No longer accepting applications"
- Sends a daily Hebrew digest to your email at 8:00 AM
- Learns from your feedback: reply to the digest email with notes, and the agent incorporates them the next day
- Stops reminding you about jobs you haven't applied to after 3 days

---

## Prerequisites

| Requirement | Notes |
|---|---|
| Windows 10 / 11 | Required (uses PowerShell + Task Scheduler) |
| [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) | `npm install -g @anthropic-ai/claude-code` |
| Anthropic account | For Claude Code access |
| Gmail account | With 2-Step Verification enabled |
| Gmail App Password | See step 3 below |
| LinkedIn job alerts | Set up at linkedin.com → Jobs → Job Alerts |

---

## Setup (one time)

### Step 1 — Clone the repo

```
git clone https://github.com/YOUR_USERNAME/linkedin-job-agent.git
cd linkedin-job-agent
```

### Step 2 — Add your CV

Place your CV as a PDF in the `cv/` folder, named `CV.pdf`:

```
cv/CV.pdf
```

The agent reads your CV before scoring every job — this is how it knows what experience you have, which roles suit you, and why a specific job is or isn't a good fit. Without your CV, all scores will be generic and inaccurate.

> You can add multiple CV files if you have different versions (e.g., one focused on Product, one on Growth/Retention). The agent will read all of them and use whichever is most relevant to each job.

### Step 3 — Get a Gmail App Password

1. Go to [myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)
2. Sign in and create an App Password for "Mail"
3. Copy the 16-character code (you'll use it in Step 5)

> Gmail App Passwords require 2-Step Verification on your Google account.

### Step 4 — Connect Gmail to Claude

1. Go to [claude.ai](https://claude.ai) → Settings → Integrations
2. Connect your Gmail account
3. This allows Claude to read your job alert emails and digest threads

### Step 5 — Edit your configuration

**`config/user_config.yaml`** — your basic details:

```yaml
email: "you@gmail.com"   # The digest will be sent here
name: "Your Name"        # Used by the agent when writing your fit analysis
```

**`config/job_preferences.yaml`** — this is the most important file to personalize. It tells the agent:

- **`target_job_families`** — the role types you're looking for (e.g., Product Manager, Growth, Lifecycle, Brand)
- **`title_keywords_include`** — keywords in a job title that make it relevant to you
- **`title_keywords_exclude`** — keywords that mean a job is definitely not for you (e.g., "sales", "software engineer")
- **`preferred_company_types`** — B2C, B2B, B2B2C, etc.
- **`locations_preferred`** — cities or regions you'd consider
- **`seniority_rules`** — whether you're looking for mid-level, senior, or management roles

> The Skills files (`Skills/`) do not need to be edited — they adapt automatically based on your CV and job_preferences.yaml.

### Step 6 — Run the setup script

Open PowerShell **as Administrator** and run:

```powershell
cd path\to\linkedin-job-agent
.\setup.ps1
```

The setup script will:
- Verify Claude Code is installed
- Ask for your Gmail App Password and encrypt it securely (Windows DPAPI)
- Create the necessary files in `AppData\Local\JobAgent\`
- Optionally register a Windows Task Scheduler task to run every morning at 8:00 AM

---

## Usage

Once set up, the agent runs automatically at 8:00 AM every day.

**To run manually:**
```powershell
.\run_job_agent.ps1
```

**To give feedback:**
Reply to any digest email. The agent reads your reply the next morning. Examples:
- "The [Company] job isn't relevant, please remove it"
- "You were right about [Company X]"
- "I'm not interested in [domain] roles"

**To mark a job as applied:**
The agent automatically detects application confirmation emails from LinkedIn. You can also add entries manually to `memory/memory_applied_jobs.md`.

---

## How jobs are scored

Each job is scored 1–10 based on:
- Alignment with your target job families and title keywords (`job_preferences.yaml`)
- Match to your CV (placed in `cv/CV.pdf`)
- Location and remote policy
- Company type (B2C, B2B2C, etc.)
- Seniority requirements vs. your level

Only jobs scoring **6 or higher** appear in the digest.

---

## File structure

```
├── run_job_agent.ps1       ← main script (runs daily)
├── setup.ps1               ← one-time setup wizard
├── agent_spec.md           ← agent behavior specification
├── AGENTS.md               ← agent rules and profile
├── config/
│   ├── user_config.yaml    ← YOUR email and name (edit this)
│   └── job_preferences.yaml ← YOUR target roles and preferences (edit this)
├── Skills/
│   ├── job_matching_skill.md
│   └── job_summary_skill.md
├── memory/
│   ├── memory_applied_jobs.md    ← auto-populated: jobs you applied to
│   ├── memory_pending_jobs.md    ← auto-populated: 3-day reminder tracker
│   └── memory_user_feedback.md  ← auto-populated: feedback from your replies
├── cv/
│   └── CV.pdf              ← YOUR CV (add this)
└── output/
    └── daily_digest_YYYY-MM-DD.md  ← auto-generated digests
```

---

## Privacy

- Your CV, email, and App Password never leave your machine
- The App Password is encrypted with Windows DPAPI (machine + user specific)
- Memory files contain job search history — they are gitignored by default
- Output digests are gitignored by default

---

## Limitations

- Windows only (PowerShell + Task Scheduler + DPAPI)
- Requires Claude Code CLI and an Anthropic account
- Reads LinkedIn job alerts only (not direct job board scraping)
- Digest language is Hebrew by default (configurable in `agent_spec.md`)

---

## License

MIT
