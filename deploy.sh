#!/usr/bin/env bash
# Rebuild dist/index.html from seventeenth-day.html and push it live to Netlify.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p dist

python3 - <<'PY'
import io
src = io.open('seventeenth-day.html', encoding='utf-8').read()
cut = src.index('</style>') + len('</style>')
style = src[:cut][src[:cut].index('<style>'):]
body = src[cut:].strip()
TITLE = "The Seventeenth Day"
DESC  = "Kurukshetra, day seventeen. Pick a side — Karna or Arjuna — and fight the duel out as a 1988 Doordarshan broadcast."
FAV   = "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ctext y='.9em' font-size='90'%3E%F0%9F%8F%B9%3C/text%3E%3C/svg%3E"
io.open('dist/index.html','w',encoding='utf-8').write(f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>{TITLE}</title>
<meta name="description" content="{DESC}">
<meta name="theme-color" content="#0B0704">
<meta name="color-scheme" content="dark">
<link rel="icon" href="{FAV}">
<meta property="og:type" content="website">
<meta property="og:title" content="{TITLE}">
<meta property="og:description" content="{DESC}">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{TITLE}">
<meta name="twitter:description" content="{DESC}">
{style}
</head>
<body>
{body}
</body>
</html>
""")
print('built dist/index.html')
PY

# ship any audio cues alongside the page
if [ -d audio ]; then
  mkdir -p dist/audio
  find audio -maxdepth 1 -type f \( -iname '*.mp3' -o -iname '*.m4a' -o -iname '*.ogg' -o -iname '*.wav' \) \
    -exec cp {} dist/audio/ \; 2>/dev/null || true
  n=$(ls dist/audio 2>/dev/null | wc -l | tr -d ' ')
  echo "audio files staged: $n"
  if [ "$n" -gt 0 ]; then
    # turn the sound engine on only when there is actually something to play
    sed -i '' 's/var AUDIO_ON = false;/var AUDIO_ON = true;/' dist/index.html
    echo "sound engine: ON"
  else
    echo "sound engine: off (audio/ is empty)"
  fi
fi

netlify deploy --prod --dir=dist --site=352cd0e0-f0ad-4705-9ab8-0dda1974b380
