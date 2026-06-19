#!/usr/bin/env bash
#
# Update the resume shown on the site, then deploy to GitHub Pages.
#
# Usage:
#   ./update-resume.sh [path-to-new-resume.pdf]
#
# With no argument it picks up ~/Downloads/Ma_Resume.pdf.
# The site always links to assets/Kevin_Ma_Resume.pdf (a stable path),
# so the URL never changes — you just swap the file and push.
#
set -euo pipefail
cd "$(dirname "$0")"

SRC="${1:-$HOME/Downloads/Ma_Resume.pdf}"
DEST="assets/Kevin_Ma_Resume.pdf"

if [ ! -f "$SRC" ]; then
  echo "❌ Resume not found: $SRC"
  echo "   Pass the path explicitly, e.g.: ./update-resume.sh ~/Downloads/MyResume.pdf"
  exit 1
fi

cp "$SRC" "$DEST"
git add "$DEST"

if git diff --cached --quiet; then
  echo "✔ Resume is already up to date — nothing to deploy."
  exit 0
fi

git commit -qm "Update resume ($(date +%Y-%m-%d))"
git push -q origin main
echo "✅ Resume updated and deployed → https://kevinma0215.github.io/$DEST"
echo "   (GitHub Pages refreshes in ~1 minute; hard-refresh to see it.)"
