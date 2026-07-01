# Voice Feed — site-as-inbox for the voice pipeline

A single phone-readable web page that lists every recent voice-pipeline response,
newest-first, each rendered inline. Replaces the folder-of-PDFs experience: instead of
hunting through `trip-pdfs/`, you open one page and read your latest requests
("history of this village", "haircut vocabulary", etc.). A card appearing is also your
confirmation that a memo was received and processed.

## How it works

1. During trip mode, Larry writes one markdown **card** per response into
   `~/Dropbox/KRAMOS/trip-feed/cards/<date>-<slug>.md` (frontmatter: title, date, time,
   type, outcome, optional `pdf:`; body = the answer).
2. Larry runs `python3 scripts/utilities/build_voice_feed.py`, which rebuilds:
   - `~/Dropbox/KRAMOS/trip-feed/index.html` — **private, Dropbox-synced to your phone**
   - `docs/index.html` (this folder) — git-ready copy for optional GitHub Pages.

## Reading it on your phone (MVP, private, zero setup)

`~/Dropbox/KRAMOS/trip-feed/index.html` syncs to your phone via Dropbox. Open it once in
the Dropbox app and, better, create a **Dropbox shared link** to that file — the link
renders as a live web page in your phone browser and you can bookmark it. This stays
private to your account; nothing is published.

## Optional: GitHub Pages (a real bookmarkable URL) — needs your go-ahead

Kramer asked for "an ongoing GitHub website." That's a one-command deploy from `docs/`,
**but read this first:**

> ⚠️ **Privacy (Sage's gate).** Your voice responses can include personal, journal, or
> even student-adjacent content. GitHub Pages on a free repo is **public** — anyone with
> the URL can read it. Do **not** publish the raw feed publicly. Options, safest first:
> 1. **Stay on Dropbox-private** (the MVP above). Recommended.
> 2. **Private repo + Pages** (GitHub Pro): a private Pages site behind your GitHub login.
> 3. **Public Pages, but filtered**: only publish `type: travel` / `type: research`
>    cards (never journal/personal), and treat the URL as semi-secret. Larry can tag
>    cards so the generator can exclude sensitive types — ask for the filter flag.

To deploy once you've chosen a safe option:

```bash
cd "Owner's Inbox/coding projects/voice-feed"
git init && git add docs && git commit -m "voice feed"
# create the repo (private recommended) and push:
gh repo create kramos-voice-feed --private --source=. --push
# then enable Pages on the docs/ folder in repo settings
```

## Endpoint

Done when: from Spain, you open one bookmarked page on your phone and see your recent
voice requests rendered and readable, without opening individual PDFs. Shipping via
Dropbox-private now; GitHub Pages is the opt-in upgrade.
