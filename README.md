# The Seventeenth Day

A turn-based astra duel between **Karna** and **Arjuna**, staged as a 1988
Doordarshan broadcast.

**▶ Play it: https://the-seventeenth-day.netlify.app**

Kurukshetra, day seventeen. Pick a side and fight the duel out on a CRT that
hasn't been switched off since 1988 — canopy, chariots, four white horses,
Krishna at the reins, and Samay narrating over the lower third.

---

## The premise

This is a **Karna-sympathetic retelling**. It sits in the tradition of Shivaji
Sawant's *Mrityunjaya* and Dinkar's *Rashmirathi*: Karna as the wronged and
truthful one, and the side that wins as the side that broke its own rules.

The mechanics carry the argument rather than decorating it:

- **The curses only fire once Karna is ahead.** When Arjuna drops to 9 HP the
  earth takes Karna's chariot wheel, Parashurama's curse deletes Bhargavastra
  from his memory, and Arjuna — invited to shoot a man standing on the ground
  with both hands full of chariot — becomes **Mahā-Arjuna**.
- Arjuna is clamped at 9 HP and **cannot die before that happens**. The
  set-piece is the point of the game.
- Karna is compensated, not rescued: Surya breaks his own rule and hands him
  **Adityastra**, three throws at roughly 4× his (now weakened) volley. He can
  still win. It is simply much harder.
- The select screen makes the case before a shot is fired: identical archery,
  and Karna's Fortune is 1 against Arjuna's 5.

## Combat

Simultaneous resolution, played back one shot at a time. Counters come from the
text, not from balance tuning — Varuna answers Agni, **Garuda eats the serpent**,
Parvata stops Vayu, and only a Brahmastra meets a Brahmastra.

Every astra flies as itself: Nagastra uncoils with a fanged head, Bhargavastra
multiplies into three flaming shafts, and the divine weapons are two to three
times larger with barbed heads.

**Vasavi Shakti** is Karna's alone and takes **half the target's current health,
immediately**, ignoring every damage reduction — devastating opening, weak as a
finisher. Krishna's Counsel evades it outright, which is exactly how Arjuna
survives Ashwasena in the epic.

## Running it locally

No build step, no dependencies. `seventeenth-day.html` is the whole game.

```bash
python3 -m http.server 8731
# then open http://localhost:8731/seventeenth-day.html
```

## Deploying

`./deploy.sh` wraps the page in a real document (viewport, description, OG tags),
stages anything in `audio/`, and pushes to Netlify. Requires the Netlify CLI,
authenticated.

## Sound

`audio/README.md` lists the eight optional cue slots (`title`, `battle`, `sink`,
`transform`, `victory`, `defeat`, `shoot`, `impact`). **Every one is optional** —
a missing cue is silently skipped and the game plays identically without it.

The transformation cue is embedded in the HTML as a base64 data URI rather than
served as a file, because it also has to work inside a sandbox that blocks
external hosts. `./inline-audio.py <slot>` regenerates that from `audio-src/`.

The middle knob on the cabinet is a real volume control — off / low / full,
remembered between visits.

## Layout

```
seventeenth-day.html   the entire game — markup, CSS, SVG art, engine, audio
deploy.sh              build + publish to Netlify
inline-audio.py        embed an audio cue as a data URI
audio/                 optional cue files (see its README)
audio-src/             masters, kept out of the deploy
```

## Licence

MIT for the code and artwork. **The audio clip is not covered** — see `LICENSE`.
