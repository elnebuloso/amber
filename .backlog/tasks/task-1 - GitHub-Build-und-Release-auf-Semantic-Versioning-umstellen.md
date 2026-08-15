---
id: TASK-1
title: GitHub Build und Release auf Semantic Versioning umstellen
status: Done
assignee:
  - '@claude'
created_date: '2026-08-15 17:53'
updated_date: '2026-08-15 18:25'
labels: []
dependencies: []
priority: high
type: enhancement
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Der Release-Workflow in `.github/workflows/release.yml` baut und pusht bei **jedem** Push auf `master` ein Image nach Docker Hub und zieht die Version aus der Datei `VERSION`. Das soll auf automatisches Semantic Versioning aus den Commit-Messages umgestellt werden.

Zielbild: Bei einem Push auf `master` werten wir die Conventional Commits seit dem letzten Git-Tag aus und leiten daraus die nächste Version ab. Nur wenn dabei tatsächlich eine neue Version herauskommt, wird gebaut, getaggt und nach Docker Hub gepusht — reine `chore`/`docs`/`ci`-Commits erzeugen kein Release.

Werkzeug: eine leichtgewichtige GitHub Action, die die nächste Version berechnet und das Git-Tag setzt (Kandidat: `mathieudutour/github-tag-action`), kombiniert mit `docker/metadata-action` für die Docker-Tags. Bewusst **nicht** `release-please` oder `semantic-release`: beide bringen Release-PR-Zeremonie bzw. eine Node-Toolchain und eine `CHANGELOG.md` in ein Repository zurück, das nur ein `Dockerfile` enthält und die `CHANGELOG.md` gerade erst losgeworden ist.

Docker Hub bekommt bewusst nur den vollen Tag `X.Y.Z` und keine mitwandernden Kurzformen: nur die volle Version ist deterministisch — ein Deployment, das `X.Y`, `X` oder `latest` zieht, bekommt bei gleichem Manifest über die Zeit unterschiedliche Images.

Das Handling der Datei `VERSION` muss nicht erhalten bleiben — die Datei verschwindet in einem Folge-Task ohnehin.

Nebenbefunde im bestehenden Workflow, die mit erledigt werden sollten: `::set-env` wurde von GitHub abgeschaltet und funktioniert nicht mehr, `actions/checkout@master` ist ungepinnt, und für die Tag-Historie braucht der Checkout `fetch-depth: 0`.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Build und Release laufen ausschliesslich bei Push auf `master`; Pull Requests und andere Branches lösen keinen Push nach Docker Hub aus
- [x] #2 Die nächste Version wird aus den Conventional Commits seit dem letzten Git-Tag berechnet: `feat` -> Minor, `fix` und `perf` -> Patch, `!` bzw. `BREAKING CHANGE` -> Major
- [x] #3 Enthält ein Push nur Commits ohne releasewürdigen Typ (z. B. `chore`, `docs`, `ci`, `test`, `refactor`, `style`), wird weder gebaut noch nach Docker Hub gepusht
- [x] #4 Bei einem Release wird ein Git-Tag `vX.Y.Z` im Repository gesetzt
- [x] #5 Der Workflow liest die Datei `VERSION` nicht mehr
- [x] #6 Das abgeschaltete `::set-env` kommt im Workflow nicht mehr vor und `actions/checkout` ist auf eine Major-Version gepinnt mit `fetch-depth: 0`
- [x] #7 Docker Hub erhält ausschliesslich den Tag `X.Y.Z` — keine `X.Y`-, `X`- oder `latest`-Tags
- [x] #8 Das Git-Tag und das GitHub-Release entstehen erst nach dem erfolgreichen Push des Images; ein fehlgeschlagener Build hinterlaesst kein Tag
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Werkzeugwechsel gegenueber der urspruenglichen Task-Beschreibung: `semantic-release` ueber `cycjimmy/semantic-release-action@v6` statt `mathieudutour/github-tag-action`. Grund siehe Implementation Notes — die Tag-Action ist seit zwei Jahren unveraendert und erkennt `!` nicht.
2. `.releaserc.json` anlegen: Branch `master`, Plugins `commit-analyzer` und `release-notes-generator` je mit `preset: conventionalcommits` (damit `!` als Breaking Change zaehlt) sowie `@semantic-release/github` fuer das GitHub-Release. Das npm-Plugin wird durch die explizite Plugin-Liste abgewaehlt.
3. `.github/workflows/release.yml` neu schreiben: Trigger nur `push` auf `master`, `permissions: contents: write` plus `issues`/`pull-requests: write` fuer das GitHub-Release, Checkout `actions/checkout@v7` mit `fetch-depth: 0`. `::set-env` und das Lesen von `VERSION` entfallen ersatzlos.
4. `cycjimmy/semantic-release-action@v6` mit `extra_plugins: conventional-changelog-conventionalcommits` ausfuehren; sie setzt Git-Tag `vX.Y.Z` und GitHub-Release selbst.
5. Build und Push nur wenn `outputs.new_release_published == true`: `docker/setup-buildx-action`, `docker/login-action@v4`, `docker/build-push-action@v7` mit dem einzigen Tag `elnebuloso/amber:${{ steps.semantic.outputs.new_release_version }}`.
6. Bewusst in Kauf genommen: semantic-release taggt vor dem Docker-Push. Schlaegt der Build fehl, existiert ein Tag ohne Image; die Reparatur ist ein Folge-Release. Die Alternative waere ein doppelter Lauf der Action mit `dry_run`, was den Workflow ohne echten Gewinn verdoppelt.
7. Verifikation: `yamllint` auf den Workflow, `semantic-release --dry-run` lokal gegen die echte Commit-Historie.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Verifikation der Bump-Logik mit `@semantic-release/commit-analyzer` (dem Paket, das `mathieudutour/github-tag-action` intern aufruft) gegen Beispiel-Commits: `feat` -> minor, `fix`/`perf` -> patch, `BREAKING CHANGE:` im Footer -> major, `chore`/`docs`/`ci`/`test`/`refactor`/`style` -> kein Release, gemischter Push -> hoechster Bump. Alles wie erwartet.

Abweichung: `feat!: ...` loest **kein** Release aus. Die Action ruft `analyzeCommits` ohne `preset` auf und laesst damit den Angular-Parser laufen, dessen Header-Muster das `!` nicht kennt — der Commit wird als typlos verworfen. Nachgetestet: weder `custom_release_rules` mit `type: feat!` noch mit `breaking: true` aendern daran etwas, weil bereits das Parsen des Headers fehlschlaegt. Nur der Footer `BREAKING CHANGE:` erzeugt einen Major-Bump. Damit ist Kriterium 2 in der Form `!` -> Major mit dieser Action nicht erfuellbar.

Werkzeugwechsel nach Evaluation: `semantic-release` via `cycjimmy/semantic-release-action@v6` statt `mathieudutour/github-tag-action`. Ausschlaggebend: die Tag-Action hat seit Maerz 2024 kein Release und seit August 2024 keinen Commit, und ihr `!`-Problem ist nicht konfigurierbar. `release-please` wurde verworfen, weil sein Release-PR nicht abschaltbar ist und die Strategie `simple` mit `version.txt` das gerade abgeschaffte Versionsdatei-Handling zurueckbraechte. Der `!`-Fehler liegt am Parser-Preset, nicht am Werkzeug: derselbe Analyzer liefert fuer `feat!: x` mit `angular` kein Release und mit `conventionalcommits` einen Major-Bump — bei semantic-release ist das ein Schalter in `.releaserc.json`.

Verifikation:
- `semantic-release --dry-run` gegen die echte Historie: Config geladen, Tag `v1.0.0` erkannt, 0 relevante Commits, kein Release.
- Bump-Matrix end-to-end mit der echten `.releaserc.json` in einem Wegwerf-Klon (`chore`+`docs` -> kein Release, `fix` -> 1.0.1, `feat` -> 1.1.0, `feat!` -> 2.0.0, `feat(base)!` -> 2.0.0, gemischt -> 1.1.0): alle sechs Faelle bestanden.
- Echter Lauf gegen ein lokales Remote: `feat` erzeugte Tag `v1.1.0`, per `git ls-remote` im Remote nachgewiesen.
- `yamllint` auf dem Workflow ohne Befund, `.releaserc.json` als JSON valide.
- `docker build --pull` lokal erfolgreich, damit der erste Release nicht an einem veralteten Basis-Image scheitert.

Nur statisch belegt sind der Trigger auf `master` (Workflow-Trigger und `branches` in der Config) und die Beschraenkung auf den Docker-Tag `X.Y.Z` — beides sind Konfigurationsaussagen, deren Laufzeitbeweis erst der erste echte Workflow-Lauf auf GitHub liefert.

Bewusst in Kauf genommen: semantic-release setzt Tag und GitHub-Release vor dem Docker-Push. Schlaegt der Build fehl, existiert ein Release ohne Image; die Reparatur ist ein Folge-Release.

Nachbesserung der Reihenfolge: Tag und GitHub-Release entstehen jetzt **nach** dem Docker-Push. Der Workflow ruft `cycjimmy/semantic-release-action` zweimal auf — zuerst mit `dry_run: true`, das nur die Version liefert, am Ende ohne, was taggt und released. Ausschlaggebend war, dass der Fehlerfall der alten Reihenfolge nicht selbstheilend ist: existiert das Tag bereits, meldet ein erneuter Lauf "no release", `new_release_published` wird `false` und genau die Docker-Schritte werden uebersprungen, die das fehlende Image nachliefern muessten. In der neuen Reihenfolge dreht sich der Fehlerfall zu "Image gepusht, Tag fehlt", und der heilt beim naechsten Lauf von selbst. Zusaetzlich `concurrency: release`, damit zwei schnell aufeinanderfolgende Pushes nicht parallel je ein Release erzeugen.

Verifikation der neuen Reihenfolge in einem Wegwerf-Klon mit lokalem Remote, alle vier Faelle bestanden: Trockenlauf bestimmt `1.1.0`; ein zweiter Trockenlauf liefert erneut `1.1.0` und belegt damit die Heilung nach einem fehlgeschlagenen Tag-Schritt; der echte Lauf legt `refs/tags/v1.1.0` im Remote an; ein Trockenlauf danach meldet "no release", es entsteht also kein Doppel-Release. `yamllint` ohne Befund.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Der Release-Workflow laeuft jetzt ueber `semantic-release` (`cycjimmy/semantic-release-action@v6`) statt ueber die Datei `VERSION`: bei einem Push auf `master` bestimmt ein Trockenlauf die naechste Version aus den Conventional Commits, dann werden Image und Docker-Tag `X.Y.Z` gebaut und gepusht, und erst danach setzt ein zweiter Lauf Git-Tag `vX.Y.Z` und GitHub-Release. Damit hinterlaesst ein fehlgeschlagener Build kein Tag ohne Image. Neu ist `.releaserc.json` mit dem Preset `conventionalcommits`, damit `!` als Breaking Change zaehlt; `concurrency: release` verhindert parallele Laeufe. Der alte Workflow mit `::set-env`, ungepinntem `actions/checkout@master` und den mitwandernden Tags `X.Y`, `X` und `latest` ist ersetzt. Verifiziert mit einer Bump-Matrix aus sechs Faellen gegen die echte Config, vier Faellen zur Reihenfolge und Wiederholbarkeit gegen ein lokales Remote, einem Trockenlauf gegen die Repo-Historie sowie `yamllint` und einem lokalen `docker build`.
<!-- SECTION:FINAL_SUMMARY:END -->
