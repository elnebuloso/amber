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
```

Zwei Eigenschaften der Laufzeit, die dabei sichtbar wurden: Caddy vergibt Überschriften
automatisch IDs, Ankerlinks funktionieren also von selbst. Und Codeblöcke laufen durch Chroma,
das Syntaxklassen mitgibt.

## Aufbau

```
/app/index.html      Template               aus dem Image
/app/index.css       Vorgaben               aus dem Image
/app/content/        Dateien des Betreibers existiert im Image nicht
        index.md     optional
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

Ein eigenes Stylesheet des Betreibers wird nicht unterstützt. Der Gedanke war, eine `index.css`
neben der Markdown-Datei einzuhängen und nach den Vorgaben zu laden — das ist verworfen worden,
bevor es je ausgeliefert wurde: Ein zweites Stylesheet gewinnt auch gegen den Dunkelmodus-Block der
Vorgaben, wer also nur helle Farben setzt, serviert Dunkelmodus-Nutzern helle Flächen mit
hellgrauer Schrift. Wer das Aussehen wirklich bestimmen will, baut ein eigenes Image auf diesem
auf; die Vorgaben sind eine Datei.

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

Codeblöcke werden eingefärbt. Caddy schickt sie durch Chroma, das die Token-Klassen mitliefert;
vier Töne genügen — Kommentare gedämpft und kursiv, Zeichenketten warm, Schlüsselwörter kräftiger,
Zahlen und Konstanten im vierten Ton. Alles Übrige bleibt Fliesstextfarbe. Ein vollständiges
Editor-Thema mit sechzig Klassen wäre für eine Platzhalterseite Aufwand ohne Ertrag; vier Farben
je Schema sind es nicht. Die Töne stammen aus derselben Palette und sind in beiden Schemata gegen
die Codefläche gemessen — der niedrigste Wert liegt bei 4,76, alle übrigen darüber.

Die Grundmaße des Layouts ändern sich nicht: Gemessen mit einem Dokument von 2251 px Höhe im
917 px hohen Fenster steht die Überschrift 53 px unter der Oberkante und wird nicht abgeschnitten,
weil das Stylesheet `min-height` verwendet und nicht `height` — der Container wächst mit dem
Inhalt. Der Abstand unter der Überschrift wächst allerdings: `main > * + *` setzt zwischen allen
direkten Kindern von `main` 1,25rem Abstand, und das gilt auch für die alte Platzhalterseite mit
Überschrift und Fließtext. Gemessen wächst der Abstand zwischen Überschrift und Satz dadurch von
8 px auf 20 px. Kosmetisch, aber am Layout ändert sich damit doch etwas.

## Demo und Entwicklung

`demo/index.md` enthält absichtlich jedes Element, das GitHub-Markdown kennt. Damit ist die
Abdeckung des Stylesheets sichtbar geprüft statt geraten. Dazu gehört ein Codeblock mit genug
Syntax, dass sich die Färbung überhaupt beurteilen lässt.

Die `docker-compose.yml` zeigt alle drei Fälle nebeneinander:

```
amber            127.0.0.1:8080   nur Umgebungsvariablen
amber-markdown   127.0.0.1:8081   demo/index.md und demo/logo.svg einzeln als /app/content/*
```

Gemountet werden einzelne Dateien statt des Verzeichnisses. Das stammt aus der Zeit, als ein
zweiter Mount eine Datei darin überlagerte: Docker legt den Mountpunkt dafür im Host-Verzeichnis
an, also im Repository selbst. Der Fall ist mit dem eigenen Stylesheet entfallen, die Form bleibt —
sie ist ausdrücklich darüber, was im Container landet.

## Prüfung

`scripts/smoke.sh` bekommt die beiden neuen Fälle: Mit eingehängter Demo muss die Seite
gerendertes Markdown enthalten — eine Tabelle ist der eindeutigste Beleg, weil sie in Markdown
nicht wie HTML aussieht — und die Syntaxklassen von Chroma müssen auftauchen, sonst ist die
Färbung wirkungslos. Der bestehende Fall ohne Markdown bleibt, damit der Rückfall auf die
Umgebungsvariablen nicht unbemerkt kaputtgeht.

## Auslieferung

Ein `feat`-Commit, also 1.2.0. Die Änderung ist additiv: Wer die Umgebungsvariablen nutzt, bekommt
weiterhin dieselbe Seite, bis auf den unter „Aussehen" beschriebenen kosmetischen Abstand; die
neuen Pfade sind vorher unbenutzt gewesen.

Keine `CHANGELOG.md`. Die Release-Notes auf GitHub enthalten dasselbe, entstehen aus denselben
Commits und kosten keinen Bot-Commit auf `master`.
