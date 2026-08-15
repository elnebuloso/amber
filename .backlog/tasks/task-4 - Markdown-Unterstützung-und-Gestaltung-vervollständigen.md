---
id: TASK-4
title: Markdown-Unterstützung und -Gestaltung vervollständigen
status: Done
assignee:
  - '@claude'
created_date: '2026-08-15 21:32'
updated_date: '2026-08-15 22:10'
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
- [x] #1 Es ist belegt und festgehalten, welche Markdown-Konstrukte die App rendert und welches HTML dabei entsteht
- [x] #2 `demo/index.md` ist eine vollständige Demoseite: Sie enthält jedes Konstrukt, das die App rendern kann — Aufgabenliste und Fussnoten eingeschlossen — sodass sich die Gestaltung an dieser einen Seite komplett beurteilen lässt
- [x] #3 Jedes erzeugte Element hat entweder eine Regel in `app/index.css` oder ist begründet ausgenommen; kein gestyltes Element fehlt in der Demo und kein Demo-Element ist ungestylt
- [x] #4 Jedes Element ist in hellem und dunklem Schema geprüft; der Kontrast von Text zu Hintergrund erreicht mindestens die AA-Schwelle
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Empirisch feststellen, was der Renderer tatsächlich erzeugt: eine Prüfdatei mit allen Konstrukten rendern und das HTML auslesen — Aufgabenliste, Fussnoten, Durchstreichen, Autolink, verschachteltes Zitat, Definitionsliste, rohes HTML.
2. `demo/index.md` um die Konstrukte ergänzen, die tatsächlich unterstützt sind.
3. `app/index.css` um Regeln für die neuen Elemente erweitern; alles ohne Regel begründet ausnehmen.
4. Im Browser messen: jedes Element in hell und dunkel, Kontrast gegen AA prüfen.
5. `DESIGN.md` nachziehen — der Abschnitt "Not yet in the system" wird aufgelöst oder auf den verbleibenden Rest reduziert.
6. Rauchtest und Abschluss.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Statt aus der Dokumentation abgeleitet wurde empirisch gemessen, was der Renderer erzeugt: eine Prüfdatei mit allen Kandidaten wurde gerendert und das HTML ausgelesen.

Ergebnis: Aufgabenlisten kommen als gewöhnliches `<li>` mit führender `<input type="checkbox">` und **ohne Klasse**; Fussnoten als `<sup><a class="footnote-ref">` plus abschliessendes `<div class="footnotes">` mit eigener `<hr>`, Liste und Rücksprungpfeilen — nicht als `<section>`, wie das Design-Dokument zuvor behauptete; Durchstreichen als `<del>`; blosse Adressen werden verlinkt; verschachtelte Zitate als `<blockquote>` im `<blockquote>`; rohes HTML wird durchgereicht, `<details>`/`<summary>` funktioniert damit. Definitionslisten erzeugt der Renderer **nicht** — die Erweiterung ist nicht aktiv, das Markdown bleibt ein Absatz mit Doppelpunkt.

Neue Regeln in `app/index.css`: Aufgabenlisten (Marker je Element entfernt, damit ein gewöhnliches Element in derselben Liste seinen Punkt behält; Einzug um die Listenbreite zurückgenommen; Checkbox in gedämpfter Farbe), verschachtelte Zitate (Abstand nach oben, den die Rhythmusregel nicht erreicht, weil sie kein Kind der Spalte sind), `summary` (Gewicht und Zeiger), Fussnoten (Verweis und Rückpfeil ohne Unterstreichung, Block in Label-Grösse und gedämpfter Farbe).

Im Browser gemessen: Marker entfernt (`list-style: none`), gewöhnliches Element behält `disc`, Checkbox-Abstand 7,2 px, verschachteltes Zitat 20 px Abstand und 59 px eingerückt, Fussnotenblock 15,2 px in gedämpfter Farbe, beide Fussnotenmarken ohne Unterstreichung, `summary` mit Gewicht 600 und Zeiger.

Kontraste über alle acht Paarungen in beiden Schemata gerechnet: Überschriften 16,83/15,25 — Fliesstext und Listen 6,5/6,38 — Inline-Code 15,4/13,86 — Code-Kommentar 4,76/4,86 — Zeichenkette 6,03/7,83 — Schlüsselwort 6,32/7,44 — Zahl 5,85/8,37. Alle über der AA-Schwelle von 4,5.

Ausdrücklich nicht bestanden und bewusst so: Die Haarlinie liegt bei 1,3:1. Sie ist Dekoration, nie Information — ein Zitat ist zusätzlich kursiv und eingerückt, eine Tabelle trägt ihre Struktur im Markup. Als `The Decorative Hairline Rule` im Design-Dokument festgehalten, samt der Bedingung, unter der sie ihren eigenen Kontrast bräuchte.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Der Renderer-Umfang ist jetzt gemessen statt vermutet, und die drei Konstrukte ohne Regel haben eine: Aufgabenlisten, Fussnoten und Disclosures. `demo/index.md` enthält jedes Konstrukt, das die App erzeugen kann, sodass die Abdeckung an einer Seite prüfbar bleibt; `DESIGN.md` beschreibt sie und benennt, was bewusst dem Browser überlassen bleibt und was der Renderer gar nicht erst produziert. Alle Textkontraste liegen in beiden Schemata über AA, der niedrigste bei 4,76; die Haarlinie liegt bewusst darunter und ist als Dekoration ohne Informationsgehalt festgeschrieben.
<!-- SECTION:FINAL_SUMMARY:END -->
