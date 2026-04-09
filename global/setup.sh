#!/usr/bin/env bash
# global/setup.sh -- Symlink global Crush config, skills, agents, and resources
#
# Run from the repo root:
#   ./global/setup.sh
#
# Idempotent -- safe to run multiple times. Existing symlinks are updated.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GLOBAL_DIR="${REPO_ROOT}/global"
CRUSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/crush"

log()  { echo "  $*"; }
ok()   { echo "  [ok] $*"; }
link() { echo "  [link] $*"; }

echo ""
echo "Crush Global Setup"
echo "=================="
echo "Repo:   ${REPO_ROOT}"
echo "Target: ${CRUSH_CONFIG_DIR}"
echo ""

# Create config dir if needed
mkdir -p "${CRUSH_CONFIG_DIR}/skills"

# --- Global Config ---
echo "Config:"
src="${GLOBAL_DIR}/crush.json"
dst="${CRUSH_CONFIG_DIR}/crush.json"
if [ -e "${dst}" ] && [ ! -L "${dst}" ]; then
  echo "  [warn] ${dst} exists and is not a symlink -- skipping (rename it to crush.json.bak if you want to replace it)"
else
  ln -sf "${src}" "${dst}"
  link "crush.json -> ${src}"
fi

# --- Global Instructions ---
echo ""
echo "Instructions:"
src="${GLOBAL_DIR}/instructions.md"
dst="${CRUSH_CONFIG_DIR}/global-instructions.md"
ln -sf "${src}" "${dst}"
link "global-instructions.md -> ${src}"

# --- Skills ---
echo ""
echo "Skills:"
for skill_dir in "${GLOBAL_DIR}/skills"/*/; do
  [ -d "${skill_dir}" ] || continue
  skill_name="$(basename "${skill_dir}")"
  dst="${CRUSH_CONFIG_DIR}/skills/${skill_name}"
  ln -sf "${skill_dir}" "${dst}"
  link "${skill_name}/ -> ${skill_dir}"
done

# --- Agents ---
echo ""
echo "Agents:"
src="${GLOBAL_DIR}/agents"
dst="${CRUSH_CONFIG_DIR}/agents"
ln -sf "${src}" "${dst}"
link "agents/ -> ${src}"

# --- Resources ---
echo ""
echo "Resources:"
src="${GLOBAL_DIR}/resources"
dst="${CRUSH_CONFIG_DIR}/resources"
ln -sf "${src}" "${dst}"
link "resources/ -> ${src}"

# --- Verification ---
echo ""
echo "Verification:"
echo ""

skill_count=$(find "${CRUSH_CONFIG_DIR}/skills" -maxdepth 2 -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ')
agent_count=$(find "${CRUSH_CONFIG_DIR}/agents" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
resource_count=$(find "${CRUSH_CONFIG_DIR}/resources" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

ok "Skills registered: ${skill_count} SKILL.md files"
ok "Agent templates:   ${agent_count} templates"
ok "Resources:         ${resource_count} reference files"
ok "Global config:     ${CRUSH_CONFIG_DIR}/crush.json"
ok "Global rules:      ${CRUSH_CONFIG_DIR}/global-instructions.md"

echo ""
echo "Done. Crush will load global skills, config, and instructions from:"
echo "  ${CRUSH_CONFIG_DIR}"
echo ""
echo "To add a new global skill later:"
echo "  1. Add it to ${GLOBAL_DIR}/skills/<name>/SKILL.md"
echo "  2. Re-run this script (it's idempotent)"
echo ""
