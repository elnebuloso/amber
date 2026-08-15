<img src="https://raw.githubusercontent.com/elnebuloso/amber/master/logo.png" width="100%"/>

# amber

![Release](https://github.com/elnebuloso/amber/workflows/Release/badge.svg)
[![Docker Pulls](https://img.shields.io/docker/pulls/elnebuloso/amber.svg)](https://hub.docker.com/r/elnebuloso/amber)
[![GitHub](https://img.shields.io/github/license/elnebuloso/amber.svg)](https://github.com/elnebuloso/amber)

Simple Docker Placeholder Website

## github

- https://github.com/elnebuloso/amber

## docker

- https://hub.docker.com/r/elnebuloso/amber
- https://hub.docker.com/r/elnebuloso/amber/tags?page=1&ordering=last_updated

## environment variables

- APP_NAME, default `amber`
- APP_TEXT_LEAD, default `Simple Docker Placeholder Website`
- APP_ENV no longer exists. The `X-Robots-Tag: noindex, nofollow` header is sent on every response, always.

## document root

Content is served from `/app`. `index.html` is the page.

## development
```
make up
make down
make test
```
