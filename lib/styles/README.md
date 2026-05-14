# Bright Shared Styles

Reusable CSS utilities for HyperFrames compositions. Drop the `<link>` into any composition file and apply the class.

## glass.css — frosted-glass surfaces

For cards, banners, callout panels, badges — anything with a background that sits on top of the dot-wave canvas.

### Quick use

```html
<link rel="stylesheet" href="../lib/styles/glass.css">

<div class="glass-card">...</div>
```

### Variants

| Class | When to use |
|---|---|
| `.glass-card` | Default — light-bg, 45% opacity, 24px blur |
| `.glass-card.is-solid` | Text-heavy content — 62% opacity, less blur |
| `.glass-card.is-subtle` | Decorative containers — 22% opacity, more blur |
| `.glass-card.on-dark` | On Dark 01 (`#104023`) background |
| `.glass-card.on-dark.is-solid` | Dark bg + dense text |

Variants stack: `<div class="glass-card on-dark is-solid">`.

### Optional liquid wobble

Adds organic edge refraction via SVG displacement.

1. Paste the contents of [`../svg/glass-filter.html`](../svg/glass-filter.html) once near the top of `<body>` in your composition.
2. Add `.has-liquid` to the card: `<div class="glass-card has-liquid">`.

### Retuning across the project

Tweak the CSS vars at the top of `glass.css` to change every glass surface at once:

```css
:root {
  --glass-bg:       rgba(255, 255, 255, 0.45);
  --glass-blur:     24px;
  --glass-saturate: 180%;
  --glass-border:   1px solid rgba(255, 255, 255, 0.6);
  --glass-radius:   28px;
  --glass-shadow:   0 8px 32px rgba(15, 35, 25, 0.08);
}
```

### Known limitation — iframe boundary

Each composition loads in its own iframe. `backdrop-filter` only blurs content **within** the same document, so it cannot blur the dot-wave canvas living in `index.html`. The frosted look you see comes from the translucent fill, the border highlight, and the shadow — not from a real backdrop blur of the canvas.

If you ever need *true* glass-over-dots, the two options are:
1. Move the dot canvas into each composition (heavy, hurts the cross-shot continuity)
2. Move cards out of compositions and render them in `index.html` alongside the canvas (architectural shift)

For most use cases the current effect reads convincingly as glass. Bumping `--glass-bg` opacity to ~0.7 hides any remaining dot bleed-through.

### Consumers

- `compositions/shot-4-howitworks.html` — step cards
