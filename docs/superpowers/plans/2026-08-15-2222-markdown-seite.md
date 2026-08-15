# Umsetzungsplan: Markdown-Seite

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development
> (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use
> checkbox (`- [ ]`) syntax for tracking.

**Ziel:** Liegt `/app/content/index.md` vor, entsteht die Seite daraus; liegt zusätzlich
`/app/content/index.css` vor, ergänzt es die Vorgaben. Ohne beides bleibt alles wie heute.

**Vorgehen:** Zuerst entstehen die Demo-Inhalte und der erweiterte Rauchtest, der damit gegen das
heutige Image fehlschlägt. Dann wird das Template umgestellt, bis er grün ist. Danach Stylesheet,
Entwicklungsumgebung und Abschluss.

**Technik:** Caddy 2 Templates (`fileExists`, `include`, `markdown`), Docker Compose, Bash.

**Spec:** `docs/superpowers/specs/2026-08-15-2219-markdown-seite-design.md`

## Rahmenbedingungen

- Alles im Quellcode ist Englisch: Bezeichner, Kommentare, Commit-Nachrichten, Skriptausgaben,
  Demo-Inhalte und Dokumentation.
- Conventional Commits. Die Änderung ist additiv, also `feat` ohne `!` — sie ergibt 1.2.0.
- Die Dateien des Betreibers liegen unter `/app/content`, niemals direkt in `/app`.
- `APP_NAME` bleibt in beiden Fällen der Titel im Browser-Tab. `APP_TEXT_LEAD` erscheint nur,
  wenn keine `index.md` vorliegt.
- `/content/index.css` wird **nach** `/style.css` verlinkt, damit es ergänzt statt ersetzt.
- Kein CSS-Framework, keine Fremddatei, nichts aus dem Netz nachgeladen.
- Codefärbung bleibt aus, obwohl Caddy die Chroma-Klassen mitliefert.
- Der Entwicklungsport des ersten Dienstes bleibt `127.0.0.1:8080`, die neuen sind `8081` und `8082`.
- Fehlt der Ordner `/app/content` ganz, liefert `fileExists` `false` und der Variablen-Fall greift —
  das Image muss den Ordner nicht anlegen.

---

### Task 1: Demo-Inhalte und erweiterter Rauchtest

Der Rauchtest beschreibt die drei Fälle, die Demo liefert ihm die Inhalte. Beides entsteht
zusammen, weil der Test ohne die Demo nichts zu prüfen hätte. Gegen das heutige Image muss er
fehlschlagen.

**Dateien:**
- Anlegen: `demo/index.md`, `demo/custom.css`, `demo/logo.svg`
- Ersetzen: `scripts/smoke.sh`

**Schnittstelle:**
- Liefert: `./scripts/smoke.sh <image>` prüft weiterhin ein beliebiges Image und gibt bei einem
  Fehlschlag einen Exit-Code ungleich 0 zurück. Task 4 und der Release-Workflow rufen es
  unverändert so auf.
- Liefert: `demo/` als Inhaltsverzeichnis, das die Compose-Dienste in Task 4 einhängen.

- [ ] **Schritt 1: Demo-Markdown anlegen**

`demo/index.md` — enthält absichtlich jedes Element, das GitHub-Markdown kennt, damit die
Abdeckung des Stylesheets sichtbar wird:

````markdown
# amber

A placeholder website rendered from a markdown file. Everything below exists to show what the
stylesheet has to cope with.

## Text

A paragraph with *emphasis*, **strong emphasis**, `inline code`, a [link](https://example.com)
and ~~struck through~~ words. A second sentence keeps the line long enough to wrap on a narrow
screen, which is the only way to see whether the line height is comfortable.

### Third level

#### Fourth level

##### Fifth level

###### Sixth level

## Lists

- first item
- second item
  - nested item
    - deeply nested item
- third item

1. numbered item
2. another one
3. a third

## Table

| variable | meaning | default |
| --- | --- | --- |
| `APP_NAME` | page title and heading | `amber` |
| `APP_TEXT_LEAD` | the line below the heading | `Simple Docker Placeholder Website` |

## Quote

> A placeholder has no business in a search index — least of all under the domain the real site
> is about to use.

## Code

```bash
docker run -p 80:80 \
  -v ./content:/app/content:ro \
  elnebuloso/amber:1.2.0
```

## Image

![the amber logo](logo.svg)

---

The horizontal rule above is part of the test too.
````

- [ ] **Schritt 2: Bild für die Demo anlegen**

`demo/logo.svg` — eine eigene Datei, damit die Demo ohne Netz auskommt und zugleich belegt, dass
Bilder neben der Markdown-Datei gefunden werden:

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 80" role="img" aria-label="amber">
	<rect width="240" height="80" rx="8" fill="#f0b429"/>
	<text x="120" y="52" text-anchor="middle" font-family="system-ui, sans-serif" font-size="32" fill="#1a1a18">amber</text>
</svg>
```

- [ ] **Schritt 3: Eigenes Stylesheet für die Demo anlegen**

`demo/custom.css` — muss auf einen Blick erkennbar anders sein, sonst belegt Port 8082 nichts:

```css
:root {
	--background: #10233b;
	--text: #eef3f8;
	--muted: #9db4cd;
}

h1 {
	color: #7fb2e5;
}
```

- [ ] **Schritt 4: Rauchtest erweitern**

`scripts/smoke.sh` vollständig — die bisherigen Prüfungen bleiben inhaltlich erhalten und werden
um die beiden neuen Fälle ergänzt:

```bash
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
```

Zwei Prüfungen im mittleren Block gehören zusammen und belegen die Regel aus dem Entwurf: `title
still comes from APP_NAME` zeigt, dass der Tab-Titel unabhängig vom Markdown bleibt, und
`the lead text gives way to the markdown` zeigt, dass `APP_TEXT_LEAD` im Rumpf verschwindet. Dafür
gibt es `check_absent` — eine Abwesenheit lässt sich mit `check` nicht ausdrücken.

- [ ] **Schritt 5: Gegen das heutige Image laufen lassen**

```bash
docker build --tag amber:before .
./scripts/smoke.sh amber:before
```

Erwartet: Der erste Block läuft durch, der zweite und dritte schlagen fehl — das heutige Template
kennt weder `/content/index.md` noch `/content/index.css`.

- [ ] **Schritt 6: Commit**

```bash
git add demo scripts/smoke.sh
git commit -m "test: cover the markdown and custom stylesheet cases"
```

---

### Task 2: Template auf Markdown umstellen

**Dateien:**
- Ändern: `app/index.html`
- Ändern: `.dockerignore`

**Schnittstelle:**
- Nutzt: `scripts/smoke.sh` und `demo/` aus Task 1
- Liefert: die Seite entsteht aus `/content/index.md`, wenn die Datei existiert

- [ ] **Schritt 1: Template ersetzen**

`app/index.html` vollständig:

```html
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>{{env "APP_NAME"}}</title>
	<link rel="stylesheet" href="/style.css">
	{{if fileExists "/content/index.css"}}<link rel="stylesheet" href="/content/index.css">{{end}}
</head>
<body>
<main>
	{{if fileExists "/content/index.md"}}{{markdown (include "/content/index.md")}}{{else}}<h1>{{env "APP_NAME"}}</h1>
	<p>{{env "APP_TEXT_LEAD"}}</p>{{end}}
</main>
</body>
</html>
```

- [ ] **Schritt 2: Demo aus dem Build-Kontext nehmen**

In `.dockerignore` die Zeile `demo` ergänzen. Die Demo gehört ins Repository, nicht ins Image —
sie wird zur Laufzeit eingehängt.

- [ ] **Schritt 3: Rauchtest laufen lassen**

```bash
docker build --tag amber:after . && ./scripts/smoke.sh amber:after
```

Erwartet: `all checks passed`, alle drei Blöcke.

- [ ] **Schritt 4: Commit**

```bash
git add app/index.html .dockerignore
git commit -m "feat: render the page from a markdown file when one is present"
```

---

### Task 3: Stylesheet für Markdown erweitern

**Dateien:**
- Ändern: `app/style.css`

- [ ] **Schritt 1: Stylesheet ersetzen**

`app/style.css` vollständig — die bestehenden Regeln bleiben unverändert erhalten, darunter kommen
die Elemente, die Markdown erzeugt:

```css
:root {
	color-scheme: light dark;
	--background: #fbfbfa;
	--text: #1a1a18;
	--muted: #5c5c56;
	--line: #dededa;
	--surface: #f1f1ee;
}

@media (prefers-color-scheme: dark) {
	:root {
		--background: #16161a;
		--text: #ececea;
		--muted: #9a9a95;
		--line: #2f2f35;
		--surface: #1f1f25;
	}
}

*, *::before, *::after {
	box-sizing: border-box;
}

body {
	margin: 0;
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 2rem;
	background: var(--background);
	color: var(--text);
	font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
	line-height: 1.6;
}

main {
	max-width: 34rem;
}

h1 {
	margin: 0 0 0.5rem;
	font-size: clamp(2.5rem, 8vw, 4rem);
	font-weight: 600;
	letter-spacing: -0.02em;
}

p {
	margin: 0;
	font-size: clamp(1.05rem, 2.5vw, 1.25rem);
	color: var(--muted);
}

main > * + * {
	margin-top: 1.25rem;
}

h2, h3, h4, h5, h6 {
	margin: 2rem 0 0;
	font-weight: 600;
	line-height: 1.3;
	letter-spacing: -0.01em;
	color: var(--text);
}

h2 { font-size: 1.6rem; }
h3 { font-size: 1.3rem; }
h4 { font-size: 1.1rem; }
h5 { font-size: 1rem; }
h6 { font-size: 1rem; color: var(--muted); }

a {
	color: inherit;
	text-decoration-color: var(--muted);
	text-underline-offset: 0.2em;
}

a:hover {
	text-decoration-color: currentColor;
}

ul, ol {
	margin: 0;
	padding-left: 1.4rem;
	color: var(--muted);
}

li + li,
li > ul,
li > ol {
	margin-top: 0.35rem;
}

blockquote {
	margin: 0;
	padding-left: 1rem;
	border-left: 3px solid var(--line);
	color: var(--muted);
	font-style: italic;
}

code {
	font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace;
	font-size: 0.9em;
	background: var(--surface);
	padding: 0.15em 0.35em;
	border-radius: 4px;
}

pre {
	margin: 0;
	padding: 0.9rem 1rem;
	background: var(--surface);
	border-radius: 6px;
	overflow-x: auto;
}

pre code {
	background: none;
	padding: 0;
	font-size: 0.85rem;
	line-height: 1.5;
}

table {
	display: block;
	width: max-content;
	max-width: 100%;
	overflow-x: auto;
	border-collapse: collapse;
	font-size: 0.95rem;
}

th, td {
	padding: 0.5rem 0.7rem;
	text-align: left;
	border-bottom: 1px solid var(--line);
}

th {
	font-weight: 600;
}

td {
	color: var(--muted);
}

img {
	max-width: 100%;
	height: auto;
	border-radius: 6px;
}

hr {
	border: 0;
	border-top: 1px solid var(--line);
	margin: 2rem 0;
}
```

Beachte: `p` behält seine große Schrift für den Platzhalter-Fall. Im Markdown-Fall wirkt sie als
angenehme Fließtextgröße, weil die `clamp`-Obergrenze bei 1.25rem liegt.

- [ ] **Schritt 2: Prüfen, dass breite Tabellen die Seite nicht sprengen**

Caddys Markdown erzeugt keine Wrapper-Elemente, deshalb trägt die Tabelle das Scrollen selbst —
`display: block` mit `width: max-content` und `overflow-x: auto`, dieselbe Lösung, die
`github-markdown-css` verwendet. Belege, dass sie greift:

```bash
docker build --tag amber:after . >/dev/null
printf '# wide\n\n| a | b | c | d | e | f | g | h |\n| --- | --- | --- | --- | --- | --- | --- | --- |\n| averylongcell | averylongcell | averylongcell | averylongcell | averylongcell | averylongcell | averylongcell | averylongcell |\n' > /tmp/wide/index.md
docker run --rm -d --name amber-wide -p 127.0.0.1:8095:80 -v /tmp/wide:/app/content:ro amber:after
sleep 2
curl -s http://127.0.0.1:8095/ | grep -c "<table>"
docker rm -f amber-wide
```

Lege `/tmp/wide` vorher an. Erwartet: die Seite enthält die Tabelle. Ob sie den Rumpf waagerecht
sprengt, kannst du im Terminal nicht sehen — halte im Bericht fest, dass dieser Punkt nur durch
Codeprüfung belegt ist, damit die Abnahme ihn nachsehen kann.

- [ ] **Schritt 3: Rauchtest laufen lassen**

```bash
./scripts/smoke.sh amber:after
```

Erwartet: `all checks passed`.

- [ ] **Schritt 4: Commit**

```bash
git add app/style.css
git commit -m "feat: style the elements a markdown page produces"
```

---

### Task 4: Entwicklungsumgebung und Dokumentation

**Dateien:**
- Ersetzen: `docker-compose.yml`
- Ändern: `README.md`

- [ ] **Schritt 1: Compose-Datei ersetzen**

`docker-compose.yml` vollständig. Alle drei Dienste teilen sich `image: amber:local`, damit Compose
das Image einmal baut statt dreimal:

```yaml
services:
  amber:
    image: amber:local
    build:
      context: .
    ports:
      - 127.0.0.1:8080:80
    volumes:
      - ./app:/app
    environment:
      APP_NAME: amber
      APP_TEXT_LEAD: Simple Docker Placeholder Website

  amber-markdown:
    image: amber:local
    build:
      context: .
    ports:
      - 127.0.0.1:8081:80
    volumes:
      - ./demo/index.md:/app/content/index.md:ro
      - ./demo/logo.svg:/app/content/logo.svg:ro
    environment:
      APP_NAME: amber

  amber-custom:
    image: amber:local
    build:
      context: .
    ports:
      - 127.0.0.1:8082:80
    volumes:
      - ./demo/index.md:/app/content/index.md:ro
      - ./demo/logo.svg:/app/content/logo.svg:ro
      - ./demo/custom.css:/app/content/index.css:ro
    environment:
      APP_NAME: amber
```

Zwei Dinge daran sind bewusst so und dürfen nicht „vereinfacht" werden:

**Einzelne Dateien statt des Ordners.** Hängt man `./demo` als Ganzes auf `/app/content` und legt dann
`./demo/custom.css` auf `/app/content/index.css`, muss Docker den inneren Mountpunkt anlegen — und
weil `/app/content` derselbe Host-Ordner ist, entsteht eine leere `demo/index.css` **im
Repository**. Das ist beim Rauchtest tatsächlich passiert. Mit Einzeldatei-Mounts gibt es kein
Verzeichnis, das sich selbst überlagert; `/app/content` entsteht im Container.

**Kein `./app:/app` bei den beiden Demo-Diensten.** Derselbe Grund: Läge `/app` auf dem
Arbeitsverzeichnis, würden die content-Mounts wieder Dateien auf dem Host anlegen. Der erste Dienst
behält den Mount, weil man dort am Template arbeitet; die Demo-Dienste zeigen das fertige Image.

- [ ] **Schritt 2: README ergänzen**

Nach dem Abschnitt `## environment variables` einen neuen Abschnitt einfügen, im knappen Ton der
Datei, englisch:

````markdown
## markdown page

Mount a directory containing an `index.md` at `/app/content` and the page is rendered from it
instead of the environment variables. `APP_NAME` stays the browser tab title.

```
docker run -p 80:80 \
  -e APP_NAME="my site" \
  -v ./content:/app/content:ro \
  elnebuloso/amber:1.2.0
```

An `index.css` in the same directory is loaded after the built-in stylesheet, so a few lines are
enough to change colours. Images next to the markdown file are served as well.
````

Im Abschnitt `## development` die drei Ports ergänzen, damit klar ist, was `make up` startet:

```
make up      # 8080 plain, 8081 markdown, 8082 markdown with a custom stylesheet
make down
make test    # builds the image and runs the smoke test against it
```

- [ ] **Schritt 3: Alle drei Dienste ausprobieren**

```bash
make up
curl -s http://127.0.0.1:8080/ | grep -o "<h1>.*</h1>"
curl -s http://127.0.0.1:8081/ | grep -c "<table>"
curl -s http://127.0.0.1:8082/ | grep -o 'href="/content/index.css"'
make down
```

Erwartet: 8080 zeigt `<h1>amber</h1>`, 8081 enthält eine Tabelle, 8082 verlinkt das zusätzliche
Stylesheet.

- [ ] **Schritt 4: Commit**

```bash
git add docker-compose.yml README.md
git commit -m "chore: show all three page modes in compose"
```

---

### Task 5: Abschluss

- [ ] **Schritt 1: Vollständiger Durchlauf**

```bash
make test
make up
curl -si http://127.0.0.1:8081/deep/nested/path | head -3
make down
```

Erwartet: `all checks passed`, und auch unter einem tiefen Pfad kommt die gerenderte Seite mit 200.

- [ ] **Schritt 2: Aufräumen prüfen**

```bash
git status --short
docker image rm amber:before amber:after amber:local amber:dev 2>/dev/null || true
```

Erwartet: ein sauberes Arbeitsverzeichnis.

- [ ] **Schritt 3: Bericht**

Halte fest, was der nächste Release ausweisen wird: ein `feat`-Commit für das Rendern, einer für
das Stylesheet, also 1.2.0. Prüfe mit `git log --oneline` seit `v1.1.0`, dass die Betreffzeilen als
Release-Notiz taugen — sie sind der einzige öffentliche Text zu dieser Version.
