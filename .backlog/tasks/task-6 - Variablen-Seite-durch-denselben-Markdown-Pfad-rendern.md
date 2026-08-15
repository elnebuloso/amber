---
id: TASK-6
title: Variablen-Seite durch denselben Markdown-Pfad rendern
status: To Do
assignee: []
created_date: '2026-08-15 23:30'
labels: []
dependencies: []
priority: medium
type: enhancement
ordinal: 6000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Die Kritik vom 15.08.2026 (`.impeccable/critique/2026-08-15T23-25-30Z__app-index-html.md`) hat einen Befund offen gelassen, der bewusst nicht sofort behoben wurde: **das Designsystem erscheint nur auf der Markdown-Seite, nicht auf der Variablen-Seite** — und die ist laut `PRODUCT.md` der gleichwertige Hauptfall.

Der Grund ist strukturell. Die Signatur des Systems — 2px-Linie, darunter 11px Versalien — hängt an `h2`. Der Variablen-Zweig in `app/index.html` erzeugt aber genau `<h1>` und `<p>`, also kein einziges Element, an dem das System sichtbar wird. Zwei Zeilen Helvetica in einer 40rem-Spalte sind mit jedem Baukasten austauschbar.

Der Vorschlag: `APP_TEXT_LEAD` durch dieselbe Markdown-Verarbeitung schicken, die die eingehängte Datei nimmt. Dann gibt es einen Codepfad statt zweier, beide Oberflächen sprechen dieselbe Sprache, und der Betreiber kann eine zweite Zeile, einen Link oder eine Sektion setzen, ohne etwas einzuhängen.

Was dabei zu klären ist: Markdown im Betreiber-Text läuft durch dieselbe Vorlagen-Engine, die `{{` ausführt — die scharfe Kante gilt dann auch für eine Umgebungsvariable. Und `README.md` beschreibt die Variable heute als "eine Zeile"; das stimmt danach nicht mehr.

Der Nutzer hat den Befund ausdrücklich bejaht („beide Oberflächen sollen tragen") und die Umsetzung nur aus dem damaligen Umfang herausgehalten.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Die Variablen-Seite und die Markdown-Seite entstehen aus demselben Codepfad; `app/index.html` hat keine zwei getrennten Zweige mehr
- [ ] #2 `APP_TEXT_LEAD` mit Markdown darin — mindestens Betonung, Link und eine zweite Überschrift — wird gerendert, und die Sektionsmarke des Systems ist auf der Variablen-Seite sichtbar
- [ ] #3 Eine reine Textzeile ohne Markdown sieht danach unverändert aus; bestehende Betreiber merken nichts
- [ ] #4 `README.md` beschreibt, was in `APP_TEXT_LEAD` erlaubt ist, einschliesslich der `{{`-Kante
- [ ] #5 Der Rauchtest deckt den Markdown-Fall in der Umgebungsvariable ab
<!-- AC:END -->
