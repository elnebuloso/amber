# amber

[![Release](https://github.com/elnebuloso/amber/actions/workflows/release.yml/badge.svg)](https://github.com/elnebuloso/amber/actions/workflows/release.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/elnebuloso/amber.svg)](https://hub.docker.com/r/elnebuloso/amber)
[![License](https://img.shields.io/github/license/elnebuloso/amber.svg)](https://github.com/elnebuloso/amber)

A placeholder website in a container. Point a domain at it until the real site exists.

## usage

```
docker run -p 80:80 \
  -e APP_NAME="my site" \
  -e APP_TEXT_LEAD="coming soon" \
  elnebuloso/amber:1.2.0
```

Images carry the full version as their only tag — there is no `latest`, because a moving
tag makes a deployment non-deterministic. Pick one from
[the tag list](https://hub.docker.com/r/elnebuloso/amber/tags).

## environment variables

| variable | default | appears as |
| --- | --- | --- |
| `APP_NAME` | `amber` | page title and heading |
| `APP_TEXT_LEAD` | `This site is not online yet.` | the text below the heading |
| `APP_LANG` | `en` | the page's language, for screen readers and hyphenation |

`APP_TEXT_LEAD` is rendered as markdown, so a plain sentence stays a plain sentence and anything
more is available without mounting a file:

```
docker run -p 80:80 \
  -e APP_NAME="my site" \
  -e APP_TEXT_LEAD=$'Coming in spring. Write to [hello@example.com](mailto:hello@example.com).\n\n## What is coming\n\nA shop, and a page about the workshop.' \
  elnebuloso/amber:1.2.0
```

Raw HTML in it passes through unfiltered, as it does in a mounted file. A `{{` is **not** executed
here — unlike in a mounted file, the value is inserted rather than evaluated.

`APP_NAME` is never treated as markdown, so a name containing `*` or `_` stays as written.

Setting `APP_TEXT_LEAD` to an empty string gives a page with the name and nothing else — the
default applies when the variable is unset, not when it is empty.

Every response carries `X-Robots-Tag: noindex, nofollow`. A placeholder has no business in
a search index — least of all under the domain the real site is about to use.

## markdown page

Mount a directory containing an `index.md` at `/app/content` and the page is rendered from it
instead of the environment variables. `APP_NAME` stays the browser tab title.

Start the file with a `# ` heading. That heading is the only place the page says whose it is —
`APP_NAME` does not appear in the page itself in this mode, so a file that opens with `##` or with
a paragraph leaves the visitor without a name to read.

```
docker run -p 80:80 \
  -e APP_NAME="my site" \
  -v "$(pwd)/content:/app/content:ro" \
  elnebuloso/amber:1.2.0
```

Images next to the markdown file are served as well.

Everything in the mounted directory is served, not just the markdown — mount a directory that
contains only what should be public.

The markdown goes through Caddy's template engine before it is rendered. A `{{` in the content is
executed, and raw HTML passes through unfiltered. Only mount content you wrote yourself, and escape
or avoid `{{`.

A `{{` the engine cannot parse makes every URL answer **500 with the page built from the
environment variables**, so the domain still says whose it is while you fix the file. The status
code stays 500, which is what tells you something is wrong.

## development

```
make up      # 8080 plain, 8081 markdown
make down
make test    # builds the image and runs the smoke test against it
```

## links

- https://github.com/elnebuloso/amber
- https://hub.docker.com/r/elnebuloso/amber
