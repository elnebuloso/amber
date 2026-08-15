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
  elnebuloso/amber:1.1.0
```

Images carry the full version as their only tag — there is no `latest`, because a moving
tag makes a deployment non-deterministic. Pick one from
[the tag list](https://hub.docker.com/r/elnebuloso/amber/tags).

## environment variables

| variable | default | appears as |
| --- | --- | --- |
| `APP_NAME` | `amber` | page title and heading |
| `APP_TEXT_LEAD` | `Simple Docker Placeholder Website` | the line below the heading |

Every response carries `X-Robots-Tag: noindex, nofollow`. A placeholder has no business in
a search index — least of all under the domain the real site is about to use.

## development

```
make up      # serves on http://127.0.0.1:8080
make down
make test    # builds the image and runs the smoke test against it
```

## links

- https://github.com/elnebuloso/amber
- https://hub.docker.com/r/elnebuloso/amber
