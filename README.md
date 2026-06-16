# LinkedIn Job Agent — Daily Digest via Claude Code

Every morning at 8:00 AM, this agent wakes up, reads the LinkedIn job alert emails in your Gmail, scores each job against your CV and preferences, and sends you a clean summary email — with a match score, key requirements, and a relevant contact person at each company.

You set it up once. After that, it runs on its own every day.

**No coding required. Works on Windows 10 / 11.**

---

## What it does

- Reads LinkedIn job alert emails that arrived in the last 24 hours
- Scores each job from 1 to 10 based on your CV and what you're looking for
- Skips jobs you already applied to (detects this automatically from your Gmail)
- Skips jobs that are no longer accepting applications
- Sends you a daily email digest at 8:00 AM in Hebrew
- Learns from your feedback — reply to the email with a note, and the agent will act on it the next morning
- Stops showing you a job after 3 days if you haven't applied to it

---

## What you need before starting

| What | Why |
|---|---|
| Windows 10 or 11 | The agent uses Windows-only tools to run automatically |
| A LinkedIn account | With job alerts set up (see Part 2 below) |
| A Gmail account | The agent reads your job alerts from Gmail and sends the digest there |
| 2-Step Verification on Gmail | Required to create an App Password (see Part 3 below) |
| An Anthropic account (free) | To use Claude, the AI that powers the agent |
| About 20–30 minutes | For the one-time setup |

---

## Setup — Step by step

### Part 1 — Install the required software

You need to install 3 small programs. You only do this once.

---

#### 1a — Install Git

Git is a tool that lets you download projects from GitHub (the site you're on right now).

1. Go to [git-scm.com/download/win](https://git-scm.com/download/win)
2. The download will start automatically — run the installer
3. Click **Next** on every screen (the default settings are fine)
4. When it finishes, close the installer

---

#### 1b — Install Node.js

Node.js is a program that lets you install developer tools, including Claude Code.

1. Go to [nodejs.org](https://nodejs.org)
2. Click the big green button that says **LTS** (recommended version)
3. Run the installer — click **Next** on every screen
4. When it finishes, close the installer

---

#### 1c — Install Claude Code and log in

Claude Code is the AI engine that powers this agent. It's a small program that runs in the background.

1. Click the **Start** button (Windows logo, bottom left)
2. Search for **PowerShell** and click on it to open it
3. Type the following and press **Enter**:
   ```
   npm install -g @anthropic-ai/claude-code
   ```
4. Wait for it to finish (takes 1–2 minutes)
5. Then type this and press **Enter**:
   ```
   claude login
   ```
6. A browser window will open — sign in with your Anthropic account (or create a free one at [anthropic.com](https://anthropic.com))
7. Once logged in, you can close the browser — Claude Code is ready

---

### Part 2 — Set up LinkedIn job alerts

The agent reads the job alert emails that LinkedIn sends you. If you haven't set these up yet:

1. Go to [linkedin.com](https://linkedin.com) and sign in
2. Click **Jobs** in the top menu
3. Search for the types of roles you're looking for (e.g. "Product Manager Israel")
4. Click **Set alert** — LinkedIn will start emailing you new jobs matching that search
5. You can create multiple alerts for different role types or locations

---

### Part 3 — Set up Gmail

#### 3a — Enable 2-Step Verification

If you already have 2-Step Verification (also called "2-factor authentication") enabled on your Google account, skip to 3b.

1. Go to [myaccount.google.com/security](https://myaccount.google.com/security)
2. Under "How you sign in to Google", click **2-Step Verification**
3. Follow the steps to turn it on (usually takes 2 minutes)

---

#### 3b — Get a Gmail App Password

An App Password is a special one-time code that Google generates for you. It lets the agent send emails through your Gmail account without using your regular password. Think of it as a separate key that works only for this purpose.

1. Go to [myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)
2. Sign in with your Gmail account if asked
3. In the text box, type a name like **Job Agent** and click **Create**
4. Google will show you a 16-character code — it looks like: `abcd efgh ijkl mnop`
5. **Copy this code right now** — Google will never show it again
6. Keep it somewhere safe until the setup wizard asks for it (Part 5 below)

---

### Part 4 — Connect Gmail to Claude

This step allows Claude to read your Gmail inbox (to find job alerts and feedback replies).

1. Go to [claude.ai](https://claude.ai) and sign in
2. Click your profile icon (top right) → **Settings**
3. Go to **Integrations**
4. Find **Gmail** and click **Connect**
5. Follow the steps to allow access

---

### Part 5 — Download and run the agent

#### 5a — Download the project

**Option A — Download as ZIP (easier, no Git required):**
1. On this page, click the green **Code** button (top right of the file list)
2. Click **Download ZIP**
3. Find the downloaded ZIP file (usually in your Downloads folder)
4. Right-click it → **Extract All** → choose where to save it → **Extract**

**Option B — Use Git (if you installed it in Part 1):**
1. Open PowerShell (search "PowerShell" in the Start menu)
2. Type the following and press Enter:
   ```
   git clone https://github.com/arielsapir-cell/Find-Me-A-Job-Agent.git
   ```
3. The project folder will be created in your current location

---

#### 5b — Run the setup wizard

The setup wizard will guide you through everything — adding your CV, setting your preferences, entering your details, and scheduling the daily run.

1. Open the project folder you just downloaded
2. Hold **Shift** and **right-click** anywhere inside the folder (on an empty area)
3. Click **Open PowerShell window here** (or "Open in Terminal")
4. Type the following and press Enter:
   ```
   .\setup.ps1
   ```
5. The wizard will now guide you step by step:
   - It will open a folder — **drag your CV (PDF file) into it**, then come back and press Enter
   - It will open a text file in Notepad — **edit it to match your job preferences**, save it, and close Notepad
   - It will ask for your **name** and **Gmail address**
   - It will ask for the **App Password** you copied in Part 3b — paste it here
   - It will ask if you want to schedule the daily run at 8:00 AM — type **Y** and press Enter

That's it. The agent is now set up and will run every morning automatically.

> **If your computer is off at 8:00 AM:** no problem. The agent will run automatically the next time you turn your computer on and log in. You won't miss a day.

---

## Daily use

You don't need to do anything. Every morning you'll receive an email with the day's job matches.

**To test it right now** (without waiting until tomorrow morning):

1. Open the project folder
2. Hold Shift and right-click → **Open PowerShell window here**
3. Type the following and press Enter:
   ```
   .\run_job_agent.ps1
   ```
4. The agent will run and send you an email within a few minutes

---

## How to give feedback

Just reply to the digest email — in Hebrew or English. The agent will read your reply the next morning and act on it.

**Examples of what you can write:**
- "The [Company] job isn't relevant, please remove it" — the agent will never show it again
- "You were right about [Company X], I'm interested" — logged as a positive signal
- "I'm not interested in B2B roles" — applied to future scoring

The next day's email will include a note confirming what was done with your feedback.

---

## How jobs are scored

Each job gets a score from 1 to 10 based on:

- How well the job title and description match your target roles (from `job_preferences.yaml`)
- How well the requirements match your CV
- Whether the location works for you
- Whether the company type matches your preferences (B2C, B2B, etc.)
- Whether the seniority level is realistic for you

**Only jobs scoring 6 or higher appear in the digest.**
A score of 8–10 is marked as "התאמה מצוינת" (excellent fit).

---

## What's in the project folder

Once you download the project, you'll see these files and folders:

```
├── setup.ps1                ← run this once to set everything up
├── run_job_agent.ps1        ← the agent itself (runs automatically every morning)
├── config/
│   ├── user_config.yaml     ← your name and email (filled in during setup)
│   └── job_preferences.yaml ← your target roles and preferences (opened in Notepad during setup)
├── Skills/                  ← how the agent scores and writes job summaries (no need to edit)
├── memory/
│   ├── memory_applied_jobs.md    ← jobs you applied to (updated automatically)
│   ├── memory_pending_jobs.md    ← tracks the 3-day reminder limit (updated automatically)
│   └── memory_user_feedback.md  ← feedback from your email replies (updated automatically)
├── cv/
│   └── CV.pdf               ← your CV (you add this during setup)
└── output/
    └── daily_digest_YYYY-MM-DD.md  ← saved copy of each day's digest
```

You only ever need to touch: `cv/` (your CV) and `config/job_preferences.yaml` (your preferences). Everything else is managed automatically.

---

## Privacy & security

- Your CV, email address, and App Password **never leave your computer**
- The App Password is encrypted using Windows' built-in security (DPAPI) — only your user account on your machine can decrypt it
- The daily digests and your job history are saved locally and are not uploaded anywhere
- Nothing is ever sent to LinkedIn, recruiters, or third parties

---

## Limitations

- Windows 10 / 11 only
- Requires an Anthropic account (Claude Code)
- Works based on LinkedIn job alert emails — you need alerts set up in your LinkedIn account
- The daily digest is in Hebrew by default

---

## License

MIT
