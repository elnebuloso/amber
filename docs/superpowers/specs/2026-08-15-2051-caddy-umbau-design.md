# Umbau von PHP/Apache auf Caddy

## Ausgangslage

`amber` liefert eine Platzhalterseite aus: eine Überschrift, ein Satz darunter, beides aus den
Umgebungsvariablen `APP_NAME` und `APP_TEXT_LEAD`. Jede URL zeigt dieselbe Seite, damit eine
Domain vollständig abgedeckt ist, solange die echte Seite noch nicht existiert.

Getragen wird das heute von einem Apparat, der in keinem Verhältnis dazu steht:

- Basis-Image `elnebuloso/php:7.3-apache-ubuntu`, 130 MB komprimiert, zuletzt am 27.08.2019
  aktualisiert. PHP 7.3 erhält seit Dezember 2021 keine Sicherheitsupdates mehr.
- Bootstrap 4.3.1 vollständig im Image, 3,5 MB, benutzt werden acht Klassen.
- PHP läuft ausschliesslich für drei `getenv()`-Aufrufe in `main/public/index.php`.
- Eine Apache-Konfiguration, deren wirksamer Teil eine Rewrite-Regel auf `index.php` ist.

## Entscheidung

Die Laufzeit wird `caddy:2-alpine`, 23 MB komprimiert. Die Seite wird ein Caddy-Template, das
Framework entfällt ersatzlos.

Ausschlaggebend war die Anforderung an eine spätere Version: aus einer `index.md` soll eine
gerenderte Seite werden, ein eigenes `index.css` soll das Aussehen anpassen können, und ohne
Markdown-Datei gelten weiter die Umgebungsvariablen. Caddy bringt dafür alles mit. Gegen
`caddy:2-alpine` geprüft:

```
{{env "APP_NAME"}}                  -> amber
{{fileExists "/index.md"}}          -> true bzw. false, je nach Vorhandensein
{{markdown (include "/index.md")}}  -> <h1 id="hello">Hello</h1> …
```

Das Löschen der Datei im laufenden Betrieb wirkte sofort, ohne Neustart des Containers.

`nginx:alpine` liegt mit 25 MB gleichauf, bräuchte für dieselbe Fähigkeit aber einen
Markdown-Renderer im Image und ein Startskript mit der Verzweigung, die bei Caddy eingebaut ist.
Ein eigenes Go-Binary in `FROM scratch` käme auf 6 bis 8 MB, verlangt dafür aber einen selbst
gepflegten Webserver samt Markdown-Bibliothek und Routing — Ersparnis an einer Stelle, die nicht
wehtut, gegen Wartung an einer, die es tut.

## Aufbau

```
app/index.html          Template mit den Platzhaltern
app/style.css           die mitgelieferten Vorgaben
docker/caddy/Caddyfile  Serverkonfiguration
Dockerfile              vier Zeilen auf caddy:2-alpine
scripts/smoke.sh        Rauchtest gegen einen laufenden Container
Makefile                up, down, build, test
```

Es entfallen `main/` mit Bootstrap und `index.php` sowie `docker/apache/000-default.conf`. Das
`COPY VERSION /VERSION` im `Dockerfile` fällt mit weg; die Datei verschwindet ohnehin.

Die `Caddyfile`, so gegen `caddy:2-alpine` verifiziert:

```
:80 {
	root * /app
	header X-Robots-Tag "noindex, nofollow"
	templates
	file_server
	try_files {path} /index.html
}
```

Die Wurzel liegt auf `/app`, weil `fileExists` und `include` nur innerhalb der Site-Wurzel lesen.
Die in der nächsten Version erwarteten `/app/index.md` und `/app/index.css` liegen damit von
selbst richtig, ohne späteren Umbau.

## Verhalten

`APP_NAME` und `APP_TEXT_LEAD` bleiben wie sie sind, samt der Vorgabewerte im `Dockerfile`. Jede
URL liefert weiterhin dieselbe Seite mit Status 200.

`APP_ENV` entfällt. Die Variable steuerte in Apache die PHP-Fehlerausgabe, die mit PHP verschwindet,
und den Header `X-Robots-Tag`, der bisher nur ausserhalb von `production` gesetzt wurde. Künftig
setzt der Container ihn immer: Eine Platzhalterseite gehört nicht in den Suchindex, sonst steht sie
als Ergebnis für die Domain, während die echte Seite entsteht, und bleibt dort noch eine Weile,
nachdem sie live ist.

## Aussehen

Rund 30 Zeilen CSS ohne Framework, zurückhaltend modernisiert gegenüber dem heutigen
Bootstrap-Jumbotron:

- Systemschriften, also nichts nachzuladen und kein Flackern beim Aufbau
- der Inhalt vertikal zentriert und auf etwa 40 Zeichen Zeilenbreite begrenzt
- die Überschrift skaliert über `clamp` mit der Fensterbreite statt umzubrechen
- gedämpfte Farben, und die Seite folgt über `prefers-color-scheme` der Einstellung des Besuchers

Diese Datei ist zugleich die Vorgabe, die eine eigene `index.css` später überschreibt.

## Entwicklung

Die `docker-compose.yml` verliert `jwilder/nginx-proxy` und den obsoleten Schlüssel `version`.
Übrig bleibt ein Dienst `amber`, gebunden an `127.0.0.1:8080`, mit `./app` als Mount — Änderungen
an Template und Stylesheet wirken damit sofort, ohne Neubau.

## Prüfung

`scripts/smoke.sh` nimmt einen Image-Namen entgegen, startet einen Container und prüft vier Dinge:

1. `/` antwortet mit 200 und enthält den Wert aus `APP_NAME`
2. eine beliebige tiefe URL liefert dieselbe Seite mit 200
3. `X-Robots-Tag` ist gesetzt
4. `/style.css` kommt mit `Content-Type: text/css`

Der Release-Workflow baut das Image deshalb mit `load: true`, lässt den Rauchtest dagegen laufen
und schiebt es erst danach mit `docker push` hoch. Das ergänzt die bestehende Reihenfolge, in der
das Git-Tag erst nach dem erfolgreichen Push entsteht: kein Tag ohne Image, und kein Image, das
nicht antwortet.

## Auslieferung

Ein `feat`-Commit. Nutzung, Variablen und Ergebnis bleiben gleich, damit ist es kein Breaking
Change — wer den Container heute betreibt, merkt nur, dass er kleiner geworden ist.
