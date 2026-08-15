---
id: TASK-2
title: Platzhalterseite auf Caddy umstellen
status: Done
assignee:
  - '@claude'
created_date: '2026-08-15 18:58'
updated_date: '2026-08-15 19:42'
labels: []
dependencies: []
priority: high
type: feature
ordinal: 2000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Die Laufzeit wechselt von PHP 7.3 mit Apache auf `caddy:2-alpine`, Bootstrap entfaellt ersatzlos. Nutzung, Umgebungsvariablen und Ergebnis bleiben gleich; das Image wird von 130 MB Basis plus 3,5 MB Framework auf rund 23 MB kleiner.

Entwurf und Vorgehen stehen in `docs/superpowers/specs/2026-08-15-2051-caddy-umbau-design.md` und `docs/superpowers/plans/2026-08-15-2054-caddy-umbau.md`.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Die Seite laeuft auf `caddy:2-alpine`; `main/` mit Bootstrap und `index.php` sowie `docker/apache/000-default.conf` sind entfernt
- [x] #2 `APP_NAME` und `APP_TEXT_LEAD` wirken wie bisher, jede URL liefert weiterhin die Platzhalterseite mit Status 200
- [x] #3 `APP_ENV` entfaellt, `X-Robots-Tag: noindex, nofollow` wird immer gesetzt
- [x] #4 Das Aussehen kommt ohne CSS-Framework aus und folgt der Hell/Dunkel-Einstellung des Besuchers
- [x] #5 `scripts/smoke.sh <image>` prueft Seite, Catch-All, Robots-Header und Stylesheet und laeuft im Release-Workflow zwischen Build und Push
- [x] #6 `docker-compose.yml` kommt ohne `jwilder/nginx-proxy` aus und stellt den Dienst auf `127.0.0.1:8080` bereit
- [x] #7 Ein `Makefile` mit `help`, `build`, `up`, `down` und `test` bedient das Projekt
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Umgesetzt in sechs Schritten mit je eigener Prüfung und Review: Rauchtest zuerst (schlug gegen das alte Image fehl), dann Caddy-Laufzeit, Stylesheet, Entwicklungsumgebung, Pipeline, Abschluss.

Belege: `scripts/smoke.sh` läuft mit fünf Prüfungen grün gegen ein frisch gebautes Image; Image 350 MB -> 62,9 MB (lokal gemessen); im echten Browser gemessen: bei 945 px waagerecht und senkrecht mittig, `h1` 64 px, bei 360 px `h1` 40 px auf einer Zeile, kein waagerechter Überlauf, Schrift `system-ui`, `(prefers-color-scheme: dark)` vom Browser als gültige Regel geparst, Kontrast in beiden Modi über AA; tiefe URL `/tief/verschachtelt` antwortet mit 200 und dem Robots-Header; `yamllint` sauber; Build-Kontext durch `.dockerignore` von 8,5 MB auf 18 kB.

Über den Entwurf hinaus aus der Abschlussprüfung ergänzt: die verwaiste Datei `VERSION` entfernt, die README um die beiden Verhaltensänderungen (`APP_ENV` entfällt, Robots-Header immer an) und die neue Dokumentenwurzel `/app` ergänzt, `lang="en"` statt `lang="de"` (der ausgelieferte Standardtext ist englisch), `.dockerignore` und die `log`-Direktive für ein Zugriffslog.

Offen und dem Menschen vorgelegt: Auf Docker Hub zeigen die Tags `latest`, `1` und `1.0` weiterhin auf das PHP-Image von 2019. Die Beschränkung auf `X.Y.Z` ist gewollt, die alten Tags dort sind es nicht — das ist eine Aufräumarbeit auf Docker Hub, nicht im Repository.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Die Platzhalterseite läuft auf `caddy:2-alpine` statt auf PHP 7.3 mit Apache. `main/` mit Bootstrap und `index.php` sowie die Apache-Konfiguration sind entfernt; die Seite ist ein Caddy-Template unter `app/` mit 48 Zeilen eigenem CSS, das der Hell/Dunkel-Einstellung des Besuchers folgt. `APP_NAME` und `APP_TEXT_LEAD` wirken unverändert, jede URL liefert weiterhin die Seite mit 200, `X-Robots-Tag: noindex, nofollow` wird jetzt immer gesetzt und `APP_ENV` entfällt. Neu sind `scripts/smoke.sh`, das im Release-Workflow zwischen Build und Push läuft, ein `Makefile` mit vier Zielen und eine aufgeräumte `docker-compose.yml` auf `127.0.0.1:8080`. Das Image schrumpft von 350 MB auf 62,9 MB.
<!-- SECTION:FINAL_SUMMARY:END -->
