# amber

A placeholder website rendered from a markdown file. Everything below exists to show what the
stylesheet has to cope with.

## Text

A paragraph with *emphasis*, **strong emphasis**, `inline code`, a [link](https://example.com)
and ~~struck through~~ words. A second sentence keeps the line long enough to wrap on a narrow
screen, which is the only way to see whether the line height is comfortable. A bare address such
as https://example.com becomes a link on its own.

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

- [x] a task that is done
- [ ] a task that is not
- an ordinary item in the same list

## Table

| variable | meaning | default |
| --- | --- | --- |
| `APP_NAME` | page title and heading | `amber` |
| `APP_TEXT_LEAD` | the line below the heading | `This site is not online yet.` |
| `APP_LANG` | the page's language | `en` |

## Quote

> A placeholder has no business in a search index — least of all under the domain the real site
> is about to use.
>
> > A quote inside a quote, because markdown allows it.

## Code

```bash
docker run -p 80:80 \
  -v "$(pwd)/content:/app/content:ro" \
  elnebuloso/amber:1.2.0
```

A second block, with more syntax in it, so the colouring is visible at all:

```yaml
# every service shares one image
services:
  amber:
    image: elnebuloso/amber:1.2.0
    ports:
      - 127.0.0.1:8080:80
    environment:
      APP_NAME: "my site"
      APP_TEXT_LEAD: coming soon
```

## Image

<figure>
<img src="image.svg" alt="a striped field standing in for an operator's own image">
<figcaption>served from the mounted directory</figcaption>
</figure>

## Collapsible

Raw HTML passes through, which makes the usual disclosure idiom work:

<details>
<summary>What this page is for</summary>

It answers under a domain whose real site does not exist yet, and it goes away again.

</details>

## Footnotes

Footnotes are supported too,[^why] including a second one further along.[^where]

---

The horizontal rule above is part of the test too.

[^why]: The reference is superscript; the note itself is collected at the end of the page.
[^where]: Together with a link back to where it was cited.
