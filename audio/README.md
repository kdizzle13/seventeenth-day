# Audio for The Seventeenth Day

Drop files in this folder with these exact names. **Every one is optional** — any
cue you don't supply simply stays silent; the game runs identically without it.

| file            | when it plays                                   | loops |
|-----------------|-------------------------------------------------|-------|
| `title.mp3`     | from the Begin click, over the character select  | yes   |
| `battle.mp3`    | bed under the duel                               | yes   |
| `sink.mp3`      | the chariot wheel goes into the earth            | no    |
| `transform.mp3` | signal loss / Mahā-Arjuna                        | no    |
| `victory.mp3`   | ending — Karna is left standing                  | no    |
| `defeat.mp3`    | ending — Arjuna is left standing                 | no    |
| `shoot.mp3`     | bowstring release, every shot                    | no    |
| `impact.mp3`    | an astra lands                                   | no    |

`.mp3` is safest for cross-browser. `.m4a`/`.ogg` also work — if you use a
different extension, say so and the filenames in `AUDIO_SRC` get updated.

Notes
- The two beds are ducked automatically under the sink and transformation cues.
- `shoot`/`impact` fire on every exchange, so keep them short and dry.
- Levels are already balanced in `AUDIO_CFG` (beds quiet, stingers forward);
  tell me if anything sits too hot or too low.
- Then run `./deploy.sh` — it copies this folder into `dist/` and pushes live.
