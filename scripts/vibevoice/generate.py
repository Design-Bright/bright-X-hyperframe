#!/usr/bin/env python3
"""Wrap VibeVoice-Realtime-0.5B inference to produce a single output WAV at a
known path. Called from `npm run tts:vibevoice`; do not run directly without
activating the .venv-vibevoice virtual environment first.

Usage:
    python scripts/vibevoice/generate.py \\
        --script lib/voiceover/script.txt \\
        --output lib/voiceover/narration.wav \\
        --voice Carter

Path-safety: this project's directory contains "[Hyperframe x Bright]". The
brackets are glob metacharacters and the demo script's VoiceMapper uses
glob.glob() which silently returns zero matches for paths containing them.
Workaround: symlink the vendored repo into a bracket-free /tmp dir and run
the demo from there. The HF model cache (~/.cache/huggingface) is already
bracket-free so model loading itself is fine.
"""
from __future__ import annotations

import argparse
import glob
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[2]
VENDOR_DIR = PROJECT_ROOT / "vendor" / "VibeVoice"


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="VibeVoice TTS wrapper")
    p.add_argument("--script", required=True, help="Path to the narration .txt file")
    p.add_argument("--output", required=True, help="Path where the WAV should be written")
    p.add_argument(
        "--voice",
        default="Carter",
        help="Speaker name (default: Carter). Bundled English voices: Carter, Davis, Emma, Frank, Grace, Mike."
    )
    return p.parse_args()


def main() -> int:
    args = parse_args()

    if not VENDOR_DIR.exists():
        sys.exit(
            "[vibevoice] FATAL: vendor/VibeVoice not found. "
            "Run `bash scripts/vibevoice/setup.sh` first."
        )

    # ── Idempotent patch: torch>=2.6 defaults weights_only=True, which rejects
    # the voice prompt .pt files (they contain BaseModelOutputWithPast). The
    # voices are from Microsoft's official repo so loading them is trusted.
    demo_file = VENDOR_DIR / "demo" / "realtime_model_inference_from_file.py"
    text = demo_file.read_text()
    if "weights_only=True" in text:
        demo_file.write_text(text.replace("weights_only=True", "weights_only=False"))
        print("[vibevoice] Patched demo: torch.load(weights_only=True → False)")

    script_path = Path(args.script).resolve()
    output_path = Path(args.output).resolve()
    if not script_path.exists():
        sys.exit(f"[vibevoice] FATAL: script not found at {script_path}")
    output_path.parent.mkdir(parents=True, exist_ok=True)

    # ── Symlink vendor dir into a bracket-free path so the demo's glob works ──
    runtime_root = tempfile.mkdtemp(prefix="vibevoice-")
    runtime_dir = os.path.join(runtime_root, "VibeVoice")
    os.symlink(str(VENDOR_DIR), runtime_dir)

    # Also symlink the script + output dir into bracket-free territory.
    runtime_script = os.path.join(runtime_root, "script.txt")
    shutil.copy(str(script_path), runtime_script)
    runtime_output = os.path.join(runtime_root, "out")
    os.makedirs(runtime_output, exist_ok=True)

    demo_script = os.path.join(runtime_dir, "demo", "realtime_model_inference_from_file.py")
    cmd = [
        sys.executable,
        demo_script,
        "--model_path", "microsoft/VibeVoice-Realtime-0.5B",
        "--txt_path", runtime_script,
        "--speaker_name", args.voice,
        "--output_dir", runtime_output,
    ]

    print(f"[vibevoice] Runtime root: {runtime_root}")
    print(f"[vibevoice] Generating with voice='{args.voice}' ...")
    try:
        result = subprocess.run(cmd, cwd=runtime_dir)
        if result.returncode != 0:
            sys.exit(f"[vibevoice] FATAL: demo script exited {result.returncode}")

        produced = sorted(glob.glob(os.path.join(runtime_output, "**", "*.wav"), recursive=True))
        if not produced:
            sys.exit("[vibevoice] FATAL: demo script produced no .wav file.")

        shutil.move(produced[0], output_path)
        size_kb = output_path.stat().st_size // 1024
        print(f"[vibevoice] ✅ Wrote {output_path} ({size_kb} KB)")
    finally:
        # Clean up symlink + temp dir. shutil.rmtree won't follow the symlink
        # into vendor/, just removes the symlink itself.
        shutil.rmtree(runtime_root, ignore_errors=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
