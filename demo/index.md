# amber

A placeholder website rendered from a markdown file. Everything below exists to show what the
stylesheet has to cope with.

## Text

A paragraph with *emphasis*, **strong emphasis**, `inline code`, a [link](https://example.com)
and ~~struck through~~ words. A second sentence keeps the line long enough to wrap on a narrow
screen, which is the only way to see whether the line height is comfortable.

### Third level

#### Fourth level

##### Fifth level

###### Sixth level

## Lists

- first item
- second item
  - nested item
    - deeply nested item
- third item

1. numbered item
2. another one
3. a third

## Table

| variable | meaning | default |
| --- | --- | --- |
| `APP_NAME` | page title and heading | `amber` |
| `APP_TEXT_LEAD` | the line below the heading | `Simple Docker Placeholder Website` |

## Quote

> A placeholder has no business in a search index — least of all under the domain the real site
> is about to use.

## Code

```bash
docker run -p 80:80 \
  -v ./content:/app/content:ro \
  elnebuloso/amber:1.2.0
```

## Image

![the amber logo](logo.svg)

---

The horizontal rule above is part of the test too.
