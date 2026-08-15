---
id: TASK-4
title: Markdown-Unterstützung und -Gestaltung vervollständigen
status: To Do
assignee: []
created_date: '2026-08-15 21:32'
updated_date: '2026-08-15 21:44'
labels: []
dependencies: []
priority: medium
type: enhancement
ordinal: 4000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Die Seite rendert Markdown über Caddys `templates`, und zwar mit mehr Umfang als heute abgedeckt ist. Aus dem Quelltext von Caddy (`modules/caddyhttp/templates/tplcontext.go`, Funktion `funcMarkdown`) geht hervor, was aktiviert ist: `extension.GFM` (Tabellen, Durchstreichen, Autolinks und **Aufgabenlisten**), `extension.Footnote` (**Fussnoten**), Syntaxklassen über Chroma, automatische Überschriften-IDs und rohes HTML durch `WithUnsafe`.

Aufgabenlisten und Fussnoten erzeugen damit HTML, das weder in `demo/index.md` vorkommt noch in `app/index.css` eine Regel hat — eine Aufgabenliste bringt `<input type="checkbox">` mit, Fussnoten bringen `<sup>`-Verweise, einen `<section class="footnotes">`-Block und Rücksprungpfeile. Ungeprüft ist ausserdem, wie sich verschachtelte Zitate, Definitionslisten und eingebettetes rohes HTML verhalten.

`demo/index.md` ist dabei nicht nur Beiwerk, sondern der Prüfstein: An dieser einen Seite muss sich die Gestaltung vollständig beurteilen lassen. Wer künftig eine Regel ins Stylesheet schreibt, ergänzt dort das zugehörige Beispiel — und umgekehrt darf kein Konstrukt in der Demo fehlen, das die App rendern kann. Nur so ist "vollständig gestylt" überhaupt nachprüfbar statt behauptet.

Zweiter Teil: Die Darstellung soll sich in beiden Farbschemata von selbst richtig einstellen. Für die vorhandenen Elemente ist das belegt, einschliesslich der vier Töne der Codefärbung; für die noch fehlenden nicht.

Der Umfang ist Prüfen und Ergänzen, nicht Umbauen. Ein eigenes Stylesheet des Betreibers gibt es nicht mehr und kommt auch nicht zurück — die Vorgaben sind eine Datei, `app/index.css`.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Es ist belegt und festgehalten, welche Markdown-Konstrukte die App rendert und welches HTML dabei entsteht
- [ ] #2 `demo/index.md` ist eine vollständige Demoseite: Sie enthält jedes Konstrukt, das die App rendern kann — Aufgabenliste und Fussnoten eingeschlossen — sodass sich die Gestaltung an dieser einen Seite komplett beurteilen lässt
- [ ] #3 Jedes erzeugte Element hat entweder eine Regel in `app/index.css` oder ist begründet ausgenommen; kein gestyltes Element fehlt in der Demo und kein Demo-Element ist ungestylt
- [ ] #4 Jedes Element ist in hellem und dunklem Schema geprüft; der Kontrast von Text zu Hintergrund erreicht mindestens die AA-Schwelle
<!-- AC:END -->
