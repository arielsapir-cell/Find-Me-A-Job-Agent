# memory_user_feedback.md

## Purpose

Track feedback you sent via email replies to the daily digest.
The agent reads this file before each run and acts on unacknowledged feedback.

## How to give feedback

Reply to the daily digest email in Hebrew or English. Examples:
- "The [Company] job isn't relevant, please remove it"
- "You were right about [Company X]"
- "I'm not interested in [domain/role type] roles"
- "המשרה של [חברה] לא רלוונטית, תוריד מהרשימה"

## Action rules by feedback type

- Negative / remove a job → add the job to memory_applied_jobs.md with `applied_confirmed_via: user_feedback`
  and `notes: "נדחה ע"י המשתמש — לא להציג שוב"`. Also remove from memory_pending_jobs.md if present.
- Positive feedback about a job → log here as positive preference signal for future scoring.
- General preference note (domain, role type, company type) → log here and factor into future matching.

## Acknowledgement rule

After acting on feedback, include a brief Hebrew section at the TOP of the next digest email:
"📬 פידבק שטופל: [one-line summary of each action taken]"
Set `acknowledged_in_digest` to today's date so it is not repeated in future emails.

## Entry format

- date_received: [YYYY-MM-DD]
- source_thread_subject: [exact Gmail subject of the digest email that was replied to]
- feedback_type: [remove_job | positive_feedback | preference_note | other]
- job_reference: [company name and/or LinkedIn URL if mentioned; "general" if no specific job]
- feedback_text: [your exact words from the email reply]
- action_taken: [what the agent did]
- acknowledged_in_digest: [YYYY-MM-DD, or "pending"]

## Feedback log

(empty — will be populated automatically by the agent)
