#!/usr/bin/env bash
# Smoke test for the placeholder image: starts a container from the given image
# and checks the four things that can break without anyone noticing.
set -euo pipefail

IMAGE="${1:?usage: smoke.sh <image>}"
NAME="amber-smoke-$$"

cleanup() { docker rm -f "$NAME" >/dev/null 2>&1 || true; }
trap cleanup EXIT

docker run -d --name "$NAME" -p 127.0.0.1::80 \
  -e APP_NAME=smoke-name \
  -e APP_TEXT_LEAD=smoke-lead \
  "$IMAGE" >/dev/null

PORT="$(docker port "$NAME" 80 | head -1 | cut -d: -f2)"
BASE="http://127.0.0.1:$PORT"

for _ in $(seq 50); do
  curl -sf "$BASE/" >/dev/null 2>&1 && break
  sleep 0.2
done

FAILED=0
check() {
  local label="$1" haystack="$2" needle="$3"
  if [[ "$haystack" == *"$needle"* ]]; then
    printf 'ok   %s\n' "$label"
  else
    printf 'FAIL %s\n       expected to contain: %s\n       got: %s\n' "$label" "$needle" "$haystack"
    FAILED=1
  fi
}

root="$(curl -s "$BASE/")" || true
check "page shows APP_NAME" "$root" "smoke-name"
check "page shows APP_TEXT_LEAD" "$root" "smoke-lead"
check "unknown path serves the page" \
  "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/does/not/exist")" "200"
check "robots header is set" "$(curl -si "$BASE/")" "X-Robots-Tag: noindex, nofollow"
check "stylesheet is served as css" "$(curl -si "$BASE/style.css")" "text/css"

[[ $FAILED -eq 0 ]] && printf '\nall checks passed\n' || printf '\nsmoke test failed\n'
exit $FAILED
