#!/usr/bin/env bash
# Smoke test for the placeholder image: starts containers from the given image and checks the
# two ways the page can be produced — environment variables, or a markdown file.
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
    -e APP_LANG=smoke-lang \
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
check "APP_LANG reaches the html element" "$root" '<html lang="smoke-lang">'
check "unknown path serves the page" \
  "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/does/not/exist")" "200"
check "robots header is set" "$(curl -si "$BASE/")" "X-Robots-Tag: noindex, nofollow"
check "tokens are served as css" "$(curl -si "$BASE/tokens.css")" "text/css"
check "styles are served as css" "$(curl -si "$BASE/style.css")" "text/css"
check "the mono face is served from the image" \
  "$(curl -sI "$BASE/fonts/ibm-plex-mono-400.woff2")" "font/woff2"

echo "-- with a markdown file"
# One plain directory mount, deliberately. Layering a second mount onto a file inside it makes
# Docker create that mount point in the host directory — which once left a stray file in demo/.
BASE="$(start -v "$DEMO:/app/content:ro")"
root="$(curl -s "$BASE/")" || true
check "markdown is rendered to html" "$root" "<table>"
check "markdown headings survive" "$root" "<h2"
check "code is highlighted" "$root" 'class="chroma"'
check "title still comes from APP_NAME" "$root" "<title>smoke-name</title>"
check_absent "the lead text gives way to the markdown" "$root" "smoke-lead"
# Ask for the URL the page actually requests, not one we assume. Empty on no match, which the
# check below then reports as a failure rather than aborting the script.
image_src="$(grep -o 'src="[^"]*"' <<<"$root" | head -1 | cut -d'"' -f2 || true)"
check "image next to the markdown is served as svg" \
  "$(curl -si "$BASE/${image_src#/}")" "image/svg+xml"

[[ $FAILED -eq 0 ]] && printf '\nall checks passed\n' || printf '\nsmoke test failed\n'
exit $FAILED
