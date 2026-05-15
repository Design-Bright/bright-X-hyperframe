---
name: bright-hyperframes
description: Scaffold and edit Bright Money brand-conformant motion-graphics videos using HyperFrames. The skill bundles the Bright design system (Figtree typography, 6:3:1 color rule, 3 canonical layouts, orbit motif, brand-locked dot-canvas layer, glass-card utility) and a HyperFrames Studio chrome patch that swaps HeyGen branding for Bright branding. Use when the user asks to "make a Bright video", "create a launch/explainer/promo for Bright", "build a HyperFrames video in Bright's brand", scaffold a new Bright video project, or works inside a folder that already contains a Bright HyperFrames project (has `DESIGN.md` plus `index.html` referencing `compositions/`). For general HyperFrames patterns (timelines, data-attrs, captions, transitions) defer to the `hyperframes` skill — this skill is the Bright-specific layer on top.
---

# Bright × HyperFrames

## CRITICAL — first invocation per conversation

The **first time** this skill is invoked in a conversation, your VERY FIRST output to the user MUST be:

1. The full ASCII art block below, **verbatim, inside a fenced code block** so it renders monospace.
2. A `PROJECT PLAN` section listing the numbered steps you intend to take for this request.
3. An `ACTION` section before you begin executing tools.

### When to skip the ASCII art

Skip it on **subsequent requests in the same conversation** — once it's been shown, don't repeat. Detection rule: if you have previously emitted the ASCII art (or any prior message in the conversation references HyperFrames, the bright-hyperframes skill, or scaffolds/edits a Bright HyperFrames project), this is **not** the first invocation. Just answer the request directly. You can still optionally use `PROJECT PLAN` + `ACTION` headings for non-trivial work, but the art is one-and-done per conversation.

Quick decision tree:
- First message in chat triggers skill → **show art**
- Earlier messages already discussed HyperFrames or this skill → **skip art**
- User explicitly says "show me the banner again" → **show art**

### The art

````
 ██████╗ ██████╗ ██╗ ██████╗ ██╗  ██╗████████╗
 ██╔══██╗██╔══██╗██║██╔════╝ ██║  ██║╚══██╔══╝
 ██████╔╝██████╔╝██║██║  ███╗███████║   ██║   
 ██╔══██╗██╔══██╗██║██║   ██║██╔══██║   ██║   
 ██████╔╝██║  ██║██║╚██████╔╝██║  ██║   ██║   
 ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝  ╚═╝   

 ██╗  ██╗
 ╚██╗██╔╝
  ╚███╔╝ 
  ██╔██╗ 
 ██╔╝ ██╗
 ╚═╝  ╚═╝

 ██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗ ███████╗██████╗  █████╗ ███╗   ███╗███████╗
 ██║  ██║╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝
 ███████║ ╚████╔╝ ██████╔╝█████╗  ██████╔╝█████╗  ██████╔╝███████║██╔████╔██║█████╗  
 ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  
 ██║  ██║   ██║   ██║     ███████╗██║  ██║██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗
 ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝
> made by kill_bill
````

---

## What this skill does

When a user asks to make/edit a Bright video, this skill:

1. **Scaffolds new projects** — copies the Bright × HyperFrames scaffolding from `~/.claude/skills/bright-hyperframes/scaffolding/` into the user's chosen folder. Includes the brand-locked layer in `index.html`, the example shot, the outro, all reusable assets in `lib/`, the studio chrome patch script, npm scripts, and project config.
2. **Enforces the brand spec** — Figtree typography, 6:3:1 color rule, 3 canonical layouts, orbit motif rule, voice/tone.
3. **Patches the studio chrome** — every `npm run dev/check/render/publish` runs `scripts/patch-studio-logo.mjs` first to replace HeyGen branding with Bright in the Studio UI.

## Scaffolding a new Bright video project

When the user says "make a Bright video" / "create a Bright launch video" / similar:

1. Confirm the target folder (current working dir, or ask for a new name)
2. Copy the scaffolding from `~/.claude/skills/bright-hyperframes/scaffolding/` into that folder
3. Run `npm run patch-logo` to seed the studio chrome patch on first dev run
4. Tell the user: edit `compositions/shot-example.html` as the starting point, add more shots, run `npm run dev` to preview

Use `cp -R ~/.claude/skills/bright-hyperframes/scaffolding/. <target-folder>/` for the copy. Hidden files (`.claude/`, `.gitignore`) must come along — the trailing `.` in the source path is important.

## Editing an existing Bright HyperFrames project

If `index.html` already references `compositions/*.html` and a `DESIGN.md` exists, you're in an existing project. Skip scaffolding. Read `DESIGN.md` (the brand spec in `references/DESIGN.md` if the project doesn't have its own), then make the requested edit.

## Brand essentials — non-negotiable

The canonical spec is in `references/DESIGN.md` (when the skill is installed) or the project's own `DESIGN.md`. The high-bar rules you must enforce:

| Rule | Why |
|---|---|
| Use **only** approved backgrounds: `#FFFFFF`, `#E3F1E7`, or `#104023` | Brand-spec colors |
| **Malachite green `#17C95F`** is the brand color — for headlines, orbit elements, key accents. **30% of frame, not dominant.** | The 6:3:1 color ratio (60% bg / 30% primary / 10% accent) |
| Pick **one** secondary color per video from `#13132D`, `#FCC038`, `#FC712B`, `#DA3A3A`, `#4F5ED3`. Use sparingly. | Brand discipline — multiple secondaries = wrong |
| Typography: **Figtree** only (loaded from `lib/fonts/figtree.css`). Never substitute. | Brand typeface |
| **Section title** = `15px, 300 italic, #838A96, uppercase, letter-spacing 0.18em`. Always top-left at `top:88px left:96px` | Anchors every shot |
| **All content left-aligned, never centered** | Brand voice principle |
| **4pt grid** — every padding/margin/gap divisible by 4 | Layout consistency |
| **Orbit motif** (green circles, Malachite or primary-extended tints) in ≥3 of 5 shots | Brand continuity |
| **Bright logo** lower-right corner. Never animate, never reposition, never recolor. | Brand mark |
| **Voice/tone**: contractions, "we", American vernacular, "reliable smart friend" register. No formal openings. Hook in first 3 seconds. | Bright voice |

## Three canonical layouts

Every shot must use one. Pick by content type:

1. **Layout 1 — Heading + Number side-by-side** — headline AND number compete equally. Headline left (112px), number right (280px Malachite, counts up from 0).
2. **Layout 2 — Heading only** — text-only content. Headline full-width left, 112–144px. Subhead 36–44px below.
3. **Layout 3 — Number / highlight only** — single data point. Big number 450px Malachite counting up, subtitle 50px italic below.

`scaffolding/compositions/shot-example.html` demos Layout 2 with the word-rise animation. Copy it as a starting point for any new shot.

## Composition pattern — every shot

```html
<!doctype html>
<html lang="en">
<head>
  <link rel="stylesheet" href="../lib/fonts/figtree.css">
  <link rel="stylesheet" href="../lib/styles/glass.css"><!-- if using glass cards -->
  <script src="../lib/gsap.min.js"></script>
  <style>
    html, body { width: 1920px; height: 1080px; background: transparent; }
    #content-wrap { position: absolute; inset: 0; will-change: opacity; }
  </style>
</head>
<body>
  <div id="root" data-composition-id="shot-NAME" data-start="0" data-duration="5"
       data-width="1920" data-height="1080">
    <div id="content-wrap">…</div>
  </div>
  <script>
    window.__timelines = window.__timelines || {};
    var tl = gsap.timeline({ paused: true });
    /* …animation… */
    window.__timelines['shot-NAME'] = tl;
  </script>
</body>
</html>
```

In `index.html`, register a wrapper:

```html
<div class="shot-wrap"
     data-composition-src="compositions/shot-NAME.html"
     data-composition-id="shot-NAME"
     data-start="X" data-duration="Y"
     data-track-index="1"></div>
```

Alternate `data-track-index` between adjacent shots (1, 2, 1, 2) so they cross-fade cleanly.

## Brand-locked layer — DO NOT MODIFY

`index.html` has static layers that persist across every shot:
- Animated **green dot canvas** (Malachite halftone field, drift-animated)
- **Bright logo** SVG lower-right

Never remove these. If extending the timeline, bump:
- `#root` `data-duration`
- `#bg-music` `data-duration`
- The dot canvas tween (`tl.to(dotProxy, { t: T, duration: T, ... }, 0)`)
- The brand-layer hide trigger (`tl.set([...], { opacity: 0 }, T)`)
- Outro `data-start`

Where `T = total shot time` (just before the outro).

## Glass-card utility

Available via `<link rel="stylesheet" href="../lib/styles/glass.css">` then `<div class="glass-card">`. Variants: `is-solid`, `is-subtle`, `on-dark`. Optional `has-liquid` adds SVG displacement wobble (paste `lib/svg/glass-filter.html` in body).

**Iframe limit**: `backdrop-filter` can't blur the dot canvas in `index.html` (cross-iframe). The glass effect comes from translucent fill + border + shadow, not real backdrop blur.

## Studio chrome patch

The HyperFrames Studio is HeyGen-branded by default. The `scripts/patch-studio-logo.mjs` script patches the cached studio bundle to show the Bright logo and favicon. It runs automatically before every `npm run dev/check/render/publish` and is idempotent — re-applies cleanly after any HyperFrames version bump.

If a teammate ever sees HeyGen branding in the studio, run `npm run patch-logo` manually.

## Voiceover (optional)

This skill ships **no built-in TTS**. If the user wants narration:
- **HyperFrames built-in** — `npx hyperframes tts script.txt --voice af_heart --output narration.wav` uses Kokoro. Quality is OK, not great. See the `hyperframes-media` skill for voice options.
- **ElevenLabs** — better quality, paid API. User configures their own key.
- **Real recording** — best quality. User provides a WAV file.

After generating audio, add an `<audio>` element to `index.html` referencing the WAV with `data-start`, `data-duration`, `data-track-index`, `data-volume`, and `preload="auto"`.

## Common pitfalls

1. **Linter rejects `src="..."` strings inside HTML comments** — the hyperframes lint does string-match, not real HTML parsing. Describe attributes in prose, not literal `src="..."`.
2. **Section title is 15px, not 30px** — the original spec said 30px but the brand was retuned. Always use 15px.
3. **Backgrounds**: only `#FFFFFF`, `#E3F1E7`, `#104023`. Reject any other.
4. **Glob breaks on paths with `[` or `]`** — if the project lives at a path containing brackets, native Python globbing in any helper script can silently return zero results. Use `glob.escape()` or symlink into bracket-free `/tmp/`.

## When to invoke other skills

- **`hyperframes`** — general HyperFrames patterns (timelines, transitions, captions, marker highlights). This skill assumes you're using those primitives correctly.
- **`hyperframes-cli`** — CLI command reference (init, lint, preview, render, transcribe, tts).
- **`hyperframes-media`** — TTS / transcribe / background removal preprocessing.
- **`gsap`** — GSAP animation syntax reference.
- **`anthropic-skills:bright-design-autopilot`** — Bright design system in static HTML / wireframing context. Bigger system but optimized for static UI, not video.

## Memory note for distribution

If asked to package this skill for wider org distribution (e.g., as an npm-installable scaffolder beyond the current `install.sh`), preserve opt-in behavior: never auto-install heavy dependencies. Today the install is lightweight (~6 MB skill + ~30 MB hyperframes via npx). Any future heavy additions (e.g., a TTS engine, model weights) must be gated behind explicit user consent in the install flow.
