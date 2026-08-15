# Übergabe — Stand 15.08.2026

## Wo wir stehen

`amber` läuft nicht mehr auf PHP 7.3 mit Apache, sondern auf `caddy:2-alpine`, und die Seite kann
jetzt aus einer eingehängten Markdown-Datei entstehen. Beides ist fertig, geprüft und committet —
**aber nichts davon ist veröffentlicht.**

Zwei Releases sind heute schon rausgegangen: `1.1.0` (der Caddy-Umbau) und `1.1.1` (ein Fix an der
Release-Pipeline). Alles danach liegt lokal.

## Der letzte Stand

- **24 Commits lokal, nichts gepusht.** Arbeitsverzeichnis sauber, `make test` grün (13 Prüfungen),
  Design-Detektor ohne Befund.
- Alle vier Backlog-Aufgaben stehen auf Done: Pipeline auf Semantic Versioning, Caddy-Umbau,
  Markdown-Seite, Markdown-Abdeckung.
- Neu im Repository: `PRODUCT.md`, `DESIGN.md`, `.impeccable/`, `demo/`, `Makefile`,
  `scripts/smoke.sh`.

## Das Nächste: der Push ist ein Release

`git push` ist hier **keine harmlose Handlung**. Die Pipeline errechnet aus den Commits die nächste
Version, baut das Image, lässt den Rauchtest dagegen laufen, schiebt es nach Docker Hub und setzt
erst danach Tag und GitHub-Release. Unter den 24 Commits sind mehrere `feat`, also entsteht
**1.2.0**.

Der Ablauf, wenn es soweit ist:

```
git pull --rebase && git push
gh run watch          # oder: gh run list --limit 1
```

Danach prüfen: Release-Notizen auf GitHub gefüllt, Tag `v1.2.0` gesetzt, Image auf Docker Hub da.

## Offene Entscheidungen

Vier Dinge habe ich vorgelegt und nicht entschieden bekommen. Keines blockiert den Push.

1. **Commit-Betreff `fix(test): mount a temporary copy of demo content in the smoke test`.** Er
   erscheint in den Notizen zu 1.2.0 unter „Bug Fixes", obwohl er nur den Test betrifft, nicht das
   Produkt. Solange nichts gepusht ist, wäre ein Umschreiben zu `test:` möglich — Preis ist ein
   Rebase über 24 Commits. Meine Empfehlung war: stehenlassen, der Bereich `test` steht sichtbar
   davor.
2. **Der ältere Entwurf** `docs/superpowers/specs/2026-08-15-2051-caddy-umbau-design.md` nennt noch
   `app/style.css`, das inzwischen `app/index.css` heisst. Abgeschlossenes Dokument einer
   erledigten Aufgabe — nachziehen oder als Zeitdokument stehenlassen?
3. **Die Design-Hook-Ausnahme** (`side-tab` für `app/index.css`) liegt in `.impeccable/config.json`
   und gilt damit für alle im Repository. Auf Wunsch nach `.impeccable/config.local.json` als
   private Ausnahme verschiebbar.
4. **Impeccable 4.1.1** ist verfügbar, installiert ist 4.0.2. Du hattest „später" gesagt; der
   Befehl wäre `npx impeccable update` und wirkt erst in der nächsten Sitzung.

## Bananenschalen

- **Kein `latest` mehr auf Docker Hub.** `latest`, `1` und `1.0` sind gelöscht, weil sie auf das
  PHP-Image von 2020 zeigten. `docker pull elnebuloso/amber` **ohne Tag schlägt jetzt fehl** — das
  ist gewollt (nur volle Versionen sind deterministisch), überrascht aber jeden, der die kurze Form
  gewohnt war. Steht auch in der README.
- **Aufgabenlisten hängen an `:has()`.** Browser ohne Unterstützung zeigen Aufzählungspunkt *und*
  Checkbox. Kein Fehler, nur unschön, und ohne Alternativpfad.
- **`PRODUCT.md` und `DESIGN.md` binden künftige Arbeit** — Farben, Typo, die benannten Regeln, was
  bewusst dem Browser überlassen bleibt. Die README verweist nicht darauf; wer die Dateien nicht
  kennt, arbeitet an ihnen vorbei.
- **`1.2.0` steht als Beispielversion** in README und `demo/index.md`. Nach dem Release stimmt es,
  ab 1.3.0 ist es veraltet.
- **Das Markdown des Betreibers läuft durch die Template-Engine.** Ein `{{` im Inhalt wird
  ausgeführt, ein kaputtes beantwortet **jede** URL mit 500. Ausserdem wird alles im eingehängten
  Ordner ausgeliefert, nicht nur die Markdown-Datei. Beides steht in der README, ist aber die Art
  Falle, die man einmal selbst erlebt.
- **`make test` lässt `amber:dev` stehen.** Musste in dieser Sitzung mehrfach von Hand entfernt
  werden.

## Womit die Arbeit weitergehen könnte

Nichts davon ist beschlossen — es sind die Fäden, die offen liegen:

- Multi-Arch (`linux/arm64`). Der jetzige Ablauf mit `load: true` schliesst es aus: buildx kann ein
  Mehrplattform-Image nicht in den lokalen Daemon laden. Wer das will, muss den Rauchtest anders
  aufhängen — etwa gegen das gepushte Image per Digest.
- Ein ADR zur Wahl von Caddy. `docs/decisions/` existiert noch nicht; die Begründung steht bislang
  nur im Entwurf, und „warum nicht nginx?" kommt erfahrungsgemäss wieder.
- Zugriffslogs sind seit dem Umbau eingeschaltet (`log` in der Caddyfile), aber nie im Betrieb
  angesehen worden.
