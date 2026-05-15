# Bright × HyperFrames

A Claude Code skill that turns [HyperFrames](https://hyperframes.heygen.com) into a Bright-branded video production environment. After install, ask Claude to *"make a Bright video"* in any folder — the skill scaffolds a HyperFrames project with the Bright design system, brand-locked motion layer, glass-card utility, and a Studio chrome patch that replaces HeyGen branding with Bright.

```
 ██████╗ ██████╗ ██╗ ██████╗ ██╗  ██╗████████╗
 ██╔══██╗██╔══██╗██║██╔════╝ ██║  ██║╚══██╔══╝
 ██████╔╝██████╔╝██║██║  ███╗███████║   ██║
 ██╔══██╗██╔══██╗██║██║   ██║██╔══██║   ██║
 ██████╔╝██║  ██║██║╚██████╔╝██║  ██║   ██║
 ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝  ╚═╝
                                              × HYPERFRAMES
```

---

## Install

```bash
git clone https://github.com/Design-Bright/bright-X-hyperframe.git
cd bright-X-hyperframe
./install.sh
```

The installer shows you what's about to happen, estimates how long it'll take based on what's already cached on your machine, then asks for confirmation. Typical time:

| | Time |
|---|---|
| Fresh machine (downloads HyperFrames) | ~60 seconds |
| Already had HyperFrames | ~5 seconds |

## What gets installed

1. **HyperFrames CLI** — fetched from npm via `npx`, cached in `~/.npm/_npx/`
2. **Bright × HyperFrames skill** — copied to `~/.claude/skills/bright-hyperframes/`
3. **Studio chrome patch** — applied to the cached HyperFrames Studio bundle so the Bright logo appears in the editor's navbar and tab favicon, instead of HeyGen's

The skill bundles:
- The **brand design spec** (`DESIGN.md`) — colors, typography, layouts, voice/tone
- **Brand-locked motion layer** — animated green dot canvas + persistent Bright logo
- **Reusable assets** — Figtree fonts, GSAP, glass-card utility, SVG filters, default music track, branded outro MP4
- **Auto-patching scripts** — every `npm run dev/check/render/publish` re-applies the Studio chrome patch automatically, so HeyGen branding can't sneak back after a version bump

## Use it

After install, open Claude Code in any folder and say:

> "Make a Bright video"

The skill triggers, shows its banner + plan, then scaffolds a fresh HyperFrames project with everything wired up. You edit the shots, hit `npm run dev` to preview, `npm run render` for the MP4.

## Prereqs

The installer checks these for you and refuses to proceed if any are missing:

| Tool | Why |
|---|---|
| **Node.js 18+** | `npx` (the HyperFrames CLI delivery mechanism) |
| **git** | Cloning + version control |
| **ffmpeg** | HyperFrames render |

Install on macOS:

```bash
brew install node git ffmpeg
```

## After-install workflow

The skill is now active in Claude Code. Common requests it handles:

| You say | The skill does |
|---|---|
| "Make a Bright video" / "Create a Bright launch video" | Scaffolds a new project from the bundled template |
| "Add a shot showing X" | Creates a new `compositions/shot-X.html` matching the Bright layout spec |
| "Add a glass card with copy Y" | Uses the `glass-card` utility from `lib/styles/glass.css` |
| "What's the brand color?" / brand questions | Pulls from `DESIGN.md` |

For general HyperFrames questions (timing, captions, transitions, audio-reactive animation), it defers to the existing `hyperframes` skill — this skill is the Bright-specific layer on top.

## Re-running install

The installer is idempotent. Run it again any time:
- HyperFrames releases a new version (re-applies the studio chrome patch to the new bundle)
- The skill is updated in this repo (refreshes `~/.claude/skills/bright-hyperframes/`)

```bash
cd bright-X-hyperframe
git pull
./install.sh
```

## Uninstall

```bash
rm -rf ~/.claude/skills/bright-hyperframes
```

To also remove the cached HyperFrames CLI:

```bash
rm -rf ~/.npm/_npx
```

## Repo layout

```
.
├── install.sh                  # the installer (run this)
├── SKILL.md                    # source of truth for the Claude Code skill
├── DESIGN.md                   # Bright brand spec — read before any visual change
├── CLAUDE.md / AGENTS.md       # guidance for AI agents working in scaffolded projects
├── README.md                   # this file
├── index.html                  # brand-locked motion layer (gets copied per project)
├── compositions/
│   ├── shot-example.html       # heavily-commented starter shot
│   └── outro.html              # branded end card
├── lib/                        # reusable assets (fonts, music, logo, glass.css, SVG)
├── scripts/
│   └── patch-studio-logo.mjs   # HyperFrames Studio chrome patch
└── package.json                # npm scripts for scaffolded projects
```

## License

Internal Bright Money project. Built on top of [HyperFrames](https://github.com/heygen-com/hyperframes) (HeyGen's open-source video framework).
