# VibeVoice — voiceover engine

This project uses [Microsoft VibeVoice-Realtime-0.5B](https://huggingface.co/microsoft/VibeVoice-Realtime-0.5B) for voiceover. The model runs locally on your machine (Apple Silicon via MPS, or NVIDIA via CUDA). No API keys, no per-render cost.

## One-time setup

```bash
npm run setup
```

That runs [`setup.sh`](setup.sh) which:
1. Verifies Python 3.10+ (install with `brew install python@3.11` if missing)
2. Clones [microsoft/VibeVoice](https://github.com/microsoft/VibeVoice) into `vendor/VibeVoice/`
3. Creates `.venv-vibevoice/` and installs the `streamingtts` extras
4. Smoke-tests the import

### Costs

| | |
|---|---|
| Disk | ~5–7 GB venv + ~1–2 GB model = **~7–9 GB** |
| First-run time | ~10–15 min (network + install + first model download) |
| Per-generation | ~60–90s on Apple Silicon M-series, ~3–10s on NVIDIA GPU |

`vendor/VibeVoice/` and `.venv-vibevoice/` are gitignored — every teammate runs setup on their own machine.

## Generate narration

After setup:

```bash
npm run tts                                     # default voice: Carter
./.venv-vibevoice/bin/python scripts/vibevoice/generate.py \
  --script lib/voiceover/script.txt \
  --output lib/voiceover/narration.wav \
  --voice Mike                                  # try a different voice
```

Bundled English voices: `Carter`, `Davis`, `Emma`, `Frank`, `Grace`, `Mike`. Multilingual: `de-Spk0_man`, `fr-Spk0_man`, `jp-Spk0_man`, etc. (full list under `vendor/VibeVoice/demo/voices/streaming_model/` after setup).

For more (11 extra English + 9 multilingual, ~600 MB):

```bash
bash vendor/VibeVoice/demo/download_experimental_voices.sh
```

## How it works

[`generate.py`](generate.py) wraps Microsoft's `demo/realtime_model_inference_from_file.py` with two fixes:
1. **Bracket-safe paths** — symlinks the vendor dir into `/tmp/vibevoice-*/` so the demo's `glob.glob()` doesn't choke on the `[Hyperframe x Bright]` brackets in the project path.
2. **PyTorch 2.6+ compatibility** — idempotently patches the demo's `torch.load(weights_only=True)` to `False` so the voice prompt `.pt` files load. (These are trusted Microsoft-shipped files; the safety check is overkill here.)

Both fixes run automatically every time you call `npm run tts`. No manual maintenance.

## Risks

Microsoft's own disclaimer applies to VibeVoice:

> We do not recommend using VibeVoice in commercial or real-world applications without further testing and development. This model is intended for research and development purposes only.

Use responsibly. When shipping AI-generated VO publicly, disclose that the voice is synthetic.

## Uninstall

```bash
rm -rf .venv-vibevoice vendor/VibeVoice
rm -rf ~/.cache/huggingface/hub/models--microsoft--VibeVoice-Realtime-0.5B
```
