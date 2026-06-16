---
name: job-matching-skill
description: Evaluate whether a job is a good fit for the candidate based on their CV, preferred titles, geography, seniority, company type, and adjacent role flexibility.
---

# Job Matching Skill

## Goal

Score each job from 1 to 10 based on how well it matches the candidate's background, preferences, and realistic fit.
Read the candidate's CV from the /cv folder and their preferences from config/job_preferences.yaml before scoring.

## Use this skill when

- A new job posting is found
- A company career page includes potentially relevant roles
- The agent needs to decide whether to include a role in the daily report

## Matching logic

### Strong positive signals

- Title and responsibilities align with target_job_families in job_preferences.yaml
- Responsibilities match the candidate's past work and CV
- Preferred geography or remote policy matches
- Company type matches preferred_company_types in job_preferences.yaml
- Responsibilities include skills prominently featured in the candidate's CV

### Moderate positive signals

- Adjacent roles that still fit the candidate's profile
- Senior titles outside the primary track, if the requirements are still reasonable
- Relevant companies outside preferred company types, if the role itself is strong

### Negative signals

- Strongly technical requirements not present in the candidate's CV
- Clear mismatch to excluded role families (sales, engineering, customer success, etc.)
- Relocation required when allow_relocation is false
- Very senior expectations clearly beyond the candidate's experience
- Irrelevant role family

## Seniority rules

Follow the seniority_rules defined in config/job_preferences.yaml.
If seniority is unclear from the posting, score based on responsibilities and requirements, not the title.
If a role seems above the candidate's current level but the requirements are still achievable, note this briefly in the summary rather than excluding the role outright.

## Score interpretation

| Score | Meaning |
|-------|---------|
| 8–10 | Excellent fit — include, use "התאמה מצוינת" in the summary |
| 6–7  | Relevant but not perfect — include, note partial fit |
| 1–5  | Low relevance — do not include in digest |
