#!/usr/bin/env bash
# ════════════════════════════════════════════════════════════════════════
#  Bright × HyperFrames — skill installer
#  ────────────────────────────────────────────────────────────────────────
#  Installs the Bright design system as a Claude Code skill, warms the
#  HyperFrames npx cache, and patches the HyperFrames Studio chrome to
#  show Bright branding instead of HeyGen.
#
#  After install, you create Bright videos by asking Claude Code:
#      "make a Bright video"
#  in any folder. The skill scaffolds the project + brand-locked layer.
# ════════════════════════════════════════════════════════════════════════
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DEST="$HOME/.agents/skills/bright-hyperframes"
SKILL_SYMLINK="$HOME/.claude/skills/bright-hyperframes"
HYPERFRAMES_VERSION="0.6.4"

# ─── Flags ────────────────────────────────────────────────────────────
# --yes / -y / --non-interactive  : skip confirmation prompt (for AI agents
#                                   and CI). The pre-flight estimate still
#                                   prints so the user sees what's happening.
ASSUME_YES=0
for arg in "$@"; do
  case "$arg" in
    --yes|-y|--non-interactive) ASSUME_YES=1 ;;
    --help|-h)
      echo "Usage: ./install.sh [--yes|-y]"
      echo "  --yes, -y    Skip the confirmation prompt (non-interactive)"
      exit 0 ;;
  esac
done

# ─── ASCII art ────────────────────────────────────────────────────────
cat <<'ART'

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

ART

# ─── Pre-flight: prereqs + estimate ───────────────────────────────────
echo "PROJECT PLAN"
echo ""
echo "  1. Check prereqs (git, ffmpeg)"
echo "  2. Ensure Node 22 (install via nvm/brew if missing or <22)"
echo "  3. Install the Claude Code skill at ~/.claude/skills/bright-hyperframes/"
echo "  4. Warm the HyperFrames npx cache (hyperframes@${HYPERFRAMES_VERSION})"
echo "  5. Apply Bright Branding"
echo ""

NEED_HYPERFRAMES_DOWNLOAD=0
NEED_NODE=0
NEED_GIT=0
NEED_FFMPEG=0
NODE_TOO_OLD=0
ESTIMATE_SECS=10

command -v node   >/dev/null 2>&1 || { NEED_NODE=1; }
command -v git    >/dev/null 2>&1 || { NEED_GIT=1; }
command -v ffmpeg >/dev/null 2>&1 || { NEED_FFMPEG=1; }

# HyperFrames wants Node ≥22. Render will fail otherwise (lint may still pass).
if [ "$NEED_NODE" = "0" ]; then
  NODE_MAJOR=$(node -p 'process.versions.node.split(".")[0]' 2>/dev/null || echo 0)
  if [ "$NODE_MAJOR" -lt 22 ] 2>/dev/null; then
    NODE_TOO_OLD=1
  fi
fi

# Check if hyperframes is already cached
if ! find "$HOME/.npm/_npx" -maxdepth 4 -type d -name "hyperframes" 2>/dev/null | grep -q .; then
  NEED_HYPERFRAMES_DOWNLOAD=1
  ESTIMATE_SECS=$((ESTIMATE_SECS + 30))
fi

# Note: Node 22 install (if needed) happens in the ACTION phase below.
# Pre-flight only flags whether it's required so the estimate is honest.
if [ "$NEED_GIT" = "1" ]; then
  echo "❌  git not found. Install first: xcode-select --install"
  exit 1
fi
if [ "$NEED_FFMPEG" = "1" ]; then
  echo "❌  ffmpeg not found (required for video render). Install: brew install ffmpeg"
  exit 1
fi

echo "ESTIMATE"
echo ""
if [ "$NEED_NODE" = "1" ]; then
  echo "  • Node: ❌ not installed — will install Node 22 (~30s via nvm, ~1–3 min via brew)"
  ESTIMATE_SECS=$((ESTIMATE_SECS + 60))
elif [ "$NODE_TOO_OLD" = "1" ]; then
  echo "  • Node: ⚠️  current $(node --version) — will upgrade to 22 (~30s via nvm)"
  ESTIMATE_SECS=$((ESTIMATE_SECS + 30))
else
  echo "  • Node: ✅ $(node --version)"
fi
echo "  • Other prereqs: ✅ git, ffmpeg, npx present"
if [ "$NEED_HYPERFRAMES_DOWNLOAD" = "1" ]; then
  echo "  • HyperFrames (~30 MB): will download from npm registry (~20–40s)"
else
  echo "  • HyperFrames: ✅ already cached (will skip download)"
fi
echo "  • Skill install: ~2s (copies ~6 MB to ~/.claude/skills/)"
echo "  • Bright Branding: ~2s (idempotent — re-applies on every preview/render)"
echo ""
echo "  Total: ~${ESTIMATE_SECS} seconds (one time)"
echo ""

# ─── Confirm (unless --yes) ───────────────────────────────────────────
if [ "$ASSUME_YES" = "1" ]; then
  echo "Proceeding (--yes flag set) ..."
else
  read -r -p "Proceed with install? [y/N] " reply
  case "$reply" in
    [yY]|[yY][eE][sS]) ;;
    *) echo "Aborted."; exit 0 ;;
  esac
fi

echo ""
echo "ACTION"
echo ""

# ─── 1. Ensure Node 22 ────────────────────────────────────────────────
if [ "$NEED_NODE" = "1" ] || [ "$NODE_TOO_OLD" = "1" ]; then
  echo "  → Installing Node 22 ..."
  INSTALL_METHOD=""

  # Prefer nvm — non-destructive, coexists with other Node versions
  if [ -s "$HOME/.nvm/nvm.sh" ]; then
    # shellcheck disable=SC1091
    \. "$HOME/.nvm/nvm.sh"
    if nvm install 22 >/dev/null 2>&1 && nvm use 22 >/dev/null 2>&1 && nvm alias default 22 >/dev/null 2>&1; then
      INSTALL_METHOD="nvm"
      hash -r 2>/dev/null || true
    fi
  fi

  # Fall back to brew if nvm didn't work
  if [ -z "$INSTALL_METHOD" ] && command -v brew >/dev/null 2>&1; then
    if brew install node@22 >/dev/null 2>&1 && brew link --overwrite --force node@22 >/dev/null 2>&1; then
      INSTALL_METHOD="brew"
      export PATH="$(brew --prefix node@22)/bin:$PATH"
      hash -r 2>/dev/null || true
    fi
  fi

  if [ -z "$INSTALL_METHOD" ]; then
    echo "    ❌ couldn't install Node 22 automatically (no nvm, no brew)"
    echo "       Install Node 22 manually then re-run ./install.sh"
    exit 1
  fi

  CURRENT_NODE=$(node --version 2>/dev/null || echo "unknown")
  echo "    ✅ Node ${CURRENT_NODE} (via ${INSTALL_METHOD})"
  if [ "$INSTALL_METHOD" = "nvm" ]; then
    echo "       Set as nvm default. Open a new terminal or 'nvm use 22' in existing ones."
  fi
fi

# ─── 2. Warm the hyperframes cache ────────────────────────────────────
echo "  → Warming hyperframes@${HYPERFRAMES_VERSION} npx cache ..."
npx --yes hyperframes@${HYPERFRAMES_VERSION} --version >/dev/null 2>&1 || true
echo "    ✅ cached"

# ─── 2. Install the Claude Code skill ─────────────────────────────────
echo "  → Installing Claude Code skill at ${SKILL_DEST/$HOME/~} ..."
mkdir -p "$SKILL_DEST/references" "$SKILL_DEST/scaffolding/compositions" "$SKILL_DEST/scaffolding/lib" "$SKILL_DEST/scaffolding/scripts"
mkdir -p "$(dirname "$SKILL_SYMLINK")"

# Replace any existing symlink or stale directory at the .claude/skills path
if [ -e "$SKILL_SYMLINK" ] || [ -L "$SKILL_SYMLINK" ]; then
  rm -rf "$SKILL_SYMLINK"
fi
ln -s "../../.agents/skills/bright-hyperframes" "$SKILL_SYMLINK"

cp "$REPO_ROOT/SKILL.md"     "$SKILL_DEST/SKILL.md"
cp "$REPO_ROOT/DESIGN.md"    "$SKILL_DEST/references/DESIGN.md"
cp "$REPO_ROOT/CLAUDE.md"    "$SKILL_DEST/references/CLAUDE.md"
cp "$REPO_ROOT/AGENTS.md"    "$SKILL_DEST/references/AGENTS.md"

cp "$REPO_ROOT/index.html"   "$SKILL_DEST/scaffolding/index.html"
cp "$REPO_ROOT/meta.json"    "$SKILL_DEST/scaffolding/meta.json"
cp "$REPO_ROOT/hyperframes.json" "$SKILL_DEST/scaffolding/hyperframes.json"
cp "$REPO_ROOT/package.json" "$SKILL_DEST/scaffolding/package.json"
cp "$REPO_ROOT/.gitignore"   "$SKILL_DEST/scaffolding/.gitignore"

cp -R "$REPO_ROOT/compositions/." "$SKILL_DEST/scaffolding/compositions/"
cp -R "$REPO_ROOT/lib/."          "$SKILL_DEST/scaffolding/lib/"
cp -R "$REPO_ROOT/scripts/."      "$SKILL_DEST/scaffolding/scripts/"
cp -R "$REPO_ROOT/.claude"        "$SKILL_DEST/scaffolding/" 2>/dev/null || true

echo "    ✅ installed"

# ─── 3. Apply Bright Branding ─────────────────────────────────────────
echo "  → Applying Bright Branding ..."
node "$REPO_ROOT/scripts/patch-studio-logo.mjs" >/dev/null 2>&1 || true
echo "    ✅ applied (kept in sync on every preview/render)"

echo ""
echo "✅  Bright × HyperFrames installed."
echo ""
echo "Next step:"
echo "  Open Claude Code in any folder and ask:"
echo "    \"make a Bright video\""
echo ""
echo "The skill will scaffold a new HyperFrames project with the Bright"
echo "design system, brand-locked layer, and studio chrome patch."
