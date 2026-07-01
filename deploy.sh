#!/usr/bin/env bash
# deploy.sh — push the freshly-built public feed (docs/) to GitHub Pages.
# Called by Larry after build_voice_feed.py during a trip-mode routing run, so the live
# site (https://kramermusician.github.io/kramos-voice-feed/) updates while Kramer is away.
# No-ops cleanly if docs/ didn't change. Only ever commits docs/ — the private cards/
# folder is gitignored and never leaves the Mac.
set -u
cd "$(dirname "$0")" || exit 1
git add docs 2>/dev/null
if git diff --cached --quiet 2>/dev/null; then
  echo "[deploy] no new feed changes"
else
  git -c user.name="Kramer Gibson" -c user.email="kramermusician@gmail.com" \
      commit -q -m "feed update $(date -u +%Y-%m-%dT%H:%MZ)" 2>/dev/null
fi
# Push whenever local is ahead of origin — this flushes commits that a previous run made
# but couldn't push (e.g. wifi dropped mid-routing), not just brand-new changes.
ahead=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo 0)
if [ "${ahead:-0}" = "0" ]; then
  echo "[deploy] up to date with origin"; exit 0
fi
if git push -q origin main 2>/dev/null; then
  echo "[deploy] pushed $ahead commit(s) -> https://kramermusician.github.io/kramos-voice-feed/"
else
  echo "[deploy] push failed (offline?) — $ahead commit(s) pending, will flush next run"
fi
