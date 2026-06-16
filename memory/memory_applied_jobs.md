# memory_applied_jobs.md

## Purpose

Track jobs you applied to, especially jobs previously suggested by the agent.
Use this file as a feedback source to improve future job matching.

## Entry format

- date:
- company:
- role_title:
- linkedin_job_url:
- company_careers_url:
- source:
  - linkedin_jobs
  - linkedin_post
  - company_careers
- applied_confirmed_via:
  - linkedin
  - email
  - manual
  - user_feedback
- was_previously_recommended_by_agent: yes/no
- agent_match_score:
- excellent_fit_at_time_of_recommendation: yes/no
- notes:

## Meaning

If `was_previously_recommended_by_agent = yes`, treat this as positive preference feedback for similar future roles.

If `applied_confirmed_via = email`, use email confirmation as a valid signal that you applied, even if LinkedIn does not show an Applied status.

If `applied_confirmed_via = user_feedback`, you explicitly told the agent to remove this job via email reply — do not show it again.

If `excellent_fit_at_time_of_recommendation = yes`, strengthen the matching preference for similar jobs in the future.

## Applied jobs log

(empty — will be populated automatically by the agent)
