# Voiceover

Both files in this folder are checked in:
- `script.txt` — the narration script (edit this, then regenerate)
- `narration.wav` — the rendered audio (wired into `index.html` as the VO track)

## Regenerate after editing the script

```bash
npm run tts
```

Writes a fresh `narration.wav`. The HTML wiring already points at this path, so reload the studio after regenerating.

## Engine

VibeVoice-Realtime-0.5B (Carter voice) via local inference on Apple Silicon (MPS) or NVIDIA (CUDA).

**Requires a one-time setup** — see [`../../scripts/vibevoice/README.md`](../../scripts/vibevoice/README.md) for the install command, hardware costs, and how to switch voices (Davis, Frank, Mike, Emma, Grace, etc.).

## Timing budget

- Total video duration: 25.44s
- VO budget: 0–22.6s (outro MP4 covers the last 2.84s)
- Current VO render: ~22.5s
- If you edit the script and it overruns 22.6s, update `data-duration` on the `#voiceover` element in `index.html` and shift the outro accordingly.

## Script-writing voice (from DESIGN.md)

> "Reliable, smart friend" — friendly but authoritative, never talking down.

- Use contractions: *we're, you'll, it's*
- Open with a hook in the first 3 seconds
- Economy of words — silence is a feature
- American vernacular only
- No formal openings ("Welcome to…")

⚠️ VibeVoice note: short inputs of 3 words or fewer can degrade stability. The current script's shortest line is "Meet Brokk." (2 words) — if it sounds off, expand it.
