---
id: TASK-5
title: Seite auf das gelieferte Design-System umstellen
status: Done
assignee:
  - '@claude'
created_date: '2026-08-15 23:04'
updated_date: '2026-08-15 23:05'
labels: []
dependencies: []
priority: high
type: feature
ordinal: 5000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Der Betreiber hat ein fertiges Design-System als Code geliefert — `tokens.css`, `style.css` und eine handgeschriebene Beispielseite unter `.tmp/`. Die Seite soll 1:1 darauf umgestellt werden: hell und dunkel, alle Werte aus den gelieferten Dateien, keine zweite Quelle daneben.

Das gelieferte System kennt nur die Elemente seiner eigenen Beispielseite. Was unser Renderer darüber hinaus erzeugt — die Chroma-Klassen der Syntaxfärbung, `<details>`/`<summary>`, verschachtelte Zitate, Aufgabenlisten, Fussnoten in der Form, die Goldmark tatsächlich ausgibt — bekommt eine aus dem System abgeleitete Darstellung, keine neue Idee.

Ein Punkt steht dem 1:1 im Weg: die Beispielseite lädt IBM Plex Mono von Google Fonts. `PRODUCT.md` schliesst Netzabrufe zur Laufzeit dauerhaft aus, die Seite muss offline vollständig rendern. Die Schrift muss also mit dem Image kommen oder entfallen.

`DESIGN.md` beschreibt danach die abgelöste Welt und ist neu zu schreiben; `PRODUCT.md` ist nachzuziehen, wo sich Produktwahrheit ändert. Nach der Umstellung ist `.tmp/` überflüssig.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Die Seite rendert in beiden Betriebsarten — Variablen und eingehängtes Markdown — vollständig aus den gelieferten Dateien; `app/index.css` ist abgelöst
- [x] #2 Jedes Element, das der Renderer erzeugt, hat eine Regel aus dem gelieferten System oder eine daraus abgeleitete; kein Element bleibt ungestaltet und keine Regel ohne Erzeuger
- [x] #3 Die Seite rendert ohne Netzzugriff vollständig, einschliesslich der Monospace-Schrift
- [x] #4 Text erreicht in beiden Farbschemata mindestens AA; die Werte sind im Browser gemessen, nicht geschätzt
- [x] #5 Kein waagerechtes Schieben des Dokuments auf schmalen und breiten Fenstern, in beiden Betriebsarten
- [x] #6 `DESIGN.md` beschreibt die gebaute Welt; `PRODUCT.md` stimmt mit dem Ausgelieferten überein; `.tmp/` ist entfernt
- [x] #7 Rauchtest und Design-Detektor laufen ohne Befund
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Geliefertes System und laufende Seite lesen; Konflikte zur Produktwahrheit benennen und entscheiden lassen (Schrift, nicht-Markdown-Elemente, Dateiaufteilung).
2. `tokens.css` und `style.css` nach `app/` übernehmen, `index.css` ablösen, beide im Kopf verlinken.
3. Was das System nicht kannte, daraus ableiten: echte Chroma-Klassen, Disclosure, verschachteltes Zitat, Fokusring, Textauswahl, Wortumbruch.
4. Im Browser messen statt schätzen: Kontrast aller Textpaare in hell und dunkel, waagerechtes Schieben, acht Aufnahmen über beide Betriebsarten.
5. Finish-Review und Dokumentierer einsetzen; deren Befunde in einem Durchgang abarbeiten.
6. `DESIGN.md` neu, `PRODUCT.md` nachziehen, `.tmp/` entfernen, Rauchtest und Detektor.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Vier Entscheidungen wurden vorgelegt und getroffen: IBM Plex Mono kommt als zwei `woff2` mit ins Image statt von Google Fonts (`PRODUCT.md` schliesst Netzabrufe aus); die `.eyebrow`-Zeile der Vorlage entfällt ganz; die Aufteilung in `tokens.css` und `style.css` bleibt; kurze Seiten werden optisch mittig gesetzt (`min-height: 100vh`), weil der Hauptfall des Produkts zwei Zeilen auf leerer Fläche sind und die Vorlage nur lange Seiten im Blick hatte.

Zwei Werte der Vorlage haben nicht getragen und wurden korrigiert: `--code-comment` lag mit 4,20:1 gegen die gesenkte Codefläche unter AA und ist eine Stufe dunkler (`oklch(0.54 …)`, gemessen 4,58:1); `h5` und `h6` waren von `h4` nicht zu unterscheiden und treten nun im Ton zurück, weil die Skala vor den Überschriftenebenen ausgeht.

Abgeleitet, weil die Beispielseite diese Fälle nicht erzeugt: die vollständigen Chroma-Klassen des Renderers auf die vier Töne, `summary`/`details`, ein verschachteltes Zitat als Haarlinie statt zweiter Tönung, `:focus-visible`, `::selection`, `color-scheme` und `overflow-wrap`. Nicht übernommen wurde `.placeholder` — die Attrappe der Vorlage für ein Bild.

Aus der Finish-Review kamen fünf Befunde: `demo/logo.svg` war eine Wortmarke auf abgerundetem Gelb in `system-ui` und widersprach damit `PRODUCT.md` und drei Regeln des Systems — ersetzt durch ein neutrales Streifenfeld in `<figure>`; die Aufgaben-Checkbox blieb grau, weil der Renderer sie `disabled` ausgibt und ein deaktiviertes Bedienelement `accent-color` ignoriert — sie wird jetzt selbst gezeichnet; `summary::marker` trägt den Akzent; der Detektor lief ohne seine vier Parser-Module und prüfte weder Custom Properties noch berechneten Kontrast — nachinstalliert und sauber wiederholt.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Die Seite entsteht jetzt vollständig aus `app/tokens.css` und `app/style.css`, IBM Plex Mono liegt als `woff2` im Image. `DESIGN.md` und `.impeccable/design.json` beschreiben die gebaute Welt, `.tmp/` ist entfernt.

Belegt statt behauptet: Kontrast aller 13 Textpaare in beiden Schemata im Browser aus den lebenden Tokens gerechnet, 26 von 26 über 4,5:1, niedrigster Wert 4,58:1; kein waagerechtes Schieben auf allen acht Aufnahmen (Variablen- und Markdown-Seite, je 1280 und 390 Pixel, hell und dunkel); `make test` 13 Prüfungen grün; `detect.mjs` mit vollständigem Parser ohne Befund. Die Finish-Review hat die fünf Korrekturen einzeln nachbewertet und alle als erledigt gewertet — das Urteil deckt diese fünf Punkte und die acht Aufnahmen, nicht die gesamte Oberfläche.
<!-- SECTION:FINAL_SUMMARY:END -->
