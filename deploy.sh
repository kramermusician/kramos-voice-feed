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
  echo "[deploy] no feed changes"; exit 0
fi
git -c user.name="Kramer Gibson" -c user.email="kramermusician@gmail.com" \
    commit -q -m "feed update $(date -u +%Y-%m-%dT%H:%MZ)" 2>/dev/null
if git push -q origin main 2>/dev/null; then
  echo "[deploy] pushed -> https://kramermusician.github.io/kramos-voice-feed/"
else
  echo "[deploy] push failed (offline?) — will sync next run"
fi
