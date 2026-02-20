#!/usr/bin/env bash
# build.sh — Generate self-contained skill directories from canonical sources.
#
# Usage:
#   ./scripts/build.sh           Build all skills into skills/
#   ./scripts/build.sh --check   Verify generated files match committed files (for CI)
#
# Each skill in skills/ gets its own copies of the agents, councils, and templates
# it needs (defined in scripts/skill-manifest.json). This ensures skills are
# self-contained when installed via `npx skills add`.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST="${REPO_ROOT}/scripts/skill-manifest.json"
CANONICAL="${REPO_ROOT}/canonical"
SKILLS_SOURCE="${REPO_ROOT}/canonical/skills"
SKILLS_OUTPUT="${REPO_ROOT}/skills"
CHECK_MODE=false

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    --check) CHECK_MODE=true ;;
    *) printf "Unknown argument: %s\n" "$arg"; exit 1 ;;
  esac
done

# Verify prerequisites
if [ ! -f "$MANIFEST" ]; then
  echo "ERROR: Manifest not found at $MANIFEST"
  exit 1
fi

if [ ! -d "$CANONICAL" ]; then
  echo "ERROR: Canonical directory not found at $CANONICAL"
  exit 1
fi

if [ ! -d "$SKILLS_SOURCE" ]; then
  echo "ERROR: Skills source not found at $SKILLS_SOURCE"
  exit 1
fi

# We need a JSON parser — python3 or python.
if command -v python3 >/dev/null 2>&1; then
  JSON_PARSER="python3"
elif command -v python >/dev/null 2>&1; then
  JSON_PARSER="python"
else
  echo "ERROR: python3 or python is required to parse JSON manifest"
  exit 1
fi

# Validate JSON before proceeding
if ! $JSON_PARSER -c "import json, sys; json.load(open(sys.argv[1]))" "$MANIFEST" 2>/dev/null; then
  echo "ERROR: skill-manifest.json contains invalid JSON"
  exit 1
fi

# --- Manifest query functions ---
# All values are passed via sys.argv to avoid shell injection.

get_skills() {
  $JSON_PARSER -c "
import json, sys
with open(sys.argv[1]) as f:
    manifest = json.load(f)
for skill in manifest:
    print(skill)
" "$MANIFEST"
}

get_agents() {
  $JSON_PARSER -c "
import json, sys
with open(sys.argv[1]) as f:
    manifest = json.load(f)
for agent in manifest.get(sys.argv[2], {}).get('agents', []):
    print(agent)
" "$MANIFEST" "$1"
}

get_councils() {
  $JSON_PARSER -c "
import json, sys
with open(sys.argv[1]) as f:
    manifest = json.load(f)
for council in manifest.get(sys.argv[2], {}).get('councils', []):
    print(council)
" "$MANIFEST" "$1"
}

get_templates() {
  $JSON_PARSER -c "
import json, sys
with open(sys.argv[1]) as f:
    manifest = json.load(f)
for template in manifest.get(sys.argv[2], {}).get('templates', []):
    print(template)
" "$MANIFEST" "$1"
}

# Extract frontmatter name from a SKILL.md file
get_frontmatter_name() {
  $JSON_PARSER -c "
import sys
in_fm = False
fm_count = 0
for line in open(sys.argv[1]):
    line = line.strip()
    if line == '---':
        fm_count += 1
        if fm_count == 1:
            in_fm = True
            continue
        elif fm_count == 2:
            break
    if in_fm and line.startswith('name:'):
        print(line.split(':', 1)[1].strip())
        break
" "$1"
}

# Validate SKILL.md frontmatter (name, description, name matches directory)
# Returns: number of errors found (0 = valid)
validate_frontmatter() {
  local skill_file="$1"
  local expected_name="$2"
  local local_errors=0

  local has_name=false
  local has_description=false
  local in_frontmatter=false
  local frontmatter_count=0

  while IFS= read -r line; do
    if [ "$line" = "---" ]; then
      frontmatter_count=$((frontmatter_count + 1))
      if [ $frontmatter_count -eq 1 ]; then
        in_frontmatter=true
        continue
      elif [ $frontmatter_count -eq 2 ]; then
        break
      fi
    fi
    if [ "$in_frontmatter" = true ]; then
      case "$line" in
        name:*) has_name=true ;;
        description:*) has_description=true ;;
      esac
    fi
  done < "$skill_file"

  if [ "$has_name" = false ]; then
    echo "  ERROR: SKILL.md missing 'name' in frontmatter"
    local_errors=$((local_errors + 1))
  fi
  if [ "$has_description" = false ]; then
    echo "  ERROR: SKILL.md missing 'description' in frontmatter"
    local_errors=$((local_errors + 1))
  fi

  local frontmatter_name
  frontmatter_name=$(get_frontmatter_name "$skill_file")
  if [ "$frontmatter_name" != "$expected_name" ]; then
    echo "  ERROR: SKILL.md name '${frontmatter_name}' does not match directory '${expected_name}'"
    local_errors=$((local_errors + 1))
  fi

  return "$local_errors"
}

# Copy resources from canonical into a skill directory.
# Args: resource_type skill_name target_dir
# resource_type is one of: agents, councils, templates
copy_resources() {
  local resource_type="$1"
  local skill="$2"
  local target_dir="$3"
  local count=0
  local resource

  local getter
  case "$resource_type" in
    agents) getter="get_agents" ;;
    councils) getter="get_councils" ;;
    templates) getter="get_templates" ;;
  esac

  while IFS= read -r resource; do
    [ -n "$resource" ] || continue
    local src="${CANONICAL}/${resource_type}/${resource}.md"
    if [ ! -f "$src" ]; then
      echo "  ERROR: Missing canonical ${resource_type%s}: ${resource}"
      errors=$((errors + 1))
      continue
    fi
    mkdir -p "$target_dir/${resource_type}"
    cp "$src" "$target_dir/${resource_type}/${resource}.md"
    count=$((count + 1))
  done < <($getter "$skill")

  echo "$count"
}

# Guard: manifest must define at least one skill
skill_list=$(get_skills)
if [ -z "$skill_list" ]; then
  echo "ERROR: skill-manifest.json defines no skills (empty manifest)"
  exit 1
fi

# Guard: reject unsafe skill names (path traversal protection)
while IFS= read -r name; do
  [ -n "$name" ] || continue
  case "$name" in
    *..* | */* | *\\*)
      echo "ERROR: Unsafe skill name in manifest: '${name}'"
      exit 1
      ;;
  esac
done <<< "$skill_list"

errors=0
skills_built=0

if [ "$CHECK_MODE" = true ]; then
  echo "Running in --check mode (verifying generated files match committed files)..."
  echo ""

  # Build to a temporary directory and compare
  TEMP_DIR=$(mktemp -d)
  trap 'rm -rf "$TEMP_DIR"' EXIT

  while IFS= read -r skill; do
    [ -n "$skill" ] || continue
    skill_dir="${TEMP_DIR}/${skill}"
    mkdir -p "$skill_dir"

    # Copy SKILL.md
    src_skill="${SKILLS_SOURCE}/${skill}/SKILL.md"
    if [ ! -f "$src_skill" ]; then
      echo "ERROR: Missing SKILL.md for skill '${skill}' at ${src_skill}"
      errors=$((errors + 1))
      continue
    fi
    cp "$src_skill" "$skill_dir/SKILL.md"

    # Validate frontmatter (same checks as build mode)
    if ! validate_frontmatter "$skill_dir/SKILL.md" "$skill"; then
      errors=$((errors + 1))
    fi

    # Copy resources
    copy_resources "agents" "$skill" "$skill_dir" > /dev/null
    copy_resources "councils" "$skill" "$skill_dir" > /dev/null
    copy_resources "templates" "$skill" "$skill_dir" > /dev/null
  done <<< "$skill_list"

  # Skip diff if source errors were found — they'd produce misleading drift reports
  if [ $errors -gt 0 ]; then
    echo ""
    echo "FAILED: ${errors} source error(s) found. Fix these before checking for drift."
    exit 1
  fi

  # Compare generated output with committed output
  if [ ! -d "$SKILLS_OUTPUT" ]; then
    echo "ERROR: skills/ directory does not exist. Run './scripts/build.sh' first."
    errors=$((errors + 1))
  else
    # Check for orphaned skill directories (in skills/ but not in manifest).
    for dir in "$SKILLS_OUTPUT"/*/; do
      [ -d "$dir" ] || continue
      dir_name=$(basename "$dir")
      if [ ! -d "${TEMP_DIR}/${dir_name}" ]; then
        echo "ORPHAN: skills/${dir_name}/ exists but is not in the skill manifest"
        errors=$((errors + 1))
      fi
    done

    diff_output=$(diff -rq "$TEMP_DIR" "$SKILLS_OUTPUT" 2>&1) || true
    if [ -n "$diff_output" ]; then
      echo "DRIFT DETECTED: Generated files differ from committed files:"
      echo ""
      echo "$diff_output"
      echo ""
      echo "Run './scripts/build.sh' to regenerate, then commit the changes."
      errors=$((errors + 1))
    else
      echo "OK: All generated files match committed files. No drift detected."
    fi
  fi

  if [ $errors -gt 0 ]; then
    echo ""
    echo "FAILED: ${errors} error(s) found."
    exit 1
  fi
  exit 0
fi

# --- Build mode ---

echo "Building self-contained skill directories..."
echo ""

# Clean skill output directories that are managed by the manifest.
if [ -d "$SKILLS_OUTPUT" ]; then
  while IFS= read -r managed_skill; do
    [ -n "$managed_skill" ] || continue
    if [ -d "${SKILLS_OUTPUT}/${managed_skill}" ]; then
      rm -rf "${SKILLS_OUTPUT}/${managed_skill}"
    fi
  done <<< "$skill_list"
fi

mkdir -p "$SKILLS_OUTPUT"

while IFS= read -r skill; do
  [ -n "$skill" ] || continue
  echo "--- ${skill} ---"
  skill_dir="${SKILLS_OUTPUT}/${skill}"
  mkdir -p "$skill_dir"

  # Copy SKILL.md from source
  src_skill="${SKILLS_SOURCE}/${skill}/SKILL.md"
  if [ ! -f "$src_skill" ]; then
    echo "  ERROR: Missing SKILL.md at ${src_skill}"
    errors=$((errors + 1))
    continue
  fi
  cp "$src_skill" "$skill_dir/SKILL.md"

  # Validate SKILL.md frontmatter
  if ! validate_frontmatter "$skill_dir/SKILL.md" "$skill"; then
    errors=$((errors + 1))
  fi

  # Copy resources from canonical
  agent_count=$(copy_resources "agents" "$skill" "$skill_dir")
  council_count=$(copy_resources "councils" "$skill" "$skill_dir")
  template_count=$(copy_resources "templates" "$skill" "$skill_dir")

  echo "  SKILL.md: copied"
  echo "  Agents: ${agent_count}"
  echo "  Councils: ${council_count}"
  echo "  Templates: ${template_count}"
  echo ""

  skills_built=$((skills_built + 1))
done <<< "$skill_list"

echo "========================================="

if [ "$errors" -gt 0 ]; then
  echo "BUILD FAILED: ${errors} error(s) found."
  exit 1
fi

echo "BUILD SUCCESS: ${skills_built} skill(s) generated in skills/"
