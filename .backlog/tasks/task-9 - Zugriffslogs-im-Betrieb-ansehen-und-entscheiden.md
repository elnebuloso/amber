---
id: TASK-9
title: Zugriffslogs im Betrieb ansehen und entscheiden
status: To Do
assignee: []
created_date: '2026-08-16 01:22'
labels: []
dependencies: []
priority: low
type: enhancement
ordinal: 9000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Die Caddyfile enthält seit dem Umbau die Direktive `log`, ohne weitere Angaben. Was dabei tatsächlich entsteht, hat noch nie jemand im Betrieb angesehen — weder Format noch Menge noch Nutzen.

Drei Dinge sind zu klären, und das dritte ist das eigentliche:

**Was steht drin und wo landet es.** Ohne Konfiguration schreibt Caddy den Zugriffslog nach `stderr`, als JSON, eine Zeile pro Anfrage. In einer Container-Umgebung sammelt das der Docker-Log-Treiber ein.

**Wie viel wird es.** Die Seite antwortet auf **jede** URL mit 200 — das ist eine bewusste Fähigkeit, sorgt aber dafür, dass Suchmaschinen-Crawler und Schwachstellen-Scanner nicht auf 404 auflaufen, sondern jede Anfrage als Treffer gezählt bekommen. Auf einer geparkten Domain ist der Log damit vermutlich zu einem grossen Teil Fremdverkehr. Ob das relevante Datenmengen erzeugt, ist ungemessen.

**Ob er überhaupt hierher gehört.** `PRODUCT.md` sagt: „No tracking, no analytics, no cookies — not even optionally." Ein Zugriffslog ist kein Tracking im üblichen Sinn, aber er hält die IP-Adresse jedes Besuchers fest. Ein Produkt, das zusichert, nichts zu sammeln, sollte das entschieden haben statt geerbt. Mögliche Ausgänge: so lassen und in `PRODUCT.md` benennen; auf Fehler beschränken; die IP-Adresse weglassen; oder ganz abschalten. Diese Aufgabe ist erst fertig, wenn eine davon **entschieden** ist — nicht, wenn der Log nur einmal angeschaut wurde.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Es ist an einem laufenden Container belegt, was `log` erzeugt: Ziel, Format und ein Beispieleintrag
- [ ] #2 Die Menge ist an einem realistischen Zeitraum abgeschätzt oder gemessen, einschliesslich des Anteils, den Crawler und Scanner erzeugen
- [ ] #3 Es ist entschieden, ob der Zugriffslog bleibt, eingeschränkt wird oder verschwindet — und die Entscheidung steht mit ihrer Begründung in `PRODUCT.md`, weil sie eine Zusage des Produkts berührt
- [ ] #4 Bleibt er, nennt die `README.md` ihn, damit ein Betreiber weiss, dass sein Container Besucher-IPs in den Docker-Log schreibt
<!-- AC:END -->
