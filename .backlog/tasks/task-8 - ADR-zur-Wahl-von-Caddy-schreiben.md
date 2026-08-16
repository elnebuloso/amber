---
id: TASK-8
title: ADR zur Wahl von Caddy schreiben
status: To Do
assignee: []
created_date: '2026-08-16 01:21'
labels: []
dependencies: []
priority: medium
type: docs
ordinal: 8000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Die Begründung, warum das Produkt auf Caddy läuft, steht bislang nur im Entwurf `docs/superpowers/specs/2026-08-15-2051-caddy-umbau-design.md` — also in einem Dokument, das eine abgeschlossene Aufgabe beschreibt und nicht als stehende Entscheidung gelesen wird. Die Frage „warum nicht nginx?" kommt erfahrungsgemäss wieder, und ohne festgehaltene Antwort wird sie jedes Mal neu verhandelt.

`docs/decisions/` gibt es noch nicht; dieser ADR legt das Verzeichnis an und bekommt die Nummer `0001`.

Seit der Umstellung ist die Entscheidung ausserdem **tragender geworden**, als sie beim Umbau war. Nicht nur der Dateiserver hängt daran, sondern:

- die Vorlagen-Engine (`templates`), aus der die ganze Zwei-Betriebsarten-Logik in `app/index.html` besteht — samt des Unterschieds, dass `include` eine Datei als Vorlage auswertet und `env` einen Wert nur einsetzt;
- `handle_errors`, das die Ersatzseite bei kaputtem `{{` ausliefert;
- `try_files`, wodurch jede URL mit der Seite antwortet;
- die Syntaxfärbung über Chroma, an der die Vier-Ton-Regel des Designsystems hängt.

Ein Wechsel des Servers würde all das mitreissen. Genau das gehört in die Konsequenzen des ADR — es ist das stärkste Argument dafür, die Entscheidung überhaupt aufzuschreiben.

Die Hausregeln für ADRs stehen in `.claude/rules/adrs.md` und sind streng: Nummern werden nie neu vergeben, jeder ADR beginnt mit einer Metadaten-Tabelle, der ADR trägt die Entscheidung und nicht die Bedienungsanleitung, die naheliegendste Einwand steht bei den verworfenen Alternativen zuerst — hier also nginx —, und geschrieben wird auf Deutsch.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 `docs/decisions/0001-<thema>.md` existiert und folgt den Vorgaben aus `.claude/rules/adrs.md`, einschliesslich Metadaten-Tabelle und deutscher Sprache
- [ ] #2 Der ADR nennt, was ohne Caddy neu gebaut werden müsste: Vorlagen-Engine, Fehlerbehandlung, `try_files`, Syntaxfärbung
- [ ] #3 nginx steht als erste verworfene Alternative mit einer Begründung, die aus der Sache kommt und nicht aus dem heutigen Installationsstand
- [ ] #4 Der ADR bleibt unter etwa 1500 Wörtern und enthält keine Aufgaben-Nummer und keinen Abschnitt darüber, was er nicht regelt
<!-- AC:END -->
