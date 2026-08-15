#!/usr/bin/env bash
# Smoke test for the placeholder image: starts containers from the given image and checks the
# three ways the page can be produced — environment variables, a markdown file, and a markdown
# file with an extra stylesheet.
set -euo pipefail

IMAGE="${1:?usage: smoke.sh <image>}"
DEMO="$(cd "$(dirname "$0")/.." && pwd)/demo"
NAME="amber-smoke-$$"

cleanup() { docker rm -f "$NAME" >/dev/null 2>&1 || true; }
trap cleanup EXIT

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

check_absent() {
  local label="$1" haystack="$2" needle="$3"
  if [[ "$haystack" != *"$needle"* ]]; then
    printf 'ok   %s\n' "$label"
  else
    printf 'FAIL %s\n       expected NOT to contain: %s\n' "$label" "$needle"
    FAILED=1
  fi
}

# Starts a container from the image under test and prints its base URL.
# Any arguments are passed to docker run, which is how the mounts differ per case.
start() {
  docker rm -f "$NAME" >/dev/null 2>&1 || true
  docker run -d --name "$NAME" -p 127.0.0.1::80 \
    -e APP_NAME=smoke-name \
    -e APP_TEXT_LEAD=smoke-lead \
    "$@" "$IMAGE" >/dev/null
  local port
  port="$(docker port "$NAME" 80 | head -1 | cut -d: -f2)"
  local base="http://127.0.0.1:$port"
  for _ in $(seq 50); do
    curl -sf "$base/" >/dev/null 2>&1 && break
    sleep 0.2
  done
  printf '%s' "$base"
}

echo "-- without a content directory"
BASE="$(start)"
root="$(curl -s "$BASE/")" || true
check "page shows APP_NAME" "$root" "smoke-name"
check "page shows APP_TEXT_LEAD" "$root" "smoke-lead"
check "unknown path serves the page" \
  "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/does/not/exist")" "200"
check "robots header is set" "$(curl -si "$BASE/")" "X-Robots-Tag: noindex, nofollow"
check "stylesheet is served as css" "$(curl -si "$BASE/style.css")" "text/css"

echo "-- with a markdown file"
BASE="$(start -v "$DEMO:/app/content:ro")"
root="$(curl -s "$BASE/")" || true
check "markdown is rendered to html" "$root" "<table>"
check "markdown headings survive" "$root" "<h2"
check "title still comes from APP_NAME" "$root" "<title>smoke-name</title>"
check_absent "the lead text gives way to the markdown" "$root" "smoke-lead"
check "image next to the markdown is served" \
  "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/content/logo.svg")" "200"

echo "-- with an extra stylesheet"
BASE="$(start -v "$DEMO:/app/content:ro" -v "$DEMO/custom.css:/app/content/index.css:ro")"
root="$(curl -s "$BASE/")" || true
check "default stylesheet is linked" "$root" 'href="/style.css"'
check "extra stylesheet is linked" "$root" 'href="/content/index.css"'
check "extra stylesheet is served as css" "$(curl -si "$BASE/content/index.css")" "text/css"

[[ $FAILED -eq 0 ]] && printf '\nall checks passed\n' || printf '\nsmoke test failed\n'
exit $FAILED
