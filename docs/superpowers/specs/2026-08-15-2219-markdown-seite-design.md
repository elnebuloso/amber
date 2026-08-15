# Markdown-Seite statt zweier Umgebungsvariablen

## Ausgangslage

`amber` zeigt heute eine Überschrift und einen Satz, beides aus `APP_NAME` und `APP_TEXT_LEAD`.
Für einen Platzhalter reicht das, solange nichts zu sagen ist. Sobald jemand mehr unterbringen
will — was hier entsteht, wann es soweit ist, wie man Kontakt aufnimmt — endet das Format.

Die Laufzeit kann bereits mehr, als sie derzeit nutzt: Caddys `templates` beherrscht `markdown`,
`include` und `fileExists`. Genau deshalb war die Wahl auf Caddy gefallen.

## Entscheidung

Liegt eine Markdown-Datei vor, wird die Seite daraus gerendert. Liegt keine vor, gilt unverändert,
was heute gilt. Gegen `caddy:2-alpine` geprüft, alle drei Fälle gemessen:

```
ohne content/   -> <h1>amber</h1><p>lead text</p>
mit index.md    -> h1, p, ul, table, blockquote, pre — vollständiges GitHub-Markdown
mit index.css   -> beide Stylesheets verlinkt, /content/index.css als text/css ausgeliefert
```

Zwei Eigenschaften der Laufzeit, die dabei sichtbar wurden: Caddy vergibt Überschriften
automatisch IDs, Ankerlinks funktionieren also von selbst. Und Codeblöcke laufen durch Chroma,
das Syntaxklassen mitgibt.

## Aufbau

```
/app/index.html      Template               aus dem Image
/app/style.css       Vorgaben               aus dem Image
/app/content/        Dateien des Betreibers leer im Image
        index.md     optional
        index.css    optional
```

Die Dateien des Betreibers liegen in einem eigenen Ordner, nicht direkt in `/app`. Wer ein
Verzeichnis einhängt, verdeckt alles, was im Image darunter liegt; lägen die eigenen Dateien in
`/app`, nähme der Mount Template und Stylesheet mit und der Container wäre leer. Mit dem
Unterordner kann das nicht passieren, und ein Aufruf hängt schlicht sein Verzeichnis dorthin.

## Verhalten

Die Regel im Template:

```
{{if fileExists "/content/index.md"}}
    {{markdown (include "/content/index.md")}}
{{else}}
    <h1>{{env "APP_NAME"}}</h1>
    <p>{{env "APP_TEXT_LEAD"}}</p>
{{end}}
```

`/content/index.css` wird als zweites Stylesheet verlinkt, wenn es existiert — nach `style.css`,
damit es die Vorgaben ergänzt statt sie zu ersetzen. Wer nur die Farben ändern will, schreibt drei
Zeilen; wer alles selbst bestimmen will, überschreibt so viel er mag.

`APP_NAME` bleibt in beiden Fällen der Titel im Browser-Tab: eine Regel, kein Sonderfall.
`APP_TEXT_LEAD` wird bei vorhandener `index.md` nicht mehr angezeigt.

## Aussehen

Das Stylesheet wächst von 48 auf rund 120 Zeilen und bleibt eigenes, framework-freies CSS mit
denselben drei Farbvariablen. Ein fertiges Stylesheet wurde erwogen und verworfen: Es brächte eine
zweite Handschrift neben die abgestimmte Platzhalter-Optik, und wieder eine Fremddatei, die
niemand aktualisiert.

Neu abgedeckt wird, was Markdown erzeugt: Überschriften bis `h6` mit abgestufter Größe, Listen
auch verschachtelt, Tabellen mit Trennlinien, `pre` und `code` mit gedämpftem Hintergrund, Zitate,
Bilder auf Spaltenbreite begrenzt, Trennlinien. Tabellen und Codeblöcke scrollen bei Überbreite in
sich selbst, statt die Seite waagerecht zu sprengen.

Codefärbung bleibt aus. Chroma liefert die Klassen mit, aber ein Farbschema sind zwanzig Regeln,
die in hell und dunkel funktionieren müssen — Aufwand ohne Ertrag für eine Platzhalterseite. Code
bleibt lesbar, nur einfarbig.

Am Layout ändert sich nichts. Gemessen mit einem Dokument von 2251 px Höhe im 917 px hohen
Fenster: Die Überschrift steht 53 px unter der Oberkante und wird nicht abgeschnitten, weil das
Stylesheet `min-height` verwendet und nicht `height` — der Container wächst mit dem Inhalt.

## Demo und Entwicklung

`demo/index.md` enthält absichtlich jedes Element, das GitHub-Markdown kennt. Damit ist die
Abdeckung des Stylesheets sichtbar geprüft statt geraten. `demo/custom.css` ändert erkennbar
etwas, damit der Override auf einen Blick zu sehen ist.

Die `docker-compose.yml` zeigt alle drei Fälle nebeneinander:

```
amber            127.0.0.1:8080   nur Umgebungsvariablen
amber-markdown   127.0.0.1:8081   ./demo als /app/content
amber-custom     127.0.0.1:8082   ./demo als /app/content, dazu ./demo/custom.css als /app/content/index.css
```

Der dritte Dienst legt nur eine Datei zusätzlich über denselben Ordner. Die Demo-Inhalte gibt es
damit genau einmal im Repository, und der Unterschied zwischen 8081 und 8082 ist exakt das
Stylesheet.

## Prüfung

`scripts/smoke.sh` bekommt die beiden neuen Fälle: Mit eingehängter Demo muss die Seite
gerendertes Markdown enthalten — eine Tabelle ist der eindeutigste Beleg, weil sie in Markdown
nicht wie HTML aussieht. Mit zusätzlicher `index.css` müssen beide Stylesheets verlinkt und beide
abrufbar sein. Der bestehende Fall ohne Markdown bleibt, damit der Rückfall auf die
Umgebungsvariablen nicht unbemerkt kaputtgeht.

## Auslieferung

Ein `feat`-Commit, also 1.2.0. Die Änderung ist additiv: Wer die Umgebungsvariablen nutzt, merkt
nichts, das Layout bleibt, und die neuen Pfade sind vorher unbenutzt gewesen.

Keine `CHANGELOG.md`. Die Release-Notes auf GitHub enthalten dasselbe, entstehen aus denselben
Commits und kosten keinen Bot-Commit auf `master`.
