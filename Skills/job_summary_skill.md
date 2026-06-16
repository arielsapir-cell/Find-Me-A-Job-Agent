---
name: job-summary-skill
description: Write a full Hebrew entry for each qualifying job, including company description, role focus, requirements, fit analysis, match score, LinkedIn URL, and contact person.
---

# Job Summary Skill

## Goal

Write a complete, structured Hebrew entry for each job that passes the score threshold.

## Required fields — every job must include ALL of these

1. **Header**: Company name and role title (as a bold or heading line)
2. **Four separate Hebrew lines** — each on its own line with a blank line between them:
   - Line 1: What the company does and who it serves
   - Line 2: What the role focuses on
   - Line 3: Main requirements
   - Line 4: Why this fits the candidate, or why the fit is partial
3. **Match score**: written as "ציון: X/10". Use "— התאמה מצוינת" only for scores 8-10. For scores 6-7, describe as relevant or partially relevant — do not use "התאמה מצוינת".
4. **LinkedIn job URL**: direct link to the job posting
5. **Contact person**: name + LinkedIn profile URL if found. If not found after searching, write exactly: "לא נמצא איש קשר". This field is mandatory — never omit it.

## Contact person search

- Before writing the summary, search LinkedIn for a recruiter, HR professional, or hiring manager at the company.
- Prefer someone whose title includes: Talent Acquisition, Recruiter, HR, People, or the relevant department head.
- Only include a contact if found with a real LinkedIn profile URL.
- Do not invent names or URLs.
- If no contact is found, write "לא נמצא איש קשר".

## Writing rules

- Each of the 4 Hebrew lines is a separate paragraph (blank line between them). No mixing of sections in one block.
- English terms (like "B2C", "lifecycle", "Braze") may appear inside Hebrew sentences — but keep each sentence short so direction does not break visually.
- Max 1-2 sentences per line/section.
- If both LinkedIn and company careers links exist, use the LinkedIn URL as the primary link.
- Keep tone practical, direct, and not overly enthusiastic.
- Do not exaggerate fit. If fit is partial, say so clearly and explain why.
- If job information is incomplete or could not be fetched, note this briefly in the relevant line.
- Do not invent company facts, requirements, or job details.
- No WhatsApp output.

## Output structure per job

```
### [Company name] — [Role title]
ציון: X/10 [— התאמה מצוינת | (nothing for 6-7)]
מיקום: [city] | פורסם: [date]

[Line 1 — company description: what the company does and who it serves.]

[Line 2 — role focus: what the role focuses on.]

[Line 3 — requirements: main requirements.]

[Line 4 — fit: why this fits the candidate, or why partial.]

קישור: [LinkedIn job URL]
איש קשר: [Name — LinkedIn URL] / לא נמצא איש קשר
```

## Output example

```
### Helfy — Retention Marketing Manager
ציון: 9/10 — התאמה מצוינת
מיקום: הרצליה | פורסם: 11.6.2026

Helfy היא פלטפורמת טלה-רפואה B2C המספקת טיפולים ותרופות למטופלים מרחוק.

התפקיד מתמקד בניהול אסטרטגיית retention ו-lifecycle — הפחתת churn, הגדלת LTV וניהול תוכניות VIP ו-referral.

הדרישות כוללות 3+ שנות ניסיון ב-retention marketing ב-B2C, עבודה עם Braze או Klaviyo, ניתוח cohorts וניהול A/B tests.

זהו תפקיד שמתאים מצוין לפרופיל — הפוקוס על retention, lifecycle וניסויים הוא בדיוק הליבה של הניסיון הרלוונטי.

קישור: https://www.linkedin.com/jobs/view/4386742844/
איש קשר: Dana Gershon (HR & Talent Acquisition, Helfy) — https://www.linkedin.com/in/dana-gershon/
```
