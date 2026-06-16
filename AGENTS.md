# AGENTS.md

## Project overview

This project helps you find relevant jobs every morning from LinkedIn job alert emails.

## Primary goal

Find jobs posted in the last 24 hours that fit your background and preferences.

Do not apply automatically.

Summarize only jobs worth reviewing.

## Candidate profile

Configured in:
- `config/user_config.yaml` — name and email
- `config/job_preferences.yaml` — target roles, seniority, locations, company types
- `cv/CV.pdf` — full CV used for scoring

## Required inputs

- CV file in /cv
- Preferences in /config/job_preferences.yaml
- User config in /config/user_config.yaml
- Applied jobs history in /memory/memory_applied_jobs.md

## Hard rules

- Never auto-apply to a role.
- Never send a CV to anyone.
- Never contact recruiters or hiring managers without explicit approval.
- Before every run: check the previous digest email thread for replies from the candidate.
  If a reply exists, parse it for feedback and act on it before processing today's jobs:
  * Job mentioned negatively → add to memory_applied_jobs.md with `applied_confirmed_via: user_feedback`, notes: "נדחה ע"י המשתמש — לא להציג שוב". Mark expired in memory_pending_jobs.md.
  * Positive feedback → log to memory_user_feedback.md as preference signal.
  * General preference note → log and factor into today's matching.
  Acknowledge processed feedback at the TOP of today's email: "📬 פידבק שטופל: [summary]".
- 3-day pending rule: if a job appeared in the digest 3 or more days ago and the candidate has not applied,
  do not show it again. Track this in memory/memory_pending_jobs.md. Expired jobs are never re-shown.
- Before every run: search Gmail for application confirmation emails and cross-reference with today's jobs using precise matching:
  * Match by LinkedIn job URL (exact) → exclude that job.
  * Match by company + job title → exclude that job.
  * Match by company name only (no title/URL in email) → do NOT exclude. Include the job with a note: "ייתכן שהגשת לתפקיד אחר בחברה זו — בדוק לפני הגשה".
- Before including any job in the digest: check if the job page says "No longer accepting applications". If yes — skip it.
- After each run: if the candidate confirms they applied to a job, update memory_applied_jobs.md automatically.
- Exclude jobs already confirmed as applied via LinkedIn email, Gmail confirmation, or memory file.
- If the candidate applied to a job previously suggested, treat that as positive preference feedback for similar future roles.
- If the same job appears on LinkedIn and on a company careers site, prefer the LinkedIn URL.
- Use the phrase "התאמה מצוינת" only for jobs scored 8-10.
- Do not invent recruiter names, company facts, or missing job details.
- Every job in the digest must include a contact person field. Search LinkedIn before writing. If no contact is found, write "לא נמצא איש קשר" — never skip this field.
- No WhatsApp output of any kind.

## Email delivery

- At the end of every run, send the full digest automatically to the configured email.
- No approval is needed before sending.
- Never send email to recruiters, hiring managers, or any third party.
- Subject format: "דיג'סט משרות — DD Month YYYY | X משרות חדשות"

## Output format

For each relevant job, include ALL of the following in order:

1. Company name and role title as a header
2. Hebrew paragraph (up to 5 sentences):
   - What the company does
   - What the role focuses on
   - Main requirements
   - Why it fits or partially fits the candidate
3. Match score (1-10). Use "התאמה מצוינת" only for scores 8-10.
4. Direct link to the LinkedIn job posting
5. Contact person: name + LinkedIn profile URL. If none found, write "לא נמצא איש קשר".

No tables in the digest. Paragraph format only.
