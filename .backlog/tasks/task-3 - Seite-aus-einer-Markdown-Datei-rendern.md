---
id: TASK-3
title: Seite aus einer Markdown-Datei rendern
status: Done
assignee:
  - '@claude'
created_date: '2026-08-15 20:26'
updated_date: '2026-08-15 21:29'
labels: []
dependencies: []
priority: high
type: feature
ordinal: 3000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Liegt `/app/content/index.md` vor, entsteht die Seite daraus; liegt zusaetzlich `/app/content/index.css` vor, ergaenzt es die Vorgaben. Ohne beides bleibt alles wie heute. Additive Aenderung, also 1.2.0.

Entwurf und Vorgehen stehen in `docs/superpowers/specs/2026-08-15-2219-markdown-seite-design.md` und `docs/superpowers/plans/2026-08-15-2222-markdown-seite.md`.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Liegt `/app/content/index.md` vor, wird die Seite daraus gerendert; fehlt sie, gelten weiterhin `APP_NAME` und `APP_TEXT_LEAD`
- [x] #2 `APP_NAME` bleibt in beiden Faellen der Titel im Browser-Tab
- [x] #3 Eine vorhandene `/app/content/index.css` wird nach dem mitgelieferten Stylesheet verlinkt und ergaenzt es damit
- [x] #4 Das Stylesheet deckt ab, was Markdown erzeugt: Ueberschriften bis h6, Listen, Tabellen, Code, Zitate, Bilder, Trennlinien; Tabellen und Codebloecke scrollen bei Ueberbreite in sich selbst
- [x] #5 Bilder neben der Markdown-Datei werden ausgeliefert
- [x] #6 `scripts/smoke.sh` prueft alle drei Faelle und laeuft weiterhin im Release-Workflow
- [x] #7 Die `docker-compose.yml` zeigt die drei Faelle auf 8080, 8081 und 8082; die README beschreibt das Einhaengen
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Umgesetzt in fünf Schritten mit je eigener Prüfung und Review, dazu eine Gesamtprüfung, die einen schwerwiegenden Fehler fand.

Belege: `scripts/smoke.sh` läuft mit 13 Prüfungen über alle drei Betriebsarten grün; im echten Browser gemessen: das Bild aus der Markdown-Datei lädt tatsächlich (300x100 px), Abstände über Absatz, Liste, Zitat, Codeblock und Tabelle einheitlich 20 px, bei 945 px kein waagerechter Überlauf, bei 360 px ebenfalls nicht (nach der Ergänzung `min-width: 0`), Tabelle und Codeblock scrollen in sich; alle drei Compose-Dienste liefern das Versprochene.

Zwei Fehler wurden dabei gefunden und behoben, die ohne die Prüfungen ausgeliefert worden wären: Relative Pfade im Markdown (`![](logo.svg)`) landeten im Catch-All und lieferten die Platzhalterseite statt des Bildes — behoben mit einem zusätzlichen Kandidaten in `try_files`. Und die Abstandsregel `main > * + *` wurde für Listen, Zitate und Codeblöcke von späteren Regeln gleicher Spezifität aufgehoben — behoben, indem diese nur noch den unteren Rand zurücksetzen.

Über den Entwurf hinaus dokumentiert: Der gemountete Ordner wird vollständig ausgeliefert, und das Markdown läuft durch Caddys Template-Engine, weshalb ein `{{` im Inhalt ausgeführt wird und ein kaputtes jede URL mit 500 beantwortet.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Liegt `/app/content/index.md` vor, rendert der Container die Seite daraus; eine `/app/content/index.css` wird danach geladen und ergänzt die Vorgaben. Ohne beides bleibt alles wie zuvor. Das Stylesheet deckt jetzt ab, was Markdown erzeugt, Tabellen und Codeblöcke scrollen bei Überbreite in sich selbst statt die Seite zu sprengen. `demo/` zeigt jedes Element, `docker-compose.yml` alle drei Betriebsarten auf 8080, 8081 und 8082, und `scripts/smoke.sh` prüft sie mit 13 Prüfungen. Additive Änderung, also 1.2.0.
<!-- SECTION:FINAL_SUMMARY:END -->
