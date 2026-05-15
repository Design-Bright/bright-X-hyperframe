# Voiceover

Two files live in this folder:
- `script.txt` — your narration script (edit this, then regenerate)
- `narration.wav` — the rendered audio (gitignored once first generated; wire it into `index.html` as the VO track)

On a fresh clone, only `script.txt` exists. Run `npm run setup` once, then `npm run tts` to produce `narration.wav`.

## Workflow

```bash
# 1. Edit your script
$EDITOR lib/voiceover/script.txt

# 2. Regenerate the WAV
npm run tts

# 3. (first time only) Uncomment the <audio id="voiceover"> block in
#    index.html so the timeline picks up the file.
```

## Engine

VibeVoice-Realtime-0.5B (default voice: `Carter`) via local inference on Apple Silicon (MPS) or NVIDIA (CUDA).

**Requires `npm run setup` first.** See [`../../scripts/vibevoice/README.md`](../../scripts/vibevoice/README.md) for install costs, hardware requirements, and how to switch voices (Davis, Frank, Mike, Emma, Grace, etc.).

## Timing

Your VO duration drives your timeline. After regenerating, check the WAV duration:

```bash
python3 -c "import wave; w=wave.open('lib/voiceover/narration.wav'); print(f'{w.getnframes()/w.getframerate():.2f}s')"
```

Then update in `index.html`:
- The `<audio id="voiceover">` element's `data-duration`
- The root `data-duration` and bg-music `data-duration` (must cover VO + outro)
- The outro `data-start` (so it begins after VO ends)

## Script-writing voice (from DESIGN.md)

> "Reliable, smart friend" — friendly but authoritative, never talking down.

- Use contractions: *we're, you'll, it's*
- Open with a hook in the first 3 seconds
- Economy of words — silence is a feature
- American vernacular only
- No formal openings ("Welcome to…")

⚠️ VibeVoice note: short inputs of 3 words or fewer can degrade stability. Keep lines at 4+ words when possible, or expand short ones.
