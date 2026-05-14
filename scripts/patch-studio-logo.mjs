#!/usr/bin/env node
// Replaces the HeyGen "HyperFrames" lockup in the HyperFrames Studio UI
// with the Bright logo. Runs before every `npm run dev|check|render|publish`.
// Idempotent: skips files already patched. Auto-heals after any hyperframes
// version bump or npm cache wipe.
//
// What it does:
//   1. Ensures the pinned hyperframes version is cached (seeds via --help if not)
//   2. Walks ~/.npm/_npx/*/node_modules/hyperframes/dist/studio/assets/index-*.js
//   3. For each, replaces the minified `function gP()` React component
//      (the navbar logo) with one that renders the Bright lockup.

import { execSync } from 'node:child_process';
import { readFileSync, writeFileSync, readdirSync, existsSync, copyFileSync, statSync } from 'node:fs';
import { homedir } from 'node:os';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const PINNED_VERSION = '0.6.4';
const MARKER = 'aria-label":"Bright"';
const PROJECT_ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const BRIGHT_FAVICON_SRC = join(PROJECT_ROOT, 'lib', 'bright-favicon.svg');

const WORDMARK_D = 'M680.8,111.6h15.7v108h-31.3v-108h15.7ZM608.1,111.6c-12.5,0-23.8,5.1-32,13.3-8.2,8.2-13.3,19.5-13.3,32v33.5s0,29.2,0,29.2h31.3v-58.4h0v-4.3c0-3.8,1.6-7.3,4.1-9.8s6-4,9.8-4,7.3,1.5,9.8,4c2.5,2.5,4.1,6,4.1,9.8h31.4c0-12.5-5.1-23.8-13.3-32-8.2-8.2-19.5-13.3-32-13.3ZM534.8,127.8c10.1,10.1,16.3,23.9,16.3,39.3s-6.2,29.2-16.3,39.3c-10.1,10.1-23.9,16.3-39.3,16.3s-29.2-6.2-39.3-16.3c-10-10-16.3-23.9-16.3-39.3s0-1.4,0-2.1c0-.7,0-1.4.1-2.1,0-.5-.1-1.1-.1-1.6,0-.5,0-1.1,0-1.6v-90.8h31.3v48.3c3.7-1.8,7.5-3.2,11.6-4.1s8.3-1.4,12.6-1.4c15.3,0,29.2,6.2,39.3,16.3ZM519.7,167.1c0-6.7-2.7-12.7-7.1-17.1-4.4-4.4-10.4-7.1-17.1-7.1s-12.7,2.7-17.1,7.1c-4.4,4.4-7.1,10.4-7.1,17.1s2.7,12.7,7.1,17.1c4.4,4.4,10.4,7.1,17.1,7.1s12.7-2.7,17.1-7.1c4.4-4.4,7.1-10.4,7.1-17.1ZM927.3,124.1c-9.4-8-22.3-12.5-36.6-12.5s-7.2.4-10.6,1.1c-3.4.7-6.7,1.8-9.8,3.1v-46.9h-31.3v90.3c0,.3,0,.6,0,.9,0,.3,0,.6,0,.9,0,.4,0,.8,0,1.2,0,.4,0,.8,0,1.2v56.2h31.3v-58.4c0-5.6,2.3-10.6,5.9-14.3,3.7-3.7,8.7-5.9,14.3-5.9s10.7,2.3,14.5,5.9c3.8,3.7,6.2,8.7,6.2,14.3v58.4h31.3v-61.5c0-14.3-5.8-25.9-15.2-34ZM680.8,68.8c-4.3,0-8.2,1.8-11.1,4.6-2.8,2.8-4.6,6.8-4.6,11.1s1.8,8.2,4.6,11.1c2.8,2.8,6.8,4.6,11.1,4.6s8.2-1.8,11.1-4.6c2.8-2.8,4.6-6.8,4.6-11.1s-1.8-8.2-4.6-11.1c-2.8-2.8-6.8-4.6-11.1-4.6ZM1017.2,178c-.2,3.6-1.7,6.8-4,9.1-2.5,2.5-5.9,4-9.8,4s-7.3-1.6-9.8-4c-2.5-2.5-4-6-4-9.8v-6.4h0v-28.1h50.1v-31.3h-50.1v-34h-31.4v93.5h0v6.4c0,12.5,5.1,23.8,13.3,32,8.2,8.2,19.5,13.3,32,13.3s23.8-5.1,32-13.3c8-8.1,13.1-19.1,13.2-31.3h-31.4ZM818.8,145.5c2.8,6.6,4.4,14,4.4,21.6v25.9s0,25.9,0,25.9c0,15.3-6.2,29.2-16.3,39.2-10,10-23.9,16.3-39.2,16.3h-33v-31.2h33c6.7,0,12.8-2.7,17.1-7.1,4.4-4.4,7.1-10.5,7.1-17.1v-1.8c-3.7,1.8-7.5,3.2-11.6,4.1-4,.9-8.3,1.5-12.6,1.5-7.7,0-15-1.6-21.6-4.4-6.6-2.8-12.6-6.9-17.7-11.9-5-5-9.1-11-11.9-17.7-2.8-6.6-4.4-13.9-4.4-21.6s1.5-15,4.4-21.6c2.8-6.6,6.9-12.6,11.9-17.7,5-5,11-9.1,17.7-11.9,6.6-2.8,13.9-4.4,21.6-4.4s15,1.6,21.6,4.4c6.6,2.8,12.6,6.9,17.7,11.9,5,5,9.1,11,11.9,17.7ZM791.9,167.1c0-3.3-.7-6.5-1.9-9.4-1.2-2.9-3-5.5-5.2-7.7-2.2-2.2-4.8-4-7.7-5.2-2.9-1.2-6.1-1.9-9.4-1.9s-6.5.7-9.4,1.9c-2.9,1.2-5.5,3-7.7,5.2-2.2,2.2-4,4.8-5.2,7.7-1.2,2.9-1.9,6.1-1.9,9.4s.7,6.5,1.9,9.4c1.2,2.9,3,5.5,5.2,7.7,2.2,2.2,4.8,4,7.7,5.2,2.9,1.2,6.1,1.9,9.4,1.9s6.5-.7,9.4-1.9c2.9-1.2,5.5-3,7.7-5.2,2.2-2.2,4-4.8,5.2-7.7,1.2-2.9,1.9-6.1,1.9-9.4Z';

const BURST_D = 'M262.9,188.3l99.1-57.3-15.7-27.1-99.1,57.2,57.3-99.1-27.1-15.7-57.2,99.1V37.7h-31.3v107.8l-57.3-99.2-27.2,15.7,57.2,99.1-99.1-57.2-15.6,27.1,99.1,57.2H31.5v31.3h135.8c-6.3-20.5,5.2-42.3,25.7-48.6s42.3,5.2,48.6,25.7c2.3,7.5,2.3,15.4,0,22.9h135.8v-31.3h-114.5Z';

function buildReplacement() {
  return `function gP(){return O.jsxs("svg",{width:97,height:28,viewBox:"0 0 1080 312",fill:"none",xmlns:"http://www.w3.org/2000/svg","aria-label":"Bright",children:[O.jsx("defs",{children:O.jsxs("linearGradient",{id:"bright-studio-gradient",x1:"204.5",y1:"219.5",x2:"204.5",y2:"37.7",gradientUnits:"userSpaceOnUse",children:[O.jsx("stop",{offset:"0",stopColor:"#138241"}),O.jsx("stop",{offset:"1",stopColor:"#17c95f"})]})}),O.jsx("path",{fill:"#FFFFFF",d:${JSON.stringify(WORDMARK_D)}}),O.jsx("path",{fill:"url(#bright-studio-gradient)",d:${JSON.stringify(BURST_D)}})]})}`;
}

function findStudioDirs() {
  const cacheRoot = join(homedir(), '.npm', '_npx');
  if (!existsSync(cacheRoot)) return [];
  const out = [];
  for (const dir of readdirSync(cacheRoot)) {
    const studioDir = join(cacheRoot, dir, 'node_modules', 'hyperframes', 'dist', 'studio');
    if (existsSync(studioDir)) out.push(studioDir);
  }
  return out;
}

function findStudioBundles(studioDir) {
  const assetsDir = join(studioDir, 'assets');
  if (!existsSync(assetsDir)) return [];
  return readdirSync(assetsDir)
    .filter((f) => f.startsWith('index-') && f.endsWith('.js'))
    .map((f) => join(assetsDir, f));
}

function patchFavicon(studioDir) {
  const dest = join(studioDir, 'favicon.svg');
  if (!existsSync(dest)) return 'no-favicon';
  if (!existsSync(BRIGHT_FAVICON_SRC)) return 'no-source';
  const srcSize = statSync(BRIGHT_FAVICON_SRC).size;
  const destSize = statSync(dest).size;
  if (srcSize === destSize) return 'already-patched';
  copyFileSync(BRIGHT_FAVICON_SRC, dest);
  return 'patched';
}

function patchFile(path) {
  const src = readFileSync(path, 'utf8');
  if (src.includes(MARKER)) return 'already-patched';

  const i = src.indexOf('function gP()');
  if (i === -1) return 'no-target';

  // Find matching close brace for the function body, respecting strings.
  const openIdx = src.indexOf('{', i);
  let depth = 0, k = openIdx, inStr = null, esc = false;
  while (k < src.length) {
    const ch = src[k];
    if (esc) { esc = false; }
    else if (inStr) {
      if (ch === '\\') esc = true;
      else if (ch === inStr) inStr = null;
    } else {
      if (ch === '"' || ch === "'" || ch === '`') inStr = ch;
      else if (ch === '{') depth++;
      else if (ch === '}') { depth--; if (depth === 0) break; }
    }
    k++;
  }
  if (depth !== 0) return 'unbalanced-braces';

  const next = src.slice(0, i) + buildReplacement() + src.slice(k + 1);
  writeFileSync(path, next);
  return 'patched';
}

function ensurePinnedCached() {
  // Seed the npx cache for the pinned version if it isn't there yet,
  // so the patch can land on the exact file `npm run dev` will serve.
  try {
    execSync(`npx --yes hyperframes@${PINNED_VERSION} --help`, {
      stdio: 'ignore',
      timeout: 60_000,
    });
  } catch {
    // non-fatal — patch whatever IS cached and let the real command surface errors
  }
}

ensurePinnedCached();
const studioDirs = findStudioDirs();
if (studioDirs.length === 0) {
  console.warn('[patch-studio-logo] no hyperframes studio dir found in npx cache');
  process.exit(0);
}
for (const studioDir of studioDirs) {
  const short = studioDir.replace(homedir(), '~');
  const faviconStatus = patchFavicon(studioDir);
  console.log(`[patch-studio-logo] favicon ${faviconStatus}: ${short}/favicon.svg`);
  for (const bundle of findStudioBundles(studioDir)) {
    const status = patchFile(bundle);
    console.log(`[patch-studio-logo] lockup  ${status}: ${bundle.replace(homedir(), '~')}`);
  }
}
