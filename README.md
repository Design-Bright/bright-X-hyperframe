# Bright × HyperFrames — starter template

The Bright Money design system, pre-wired into a [HyperFrames](https://hyperframes.heygen.com) project so anyone on the team can create a brand-conformant motion-graphics video in under a day.

Includes brand-locked layers (animated green dot canvas, Bright logo, Figtree typography), the [Bright design spec](DESIGN.md), reusable glass-card UI, a local TTS narration pipeline (VibeVoice), and a patch that swaps the HeyGen Studio logo for the Bright logo so teammates never see the HeyGen branding.

---

## Make your first video

```bash
# 1. Clone
git clone https://github.com/Design-Bright/bright-X-hyperframe.git my-video
cd my-video

# 2. One-time setup — installs VibeVoice locally (~7–9 GB, ~10–15 min)
#    Skip this if you only want to preview/edit the visuals.
npm run setup

# 3. Edit the example shot — see compositions/shot-example.html for the patterns
#    See DESIGN.md before changing colors, type, or layout.

# 4. Preview in the studio
npm run dev

# 5. (optional) Write your narration in lib/voiceover/script.txt, then:
npm run tts
#    After your first `npm run tts`, uncomment the <audio id="voiceover">
#    block in index.html to wire it into the timeline.

# 6. Render to MP4
npm run render
```

> The `npm run setup` step downloads PyTorch + the VibeVoice model — **~7–9 GB on disk, ~10–15 min on first run**. If you only want to edit visuals without voiceover, you can skip setup entirely and run `npm run dev` directly.

---

## What's in the template

```
.
├── index.html               # root composition — timeline, dot canvas, brand layer, audio tracks
├── compositions/
│   ├── shot-example.html    # heavily-commented example shot showing the brand patterns
│   └── outro.html           # branded end card (MP4 playback)
├── lib/
│   ├── fonts/               # Figtree (Bright's brand typeface substitute)
│   ├── gsap.min.js
│   ├── music/               # bg music library — drop in more tracks here
│   ├── outros/Outro.mp4     # branded outro MP4
│   ├── voiceover/           # narration script + generated audio
│   ├── styles/glass.css     # reusable frosted-glass utility (.glass-card)
│   ├── svg/                 # reusable inline SVG snippets (e.g. liquid filter)
│   └── bright-favicon.svg   # tab icon used by the studio patch
├── scripts/
│   ├── patch-studio-logo.mjs    # replaces HeyGen lockup with Bright logo in the HyperFrames studio
│   └── vibevoice/               # VibeVoice TTS — setup + generate
├── DESIGN.md                # Bright brand system spec — colors, type, layouts, voice/tone
├── CLAUDE.md / AGENTS.md    # AI-agent guidance for editing this project
└── package.json
```

## npm scripts

| Command | What it does |
|---|---|
| `npm run setup` | One-time install of VibeVoice TTS (Python venv + model) |
| `npm run dev` | Launch the HyperFrames studio in your browser to edit and preview |
| `npm run check` | Lint + validate + inspect all composition HTML |
| `npm run render` | Render to `renders/*.mp4` |
| `npm run publish` | Publish to a shareable HyperFrames link |
| `npm run tts` | Regenerate `lib/voiceover/narration.wav` from `lib/voiceover/script.txt` |
| `npm run patch-logo` | Re-apply the Bright logo patch to the studio chrome (runs automatically before dev/render/publish) |

## Where to learn the patterns

- **[DESIGN.md](DESIGN.md)** — the brand spec. Read this before any visual change.
- **[compositions/shot-example.html](compositions/shot-example.html)** — heavily-commented example shot. Copy this as a starting point for new shots.
- **[lib/styles/README.md](lib/styles/README.md)** — glass-card utility usage.
- **[scripts/vibevoice/README.md](scripts/vibevoice/README.md)** — voice options, tuning, uninstall.
- **[CLAUDE.md](CLAUDE.md) / [AGENTS.md](AGENTS.md)** — guidance for AI agents like Claude Code working in this project.

## How to add a shot

1. Copy `compositions/shot-example.html` to `compositions/your-name.html`
2. Edit the content + animation
3. In `index.html`, add a wrapper `<div>` referencing your file with `data-composition-src`, `data-composition-id`, `data-start`, `data-duration`, `data-track-index`
4. Bump the root `data-duration`, the bg-music duration, and the outro `data-start` to fit
5. `npm run check` to lint

## Prereqs

- macOS (Apple Silicon recommended) or Linux with NVIDIA GPU
- Node 18+ and npm
- Python 3.10+ (for VibeVoice — only if you want TTS narration)
- git, ffmpeg

## Known caveats

- **VibeVoice is research-grade.** Microsoft's own disclaimer says it's not recommended for commercial use. Disclose any AI-generated VO when sharing publicly.
- **Brackets in path names break Python globbing.** If you clone this into a folder with `[` or `]` in the path, the VibeVoice generator handles it via a `/tmp` symlink. Nothing to do, just noting.
- **HeyGen studio chrome.** The HyperFrames studio (the editor) is HeyGen-branded by default. We patch it to show the Bright logo via `npm run patch-logo`, which runs automatically before every dev/render/publish so teammates never see the original branding.

## License

Internal Bright Money project. The template is for use by Bright designers and engineers. The VibeVoice model has its own [MIT license](https://github.com/microsoft/VibeVoice/blob/main/LICENSE) plus Microsoft's research-only disclaimer.
