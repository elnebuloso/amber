---
id: TASK-7
title: Image zusätzlich für linux/arm64 bauen
status: To Do
assignee: []
created_date: '2026-08-16 01:21'
labels: []
dependencies: []
priority: medium
type: enhancement
ordinal: 7000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Das Image erscheint heute nur für `linux/amd64`. Wer es auf einem Raspberry Pi, einem Apple-Silicon-Rechner oder einem ARM-Server einsetzen will, kann es nicht ziehen.

Der jetzige Ablauf in `.github/workflows/release.yml` schliesst Mehrplattform-Bauten aus, und zwar an einer bestimmten Stelle: der Build-Schritt nutzt `load: true`, damit das Image im lokalen Daemon des Runners landet, danach läuft `./scripts/smoke.sh` dagegen, und erst dann kommt `docker push`. `buildx` kann ein Mehrplattform-Image aber nicht in den lokalen Daemon laden — es entsteht ein Manifest mit mehreren Abbildern, und dafür gibt es kein `docker load`.

**Was dabei nicht verloren gehen darf:** heute wird genau das Artefakt getestet, das anschliessend veröffentlicht wird. Das ist die eigentliche Zusicherung der Pipeline. Ein Umbau, der eine Architektur testet und zwei veröffentlicht, ist schwächer als der jetzige Zustand — auch wenn er mehr Plattformen abdeckt.

Zu klären ist ausserdem, **wie** eine `arm64`-Variante überhaupt geprüft werden soll. Die Runner von GitHub sind `amd64`; ein `arm64`-Image dort auszuführen braucht Emulation über `docker/setup-qemu-action` (langsam) oder einen `arm64`-Runner. Ob der Rauchtest auf beiden Architekturen laufen muss oder ob eine geprüft und die andere nur gebaut wird, ist die Kernentscheidung dieser Aufgabe.

Ein möglicher Weg, den die frühere Notiz nennt: gegen das bereits gepushte Image per Digest testen — also erst veröffentlichen, dann prüfen. Das dreht die Reihenfolge um und muss beantworten, was passiert, wenn der Test danach fehlschlägt.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Das veröffentlichte Image trägt ein Manifest mit `linux/amd64` und `linux/arm64`; ein Zug auf beiden Architekturen liefert ein lauffähiges Image
- [ ] #2 Der Rauchtest deckt weiterhin das Artefakt ab, das veröffentlicht wird — welche Architekturen er dabei tatsächlich ausführt, ist bewusst entschieden und in der Aufgabe festgehalten
- [ ] #3 Schlägt der Rauchtest fehl, ist dokumentiert und umgesetzt, was mit einem bereits veröffentlichten Tag geschieht — sofern die Reihenfolge Bauen/Testen/Veröffentlichen geändert wurde
- [ ] #4 Die Laufzeit des Release-Workflows ist gemessen vorher und nachher festgehalten; eine Emulation über QEMU ist als Kostenpunkt benannt
- [ ] #5 `README.md` nennt die unterstützten Architekturen
<!-- AC:END -->
