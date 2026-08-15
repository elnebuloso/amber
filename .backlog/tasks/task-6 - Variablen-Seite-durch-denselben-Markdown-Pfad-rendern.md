---
id: TASK-6
title: Variablen-Seite durch denselben Markdown-Pfad rendern
status: Done
assignee:
  - '@claude'
created_date: '2026-08-15 23:30'
updated_date: '2026-08-15 23:57'
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
- [x] #1 `APP_TEXT_LEAD` mit Markdown darin — mindestens Betonung, Link und eine zweite Überschrift — wird gerendert, und die Sektionsmarke des Systems ist auf der Variablen-Seite sichtbar
- [x] #2 Eine reine Textzeile ohne Markdown sieht danach unverändert aus; bestehende Betreiber merken nichts
- [x] #3 `README.md` beschreibt, was in `APP_TEXT_LEAD` erlaubt ist, einschliesslich der `{{`-Kante
- [x] #4 Der Rauchtest deckt den Markdown-Fall in der Umgebungsvariable ab
- [x] #5 Der Text des Betreibers läuft in beiden Betriebsarten durch dieselbe Markdown-Verarbeitung; `APP_NAME` bleibt literal, damit ein Name nicht umformatiert wird
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Empirisch feststellen, was Caddys `markdown` mit einem Variablenwert macht — statt es aus der Dokumentation abzuleiten. Insbesondere: wird `{{` im Wert ausgeführt, wird rohes HTML durchgereicht, und was passiert mit Sonderzeichen in `APP_NAME`.
2. `app/index.html`: `<p>{{env "APP_TEXT_LEAD"}}</p>` durch `{{markdown (env "APP_TEXT_LEAD")}}` ersetzen. Die Überschrift bleibt literal.
3. `README.md` und `demo/index.md` nachziehen: was in `APP_TEXT_LEAD` erlaubt ist, wie man mehrere Zeilen übergibt, und dass `{{` dort — anders als in der eingehängten Datei — nicht ausgeführt wird.
4. `PRODUCT.md`: die Fähigkeit heisst nicht mehr "eine Überschrift und ein Satz".
5. Rauchtest um den Markdown-Fall in der Variablen erweitern.
6. Beide Oberflächen in hell und dunkel ansehen, Kontrast und Überlauf messen, Detektor.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Messung vor dem Bauen, drei Annahmen der Aufgabenbeschreibung geprüft:

**Die `{{`-Kante gilt hier nicht.** `{{env "APP_NAME"}}` als Wert von `APP_TEXT_LEAD` erscheint wörtlich auf der Seite, kein 500, keine Auswertung. Grund: `include` liest die eingehängte Datei *und wertet sie als Vorlage aus*, `env` liefert nur einen Wert zurück, in den die Engine nicht erneut hineingeht. Die Beschreibung dieser Aufgabe nahm das Gegenteil an.

**Rohes HTML war schon vorher ungefiltert.** Caddys `templates` benutzt `text/template`, nicht `html/template` — `<script>alert(1)</script>` in `APP_TEXT_LEAD` kommt heute genauso ungefiltert durch wie nachher. Die Umstellung öffnet also keine neue Angriffsfläche.

**Der Einpfad-Entwurf fällt aus, und zwar aus einem gemessenen Grund.** Die Variante, in der Name und Text zu einem Markdown-Dokument zusammengesetzt und einmal gerendert werden, macht aus `APP_NAME="*star* site"` ein `<h1><em>star</em> site</h1>`. Ein Name ist ein Name und darf nicht umformatiert werden. Die Überschrift bleibt deshalb literal; durch `markdown` läuft nur der Text des Betreibers. Ein Verzweigungspunkt bleibt damit stehen — er wählt die Quelle, nicht die Darstellung.

Umgesetzt als eine Zeile in `app/index.html`: `<p>{{env "APP_TEXT_LEAD"}}</p>` wird zu `{{markdown (env "APP_TEXT_LEAD")}}`.

Belege für die Kriterien:
- Die Standardseite auf 8080 liefert `<h1>amber</h1><p>This site is not online yet.</p>` — DOM-gleich mit vorher, `h1 + p` greift weiter, die Lead-Behandlung bleibt.
- Eine Variablen-Seite mit Link und zwei `##`-Abschnitten rendert Link, beide `<h2>` und die 2px-Sektionsmarke; in hell und dunkel, bei 1280 und 390 Pixeln aufgenommen, Überlauf jeweils 0px.
- Rauchtest auf 16 Prüfungen erweitert: `<strong>smoke-strong</strong>` belegt die Markdown-Verarbeitung, `{{smoke-brace}}` belegt, dass der Wert eingesetzt und nicht ausgewertet wird.
- `README.md` beschreibt Erlaubtes samt Mehrzeiligkeit über `$\x27...\x27` und stellt richtig, dass `{{` hier nicht ausgeführt wird; `PRODUCT.md` und `demo/index.md` nachgezogen.
- `DESIGN.md` und `.impeccable/design.json` haben die Einschränkung "keine Sektionsmarke auf der Variablen-Seite" gestrichen, weil sie erledigt ist.

Ein Nebeneffekt, bewusst so belassen und im Designrekord festgehalten: beginnt der Text des Betreibers mit einer Überschrift oder Liste, greift `h1 + p` nicht und es gibt keine Lead-Behandlung. Das ist richtig — den Selektor auf `h1 + *` zu lockern würde die Lead-Rolle an jedes beliebige erste Element vergeben.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
`APP_TEXT_LEAD` läuft jetzt durch denselben Markdown-Renderer wie eine eingehängte Datei. Damit erreicht die Variablen-Seite dasselbe Element-Vokabular wie die Markdown-Seite — die Sektionsmarke des Designsystems entsteht aus einer `docker run`-Zeile, ohne dass etwas eingehängt wird.

`APP_NAME` bleibt literal: gemessen wird aus `*star* site` sonst `<h1><em>star</em> site</h1>`, und ein Name darf nicht durch seinen eigenen Wert umformatiert werden. Der verbleibende Verzweigungspunkt wählt deshalb die Quelle, nicht die Darstellung — Kriterium 1 wurde vor der Umsetzung entsprechend umgeschrieben.

Verifiziert mit `make test` (16 Prüfungen, alle grün, zwei davon neu für diesen Pfad), dem Design-Detektor ohne Befund, sechs Aufnahmen über beide Oberflächen in hell und dunkel mit 0px Überlauf, und einem Vergleich des ausgelieferten HTML der Standardseite gegen den vorherigen Stand.
<!-- SECTION:FINAL_SUMMARY:END -->
