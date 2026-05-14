# Design System — Bright Brand

This is the **canonical brand spec** for every video produced by this tool. It is sourced from the official Bright Brand Style Guide v2.0 (July 2023). Every video must conform.

The mood / energy of an individual video can flex *within* this spec (e.g., serious topics may use the dark background and sparing red; hopeful topics may use light background and gold). Never flex *outside* it.

---

## Overview

Bright is a mission-driven AI-powered financial planning brand. The visual identity is **clear, optimistic, and modern** — light-canvas-first, with the signature Malachite green carrying brand recognition. The tone is *"a reliable, smart friend"* — friendly but authoritative, never talking down.

Visual signatures: **the orbit motif** (geometric circles in primary green), **left-justified type**, **generous negative space**, **the 6:3:1 color ratio**.

---

## Colors

### Primary (DOMINANT — 30% of every frame)

| Name | Hex | Use |
|---|---|---|
| **Malachite** | `#17C95F` | The brand color. Headlines, primary CTAs, orbit elements, logo |

### Approved backgrounds (MANDATORY — 60% of every frame)

Pick exactly one per video. Never use any other background.

| Name | Hex | Mood fit |
|---|---|---|
| **Light 01** | `#FFFFFF` | Default. Clean, optimistic, airy |
| **Light 02** | `#E3F1E7` | Soft. Calm, hopeful, on-brand mint |
| **Dark 01** | `#104023` | Dramatic. Serious topics, premium feel |

### Secondary (ACCENT only — 10% of frame, never dominant)

Pick **one** secondary per video. Use sparingly.

| Name | Hex | Emotional fit |
|---|---|---|
| **Ebony** | `#13132D` | Body text on light bg; serious anchor color |
| **Gold** | `#FCC038` | Optimism, success, milestones |
| **Sandstone** | `#FC712B` | Energy, urgency (gentle) |
| **Jasper** | `#DA3A3A` | Warning, debt, friction (use carefully) |
| **Cobalt** | `#4F5ED3` | Trust, technology, data |

### Extended palette — Primary tints/shades

For tone-on-tone illustrations, depth, and chart variations. Never as dominant.

```
#E3F1E7  Primary-0   (lightest mint)
#BAE8CB  Primary-20
#90E0AF  Primary-40
#6AD794  Primary-60
#40CF7B  Primary-80
#17C95F  Primary-100  ← MALACHITE
#15A450  Primary-120
#138241  Primary-140
#126232  Primary-160
#104023  Primary-180
#0E1E14  Primary-200  (darkest)
```

### Neutral palette

```
#FFFFFF  Neutral-0    (white)
#F4F5F8  Neutral-20
#D5D7DB  Neutral-30
#BFC2C9  Neutral-40
#959AA5  Neutral-50
#787F8A  Neutral-60
#5C626E  Neutral-70
#383C43  Neutral-80
#1E1F23  Neutral-90
#030303  Neutral-100  (black)
```

---

## Type & Element Spec (REQUIRED)

| Element | Font | Size | Weight | Style | Color | Notes |
|---|---|---|---|---|---|---|
| Section title | Figtree | **15px** | 300 Light | **italic** | `#838A96` | Letter-spacing 0.18em, uppercase, top-left. Fade in only. |
| Headline | Figtree | 112px | 700 Bold | normal | `#000` black | Word-rise animation (y +60→0, opacity 0→1, stagger 0.12s, power3.out). Left-aligned. |
| Subheading | Figtree | 36–44px | 500 Medium | normal | `#383C43` | Same word-rise as headline (consistency). |
| **Big number — alone** | Figtree | **450px** | **300 Light** | normal | `#17C95F` Malachite | Layout 3 (number-only comp). Counts up from 0. |
| **Big number — mixed** | Figtree | **280px** | **300 Light** | normal | `#17C95F` Malachite | Layout 1 (mixed with heading). Counts up from 0. |
| Number subtitle | Figtree | **50px** | 300 Light | **italic** | `#666D7A` | Below the big number. Fade in. |
| Footnote | Figtree | 18px | 400 Regular | normal | `#787F8A` | Bottom-left. Fade in. |
| Disclaimer | Figtree | 18px | 400 Regular | normal | `#787F8A` | Bottom-left, below footnote. Fade in. |
| Bright logo | (locked SVG) | 194 × 40 px | — | — | (locked colors) | Lower-right. **Always visible — no animation, never fade.** |

---

## Layout System — Three Variants (REQUIRED — pick the one that matches your content)

Every composition must use one of these three layouts. Pick based on what's actually in the content.

### Layout 1 — Heading + Number side-by-side
**When to use:** content has BOTH a meaningful headline AND a number/data point that compete for attention equally.

```
┌────────────────────────────────────────────────────────────┐
│  Section title                                              │
│                                                             │
│                                                             │
│   Headline (LEFT col)              Number (RIGHT col)       │
│   in 2–3 lines,                       in Malachite,         │
│   black, 112px Bold,                  320px, count up       │
│   max-width ~720px                    from 0                │
│                                                             │
│   Subheading                       Number subtitle          │
│                                                             │
│                                                             │
│  Footnote                                                   │
│  Disclaimer                                  [Bright logo]  │
└────────────────────────────────────────────────────────────┘
```

### Layout 2 — Heading only
**When to use:** content is text-only (no number/stat). The headline carries the full weight.

```
┌────────────────────────────────────────────────────────────┐
│  Section title                                              │
│                                                             │
│                                                             │
│   Headline (full-width, left-justified, 112px Bold)         │
│                                                             │
│   Subheading (10–15 words below)                            │
│                                                             │
│                                                             │
│  Footnote                                                   │
│  Disclaimer                                  [Bright logo]  │
└────────────────────────────────────────────────────────────┘
```

### Layout 3 — Number / highlight only
**When to use:** content is a single data point or stat with no headline.

```
┌────────────────────────────────────────────────────────────┐
│  Section title                                              │
│                                                             │
│                                                             │
│   Big number (Malachite, full-width-left, count up from 0)  │
│                                                             │
│   Number subtitle (the explanatory line)                    │
│                                                             │
│                                                             │
│  Footnote                                                   │
│  Disclaimer                                  [Bright logo]  │
└────────────────────────────────────────────────────────────┘
```

All layouts share: white background, grid, gradient mesh in lower 30–40%, Bright logo lower-right.
All content is left-aligned in all layouts. No centered text.

---

## Outro Handoff (REQUIRED)

When the main content ends and the outro MP4 begins, use a **hard cut** — no crossfade, no fade-out of the content layer. The outro carries its own visual entrance; layering a transition on top muddies it.

```
[main content scene] ─── HARD CUT ───▶ [outro MP4 plays full-frame]
```

Implementation: place the outro composition at `data-start` equal to the main content's end time, on the same track index. The runtime swaps cleanly.

```html
<div data-composition-src="compositions/video-6s.html" data-start="0"  data-duration="6"    data-track-index="1"></div>
<div data-composition-src="compositions/outro.html"     data-start="6" data-duration="2.84" data-track-index="1"></div>
```

---

## The Background Grid (house style — REQUIRED in every video)

A subtle 96×96px gridline pattern sits behind everything (between the white canvas and the gradient mesh). Gives the brand a "documentary / engineered" feel without competing with content.

```css
#brand-grid {
  position: absolute; inset: 0; z-index: 0;
  background-image:
    linear-gradient(to right,  rgba(15, 23, 30, 0.05) 1px, transparent 1px),
    linear-gradient(to bottom, rgba(15, 23, 30, 0.05) 1px, transparent 1px);
  background-size: 96px 96px;
  pointer-events: none;
}
```

Place the `<div id="brand-grid"></div>` as the FIRST child of `#root`, before `#bg-wrap`.

---

## The Animated Background Mesh (house style — REQUIRED in every video)

The Bright brand backgrounds are clean (white, mint, or deep forest) per the official guide. For motion-graphics video specifically, we layer a **subtle animated green mesh** on top of the white canvas as our house style — it gives the frame organic motion without distracting from content.

### Spec

- **Base canvas:** `#FFFFFF` (Light 01) — locked, never change
- **Mesh color:** `#BBEDCF` — the single mesh hue, used for all blobs (no other colors in the mesh)
- **Position:** Anchored to the **lower half** of the frame only. Upper ~50% stays clean white.
- **Coverage:** ~40% perceived green presence overall (earlier explorations at ~80% drowned the content)
- **Number of blobs:** 2 — one bottom-left, one bottom-right
- **Blur:** `filter: blur(140px)` per blob (heavy soft falloff)
- **Opacity:** ~0.28 bottom-right, ~0.42 bottom-left — asymmetry gives natural depth
- **Motion:** Each blob drifts on a slow sine loop, ±25–35px in X and Y, opposite directions

### Code pattern

```html
<div id="bg-wrap" style="position:absolute; inset:0; z-index:1; overflow:hidden; pointer-events:none;">
  <div id="bg-blob-1" style="width:1400px; height:1400px; bottom:-260px; right:-200px;
       background:#BBEDCF; opacity:0.28; position:absolute; border-radius:50%;
       filter:blur(140px); will-change:transform;"></div>
  <div id="bg-blob-2" style="width:1300px; height:1300px; bottom:-260px; left:-120px;
       background:#BBEDCF; opacity:0.42; position:absolute; border-radius:50%;
       filter:blur(140px); will-change:transform;"></div>
</div>
```

```js
// Slow sine drift, opposite vectors. N = composition duration in seconds.
tl.fromTo('#bg-blob-1', { x:  30, y: -30 }, { x: -30, y:  30, duration: N, ease: 'sine.inOut' }, 0);
tl.fromTo('#bg-blob-2', { x: -25, y:  35 }, { x:  25, y: -35, duration: N, ease: 'sine.inOut' }, 0);
```

### Don'ts

- Don't add Cobalt or Gold blobs to the mesh — they are foreground-only accents (labels, etc.).
- Don't put blobs in the upper half. Top of frame stays clean.
- Don't raise opacities past ~0.5. The mesh must never compete with content.
- Don't use multiple mesh hues. Single color `#BBEDCF`.

---

## The 6:3:1 Color Rule (MANDATORY)

Every frame divides into:

```
60%  Background      → one of the three approved backgrounds
30%  Primary green   → Malachite #17C95F (headlines, orbits, key elements)
10%  Secondary       → one accent color from the secondary palette
```

A frame that's mostly green = wrong. A frame with three secondaries = wrong. A frame with no green = wrong (unless it's a deliberate transition).

---

## Typography

**Brand typeface:** Gilroy (paid, licensed)
**Used by this tool:** **Figtree** — bundled at `~/.video-explainer/lib/fonts/figtree.css`. Same geometric-rounded character as Gilroy. Free Google Font, all weights 300–900 in one variable file.

### Loading Figtree in compositions

```html
<link rel="stylesheet" href="../lib/fonts/figtree.css">
<style>
  body { font-family: 'Figtree', system-ui, sans-serif; }
</style>
```

### Type scale (apply across all compositions)

| Role | Size | Weight | Line height |
|---|---|---|---|
| Display Large | 96px | 700 (Bold) | 100% |
| Display Medium | 64px | 600 (SemiBold) | 105% |
| Display Small | 48px | 600 (SemiBold) | 110% |
| Headline XL | 40px | 700 (Bold) | 110% |
| Headline Large | 32px | 700 (Bold) | 115% |
| Headline Medium | 24px | 700 (Bold) | 120% |
| Headline Small | 20px | 700 (Bold) | 125% |
| Title Large | 18px | 700 (Bold) | 130% |
| Title Medium | 16px | 700 (Bold) | 130% |
| Title Small | 14px | 700 (Bold) | 130% |
| Subhead | 18px | 500 (Medium) | 130% |
| Body Large | 16px | 400 (Regular) | 150% |
| Body Medium | 14px | 400 (Regular) | 150% |
| Caption | 8px | 700 (Bold) | 130% |

For video, scale up 1.5–2× from the spec — web sizes are invisible on a 1920×1080 frame at 30fps. Keep the *ratios* between sizes; multiply the absolute values.

### Type rules (from the brand guide)

1. **Justify left when in doubt.** Hard left edges make paragraphs easier to read.
2. **Align baselines or cap heights** when text sits next to text.
3. **Watch the rags.** A good rag goes in and out in small increments. Break lines manually if needed.
4. **Avoid orphans and widows** — never leave one word alone on its own line.
5. **Establish a clear hierarchy** — A is the largest/boldest, B is the subtitle, C is body.
6. **120% leading by default.**

### Layout grid

**4pt grid system.** Every height, width, padding, margin, and line-height must be divisible by 4. No 13px paddings, no 27px gaps.

---

## The Orbit Motif (REQUIRED in every video)

Bright's signature visual element. Geometric circles inspired by natural ecosystems. Always rendered in Malachite green `#17C95F` (or its tints/shades from the primary extended palette).

**Every video must contain orbit elements in at least 3 of the 5 beats.** Not necessarily in motion — they can be static framing devices. The point is visual continuity across the brand.

### Four orbit styles — pick one per beat

1. **Flat** — solid filled circle in Malachite. Used to anchor focus.
2. **Gradient** — circle with a Primary-80 → Primary-180 radial gradient. Adds depth, evokes a glow or planet.
3. **3D** — circle with subtle shadow + highlight bands suggesting a sphere (use sparingly).
4. **Stroke** — outlined ring (2–4px stroke). Used to draw the eye, frame an element, or imply orbit/motion.

### Common usage patterns

- **Focus halo** — a soft Malachite ring behind a central element (text, stat, illustration)
- **Eye-leader** — a hand-drawn-feeling stroke arc that visually connects two elements across the frame
- **Background motif** — a faded large gradient orbit at 8–15% opacity, sitting behind everything as ambient brand presence
- **Reveal element** — a stroke ring scales/draws in to introduce a new subject

### Orbit composition rules

- Always Malachite or a primary-extended green (never secondary colors)
- Stay geometric and clean — no decorative flourishes
- Pair with negative space — don't crowd them
- Animate them: subtle drift, slow rotation, gentle scale-pulse. Static orbit = dead orbit.

---

## Logo

### Placement (from the animation guidelines)

**Always lower-right corner of the video.** This applies to every aspect ratio (9:16 vertical, 1:1 square, 16:9 landscape).

### Logo files

Drop the logo SVG/PNG at `~/.video-explainer/lib/logo/bright-logo-light.svg` (for dark backgrounds) and `bright-logo-dark.svg` (for light backgrounds). The compositions reference these paths.

**Do not change the logo color.** Use the version that matches the background:
- On Light 01 / Light 02 backgrounds → use the dark version (Malachite + Ebony)
- On Dark 01 background → use the light version (Malachite + White)

**Watermark variant** — a monochrome logo unit may be used as a watermark for videos only. Use Malachite at 40–60% opacity for a subtle brand presence.

### Clear space

Minimum clear space around the logo = the width of the letter "i" in the wordmark. No type, imagery, or graphic elements may encroach this zone.

### Minimum size

- Horizontal lockup: 24px tall in the final render
- Vertical lockup: 46px tall in the final render

---

## Photography & Imagery

If a video uses photography (rare for explainers, common for product demos):

- **Hopeful, inclusive, diverse** — represent all kinds of people as equals
- **Negative space** — minimal composition, clear focus on the subject
- **Natural lighting and color** — non-filtered, organic, realistic
- **No off-brand color casts** — no aggressive teal-and-orange grading

Most explainer videos rely on geometric/typographic composition rather than photos. Default to that.

---

## Voice & Tone (write the script in this voice)

Bright is *"a reliable, smart friend."* The narration script must follow these rules:

### Do

- Use **contractions**: *we're, you'll, it's, that's*
- Use **"we"** for collective challenges: *"we all get frustrated by credit cards"*, *"we're here to help"*
- Be **conversational and informed** — friendly but authoritative
- Use **American vernacular**: *"Hey,"* / *"Hi,"* / casually *"Howdy"* — never formal openings
- Be **excited to engage** but **never chatty** — economy of words
- **Lift up, never talk down** — celebrate when people succeed
- Open with a hook that creates tension, curiosity, or surprise in the first 3 seconds

### Don't

- Don't use formal/corporate openings (*"Welcome to..."*, *"Greetings..."*)
- Don't be condescending or preachy
- Don't lecture — explain like a friend at a coffee shop
- Don't use British spellings (*colour, organise, centre*) — American only
- Don't pad the script with filler — silence between sentences is a feature

---

## Do's and Don'ts (visual)

### Do

- Use approved backgrounds only (Light 01 / Light 02 / Dark 01)
- Apply the 6:3:1 color ratio in every frame
- Include orbit elements in at least 3 of 5 beats
- Place the logo in the lower-right corner
- Justify type left, follow the type scale
- Use 4pt grid spacing
- Animate decorative elements — static = dead

### Don't

- Don't use any background color outside the 3 approved
- Don't make Malachite the dominant color (it's 30%, not 60%)
- Don't pair multiple secondary colors in one frame — pick one
- Don't change the logo color
- Don't place the logo outside the lower-right corner
- Don't use Gilroy directly — we substitute Figtree
- Don't use off-grid sizes (everything divisible by 4)
- Don't use British English in narration
