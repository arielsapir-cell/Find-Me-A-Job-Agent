---
name: recruiter-search-skill
description: Find an active recruiter or talent acquisition person at a specific company using LinkedIn public search.
---

# Recruiter Search Skill

## Goal

Find one real person currently working in a recruiting or HR role at a specific company.
Return their name, current title, and LinkedIn profile URL.

## Who to look for

Target people whose **current** title includes one of the following (or close equivalent):
- Recruiter / Senior Recruiter / Tech Recruiter
- Talent Acquisition (Manager / Specialist / Partner / Lead)
- HR Manager / HR Business Partner
- People & Culture (Manager / Partner)
- Head of HR / VP People / Chief People Officer (if no recruiter found)

Do NOT return:
- People whose role at this company is in the past (former employees)
- People pulled from the job description or the candidate's own connections
- Generic names with no LinkedIn URL to verify

## Search strategy

Try in order, stop when a result is found:

### Step 1 — WebFetch on LinkedIn company people page
Fetch: `https://www.linkedin.com/company/[company-slug]/people/`
Look for people listed under HR / Talent Acquisition / Recruiting filters.

### Step 2 — Google search
Query: `site:linkedin.com/in "[Company Name]" recruiter OR "talent acquisition" OR "HR manager"`
Pick the first result where the person's current company matches and their title is recruiting-related.

### Step 3 — Google broader search
Query: `"[Company Name]" recruiter site:linkedin.com`
Same criteria as Step 2.

### Step 4 — Fallback
If no recruiter found after all steps, return: `"לא נמצא איש קשר"`
Do not invent a name or return an unverified result.

## Output format

If found:
```
👤 [Full Name] — [Current Title] at [Company]
🔗 linkedin.com/in/[profile-slug]
```

If not found:
```
לא נמצא איש קשר
```
