#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

TARGETS=(src/main/java)
while IFS= read -r domain_dir; do
  TARGETS+=("$domain_dir")
done < <(find domains -type d -path '*/src/main/java' | sort)

ERROR_COUNT=0

is_allowed_cross_domain_dependency() {
  local source_domain="$1"
  local target_domain="$2"

  case "${source_domain}:${target_domain}" in
    chat:scenario|chat:content|scenario:chat|scenario:content|social:auth|social:content|social:chat)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

report_violation() {
  local code="$1"
  local location="$2"
  local message="$3"

  ERROR_COUNT=$((ERROR_COUNT + 1))
  printf 'ERROR[%s] %s\n' "$code" "$location"
  printf '  -> %s\n' "$message"
}

collect_java_files() {
  find "${TARGETS[@]}" -type f -name '*.java' | sort
}

while IFS= read -r file; do
  [[ -z "$file" ]] && continue

  if [[ "$file" == *"/interfaces/"* ]]; then
    while IFS=: read -r line_num import_line; do
      [[ -z "$line_num" ]] && continue
      report_violation \
        "INTERFACES_MAPPER_IMPORT" \
        "${file}:${line_num}" \
        "Interfaces layer must not import mapper types directly. Route via application facade/service instead. Found: ${import_line}"
    done < <(rg -n '^import com\.gaji\..*\.infrastructure\.persistence\.mapper\..*;$' "$file" || true)
  fi

  if [[ "$file" != *"/application/"* ]]; then
    continue
  fi

  source_domain="$(sed -nE 's/^package com\.gaji\.([a-z]+)\.application(\..*)?;$/\1/p' "$file" | head -n1)"
  if [[ -z "$source_domain" ]]; then
    continue
  fi

  while IFS=: read -r line_num import_line; do
    [[ -z "$line_num" ]] && continue
    target_domain="$(echo "$import_line" | sed -E 's/^import com\.gaji\.([a-z]+)\.infrastructure\.persistence\.mapper\..*;$/\1/')"
    if [[ "$source_domain" != "$target_domain" ]]; then
      report_violation \
        "APP_CROSS_DOMAIN_MAPPER_IMPORT" \
        "${file}:${line_num}" \
        "Application layer cannot import cross-domain mapper directly (${source_domain} -> ${target_domain}). Use ${target_domain}.application.*Facade instead."
    fi
  done < <(rg -n '^import com\.gaji\..*\.infrastructure\.persistence\.mapper\..*;$' "$file" || true)

  while IFS=: read -r line_num import_line; do
    [[ -z "$line_num" ]] && continue

    target_domain="$(echo "$import_line" | sed -E 's/^import com\.gaji\.([a-z]+)\.application\.[A-Za-z0-9_]+;$/\1/')"
    target_class="$(echo "$import_line" | sed -E 's/^import com\.gaji\.[a-z]+\.application\.([A-Za-z0-9_]+);$/\1/')"

    if [[ "$source_domain" == "$target_domain" ]]; then
      continue
    fi

    if [[ ! "$target_class" =~ Facade$ ]]; then
      report_violation \
        "APP_CROSS_DOMAIN_NON_FACADE" \
        "${file}:${line_num}" \
        "Cross-domain dependency must target *Facade (${source_domain} -> ${target_domain}). Found: ${target_class}."
    fi

    if ! is_allowed_cross_domain_dependency "$source_domain" "$target_domain"; then
      report_violation \
        "APP_CROSS_DOMAIN_NOT_ALLOWLISTED" \
        "${file}:${line_num}" \
        "Dependency pair ${source_domain} -> ${target_domain} is not allow-listed. Update architecture policy intentionally before using it."
    fi
  done < <(rg -n '^import com\.gaji\.[a-z]+\.application\.[A-Za-z0-9_]+;$' "$file" || true)
done < <(collect_java_files)

if [[ "$ERROR_COUNT" -gt 0 ]]; then
  echo
  echo "Facade-first policy check failed with ${ERROR_COUNT} violation(s)."
  echo "Fix imports first, then rerun: ./scripts/ci/verify-facade-first-policy.sh"
  exit 1
fi

echo "Facade-first policy check passed (grep guard + allow-list validation)."
