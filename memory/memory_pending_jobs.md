# memory_pending_jobs.md

## Purpose

Track jobs that have been shown in the digest but not yet applied to.
A job will be shown for a maximum of 3 days. After that, it is automatically expired
and removed from future digests permanently.

## Rules

- When a job appears in the digest for the first time, add it here with today's date as `first_shown`.
- Each subsequent day the job appears, increment `times_shown`.
- If `(today - first_shown) >= 3 days` → expire the job — do not show it again, ever.
- If you apply to a job that is in this list, remove it (it is already tracked in memory_applied_jobs.md).
- If a job expires due to the 3-day rule, log `status: expired`, `expiry_reason: time_limit` — never show again.
- If a job is rejected by user feedback ("לא רלוונטי"), log `status: expired`, `expiry_reason: user_feedback`.
  Exception: if the same job URL reappears in a fresh LinkedIn alert (last 24h), reset it to pending and show again.

## Entry format

- job_id: [LinkedIn job URL, or "company__role_title_slug" if no URL available]
- company:
- role_title:
- linkedin_job_url:
- first_shown: [YYYY-MM-DD]
- last_shown: [YYYY-MM-DD]
- times_shown: [number]
- status: pending / expired
- expiry_reason: time_limit / user_feedback / (omit if still pending)

## Pending jobs log

(empty — will be populated automatically by the agent)
