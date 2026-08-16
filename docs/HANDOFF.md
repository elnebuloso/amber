# Übergabe — Stand 16.08.2026

## Wo wir stehen

**`1.2.0` ist veröffentlicht.** Der Release-Workflow lief in 52 Sekunden durch, Tag `v1.2.0` steht,
die Release-Notizen sind gefüllt, das Image liegt auf Docker Hub. Nachgeprüft, nicht nur gemeldet:
frisch gezogen und gestartet, die Seite rendert, der Robots-Header sitzt, `latest` existiert
weiterhin nicht.

Arbeitsverzeichnis sauber, nichts ungepusht. Zwei Container aus `make up` laufen noch auf 8080 und
8081 — `make down` beendet sie.

## Was in dieser Sitzung passiert ist

Kurz, weil es an anderer Stelle vollständig steht: die Seite läuft jetzt auf einem gelieferten
Design-System, `APP_TEXT_LEAD` wird als Markdown gerendert, `APP_LANG` ist konfigurierbar,
`APP_NAME` wird escaped, und ein kaputtes `{{` liefert die Variablen-Seite statt eines leeren 500.
Dazu drei Kritik-Runden mit ihren Korrekturen.

Die Belege liegen dort, wo sie hingehören und nicht hier:

- `DESIGN.md` — die gebaute Welt, vierzehn benannte Regeln mit Begründung, die verworfenen
  Alternativen mit ihrem Preis, die bekannten Grenzen. In dieser Sitzung von ~4900 auf ~3500 Wörter
  verdichtet, nach einem Test: *könnte das Stylesheet diesen Satz auch sagen?*
- `PRODUCT.md` — Produktwahrheit, einschliesslich der scharfen Kanten.
- `.impeccable/critique/` — drei Kritik-Schnappschüsse, der jüngste ist der aktuelle.
- Backlog `TASK-1` bis `TASK-6` — erledigt, mit Umsetzungsnotizen.

## Was als Nächstes ansteht

Im Backlog, alle auf To Do:

- **`TASK-7`** — Image zusätzlich für `linux/arm64`. Der Knackpunkt steht in der Aufgabe: der
  Workflow testet heute genau das Artefakt, das er veröffentlicht, und das darf ein Umbau nicht
  verlieren.
- **`TASK-8`** — ADR zur Wahl von Caddy. `docs/decisions/` gibt es noch nicht, der ADR bekommt
  `0001`.
- **`TASK-9`** — Zugriffslogs ansehen und **entscheiden**. Fertig ist die Aufgabe erst mit einer
  Entscheidung in `PRODUCT.md`, nicht mit einem Blick in den Log.

## Offene Entscheidungen

**1. Spaltenbreite auf 36rem?** Zweimal vorgelegt, nie entschieden. Gemessen am ersten Absatz von
`demo/index.md` bei 1280px Fensterbreite:

| Maß | Breite | Zeichen |
| --- | --- | --- |
| 34rem (jetzt) | 544px | 75 |
| 36rem | 576px | 75 |
| 38rem | 608px | 82 |

36rem kostet nichts — gleiche Zeilenlänge, 32px mehr Breite. Eine Zeile in `app/tokens.css`.

**2. Regressionsfall in `demo/index.md`?** Die dortige Tabelle füllt die Spalte zufällig genau aus
und hat den Rasterdefekt drei Kritiken lang maskiert. Eine zweite, absichtlich schmale Tabelle
würde das dauerhaft verhindern. Die Datei existiert genau dafür, dass sich die Gestaltung an ihr
beurteilen lässt statt behaupten.

## Bananenschalen

- **Die Detektor-Unterdrückung ist pfadrelativ.** `detect.mjs --json app` ist sauber,
  `detect.mjs --json /workspace/.../app` meldet einen `design-system-color`-Befund auf
  `app/index.html`. Der absolute Pfad umgeht die Ausnahme in `.impeccable/config.json` still. Der
  Befund ist ein Artefakt davon, dass der Detektor die Caddy-Vorlage ohne Stylesheet liest — die
  ausgelieferte Seite misst dort 17,66:1. **Immer den relativen Pfad benutzen.**

- **Die 75 Zeichen sind an einem einzigen Absatz gemessen.** `DESIGN.md` führt „82 bei 40rem, 75 bei
  34rem, 63 bei 30rem" als Zahlen des Systems; sie stammen aus dem ersten Absatz von
  `demo/index.md`. Ein anderer Text bricht anders um. Wer die Zahl als Eigenschaft der Gestaltung
  liest statt als Messung an einem Text, zieht falsche Schlüsse.

- **Die vier Parser-Module des Detektors liegen im Plugin-Cache**, nicht im Projekt:
  `htmlparser2`, `css-select`, `css-tree`, `domutils` unter
  `/root/.claude/plugins/cache/impeccable/impeccable/4.1.1/node_modules`. Ohne sie läuft der
  Detektor **eingeschränkt** und prüft weder Custom Properties noch berechneten Kontrast — er sagt
  das zwar in einem Banner, aber die Befundliste sieht trotzdem plausibel aus. Beim nächsten
  Plugin-Update sind sie weg und müssen neu installiert werden.

- **`APP_TEXT_LEAD` führt rohes HTML aus, `APP_NAME` nicht.** Gleiche Vertrauensstufe,
  unterschiedlich behandelt — und das ist Absicht: bei `APP_TEXT_LEAD` ist Markdown die Zusage, und
  `demo/index.md` beruht selbst darauf (`<details>`, `<figure>`). Wer das für einen Fehler hält und
  „repariert", bricht die Demo-Seite.

- **`th:last-child { width: 100% }` gibt allen Rest an die letzte Spalte.** Eine Tabelle, die auf
  einen kurzen Wert endet, bekommt dort eine breite, fast leere Spalte. Das ist der bekannte Preis
  dafür, dass das Raster die Spalte füllt; die Alternative `table-layout: fixed` kostet die
  inhaltsgesteuerten Spaltenbreiten und wurde deshalb verworfen. Steht auch in `DESIGN.md`.

- **`make test` lässt `amber:dev` stehen.** Unverändert seit gestern.

## Start-Prompt für morgen

> Moin. `1.2.0` ist draußen, Arbeitsverzeichnis sauber. Im Backlog stehen `TASK-7` (arm64),
> `TASK-8` (ADR zu Caddy) und `TASK-9` (Zugriffslogs). Dazu zwei kleine offene Entscheidungen aus
> der Übergabe: Spaltenbreite auf 36rem, und ein schmaler Tabellen-Regressionsfall in
> `demo/index.md`. Lies `docs/HANDOFF.md` und schlag vor, womit wir anfangen.
