#!/usr/bin/env python3
"""Inline a cue from audio-src/ into seventeenth-day.html as a data: URI.

The Artifact CSP blocks every external host, so any cue that must work in the
artifact has to live inside the page. Files left in audio/ are served normally
by Netlify instead (deploy.sh stages those and flips AUDIO_ON).

  ./inline-audio.py transform      # inlines audio-src/transform.mp3
"""
import base64, io, re, sys, os

slot = sys.argv[1] if len(sys.argv) > 1 else 'transform'
src  = os.path.join('audio-src', slot + '.mp3')
if not os.path.exists(src):
    sys.exit('no such file: ' + src)

raw = open(src, 'rb').read()
uri = 'data:audio/mpeg;base64,' + base64.b64encode(raw).decode('ascii')

p = 'seventeenth-day.html'
s = io.open(p, encoding='utf-8').read()
pat = re.compile(r"(\n  " + slot + r":\s*)'[^']*'(,?)")
if not pat.search(s):
    sys.exit('slot not found in AUDIO_SRC: ' + slot)
s = pat.sub(lambda m: m.group(1) + "'" + uri + "'" + m.group(2), s, count=1)
io.open(p, 'w', encoding='utf-8').write(s)
print('inlined %s  %d KB raw -> %d KB base64' % (slot, len(raw)//1024, len(uri)//1024))
