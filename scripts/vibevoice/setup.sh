#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════════
#  VibeVoice-Realtime-0.5B — one-time setup
#  ──────────────────────────────────────────────────────────────────────
#  Opt-in higher-quality TTS engine. Run this once per machine, then
#  generate narration with: `npm run tts:vibevoice`.
#
#  Costs:
#    • Disk:   ~5–7 GB venv + ~1–2 GB model = ~7–9 GB
#    • Time:   ~10–15 min on first run (download + install)
#    • Per-gen: ~10–60s on Apple Silicon (M2+), ~3–10s on NVIDIA GPU
#
#  Prereqs:
#    • macOS (Apple Silicon recommended) or Linux with NVIDIA GPU
#    • Python 3.10+ (`brew install python@3.11` if missing)
#    • git
#    • ffmpeg (`brew install ffmpeg` if missing)
# ════════════════════════════════════════════════════════════════════════
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
VENDOR_DIR="$PROJECT_ROOT/vendor/VibeVoice"
VENV_DIR="$PROJECT_ROOT/.venv-vibevoice"

# ─── 1. Python version check ──────────────────────────────────────────
PYTHON_BIN=""
for candidate in python3.12 python3.11 python3.10 python3; do
  if command -v "$candidate" >/dev/null 2>&1; then
    PY_VER=$("$candidate" -c 'import sys; print(f"{sys.version_info[0]}.{sys.version_info[1]}")')
    if [ "$(printf '%s\n%s\n' "3.10" "$PY_VER" | sort -V | head -1)" = "3.10" ]; then
      PYTHON_BIN="$candidate"
      break
    fi
  fi
done

if [ -z "$PYTHON_BIN" ]; then
  echo "[vibevoice-setup] ERROR: Python 3.10+ not found. Install with: brew install python@3.11"
  exit 1
fi
echo "[vibevoice-setup] Using $PYTHON_BIN ($("$PYTHON_BIN" --version))"

# ─── 2. Clone VibeVoice repo ──────────────────────────────────────────
if [ ! -d "$VENDOR_DIR/.git" ]; then
  echo "[vibevoice-setup] Cloning VibeVoice into vendor/VibeVoice ..."
  mkdir -p "$(dirname "$VENDOR_DIR")"
  git clone --depth 1 https://github.com/microsoft/VibeVoice.git "$VENDOR_DIR"
else
  echo "[vibevoice-setup] VibeVoice repo already present, pulling latest ..."
  (cd "$VENDOR_DIR" && git pull --ff-only)
fi

# ─── 3. Create + populate venv ────────────────────────────────────────
if [ ! -d "$VENV_DIR" ]; then
  echo "[vibevoice-setup] Creating venv at .venv-vibevoice ..."
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

echo "[vibevoice-setup] Upgrading pip ..."
pip install --quiet --upgrade pip

echo "[vibevoice-setup] Installing VibeVoice (streamingtts extras) — this can take 5–10 min ..."
pip install --quiet -e "$VENDOR_DIR[streamingtts]"

# ─── 4. Smoke test ────────────────────────────────────────────────────
echo "[vibevoice-setup] Verifying install ..."
python -c "import torch; from vibevoice.modular.modeling_vibevoice_streaming_inference import VibeVoiceStreamingForConditionalGenerationInference; print(f'OK — torch {torch.__version__}, MPS available: {torch.backends.mps.is_available()}')"

echo ""
echo "[vibevoice-setup] ✅ Done. Generate narration with:"
echo "    npm run tts:vibevoice"
echo ""
echo "[vibevoice-setup] Default voice: Carter. To list available voices:"
echo "    ls vendor/VibeVoice/demo/voices/streaming_model/"
echo ""
echo "[vibevoice-setup] To add experimental multilingual + extra English voices (~600 MB):"
echo "    bash vendor/VibeVoice/demo/download_experimental_voices.sh"
