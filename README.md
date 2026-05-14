# Brokk Launch Video — HyperFrames composition

A 25-second motion-graphics launch video for Brokk, built in [HyperFrames](https://hyperframes.heygen.com) with Bright Money's brand system.

```
0:00 ──────────────────────────────────────────────────────────────── 0:25
[ Intro ] [ Problem ] [ Before stat ] [ With stat ] [ How it works ] [ CTA ] [ Outro ]
```

---

## Quick start

```bash
# 1. Clone
git clone <repo-url> brokk_launch_v1
cd brokk_launch_v1

# 2. One-time setup — installs VibeVoice TTS for narration (~7–9 GB, ~10–15 min)
npm run setup

# 3. Preview in the studio
npm run dev

# 4. Render to MP4
npm run render
```

> **Heads up before you run `npm run setup`:** it installs PyTorch + the VibeVoice model — about **7–9 GB of disk** and **~10–15 minutes** on first run. If you don't want that yet, you can still preview the visuals via `npm run dev` and just hear the existing committed `lib/voiceover/narration.wav`. Setup is only required if you want to *regenerate* the voiceover.

## What's in the repo

```
.
├── index.html               # root composition — timeline, dot canvas, brand layer, audio tracks
├── compositions/            # the 6 shots + outro, each its own HTML file
├── lib/
│   ├── fonts/               # Figtree (Bright's brand typeface substitute)
│   ├── gsap.min.js
│   ├── logo/
│   ├── music/               # 10 background music tracks
│   ├── voiceover/           # script.txt + narration.wav (regenerable)
│   ├── styles/glass.css     # reusable frosted-glass utility (.glass-card)
│   ├── svg/                 # reusable inline SVG snippets
│   └── outros/
├── scripts/
│   ├── patch-studio-logo.mjs    # replaces HeyGen lockup with Bright logo in the HyperFrames studio
│   └── vibevoice/               # VibeVoice TTS setup + generate
├── DESIGN.md                # Bright brand system spec — colors, type, layouts, voice/tone
└── package.json             # npm scripts
```

## npm scripts

| Command | What it does |
|---|---|
| `npm run setup` | One-time install of VibeVoice TTS (Python venv + model) |
| `npm run dev` | Launch the studio in your browser to edit and preview |
| `npm run check` | Lint + validate + inspect the compositions |
| `npm run render` | Render to `renders/*.mp4` |
| `npm run publish` | Publish to a shareable HyperFrames link |
| `npm run tts` | Regenerate `lib/voiceover/narration.wav` from `lib/voiceover/script.txt` |
| `npm run patch-logo` | Re-apply the Bright logo patch to the HyperFrames studio chrome (runs automatically before dev/render/publish) |

## Editing the video

- **Visual changes** — edit `index.html` or one of `compositions/*.html`, then `npm run dev` to preview
- **Brand questions** — read [DESIGN.md](DESIGN.md) before changing colors, type, layout, or motion patterns
- **Narration script** — edit `lib/voiceover/script.txt` and run `npm run tts` to regenerate
- **VibeVoice voices** — `npm run tts -- --voice Davis` (or Frank, Mike, Emma, Grace, Carter). See [`scripts/vibevoice/README.md`](scripts/vibevoice/README.md) for the full list
- **Glass cards** — `<div class="glass-card">…</div>` after linking [`lib/styles/glass.css`](lib/styles/glass.css). See [lib/styles/README.md](lib/styles/README.md)

## Prereqs

- macOS (Apple Silicon recommended) or Linux with NVIDIA GPU
- Node 18+ and npm
- Python 3.10+ (for VibeVoice)
- git, ffmpeg

## Known caveats

- **VibeVoice is research-grade.** Microsoft's own disclaimer says it's not recommended for commercial use. Disclose any AI-generated VO when sharing publicly.
- **Path with brackets.** The project root currently lives at a path containing `[Hyperframe x Bright]`. Bracket characters break Python's `glob` — the VibeVoice generator works around this via a `/tmp` symlink. No action needed, just noting.
- **HeyGen studio chrome.** The HyperFrames studio (the editor) is HeyGen-branded by default. We patch it to show the Bright logo via `npm run patch-logo`, which runs automatically before every dev/render/publish so teammates never see the original branding.

## License

Internal Bright Money project.
