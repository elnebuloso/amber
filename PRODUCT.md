# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Two groups, both confirmed:

- **The maintainer**, parking his own domains. A domain exists, the real site does not yet, and
  something presentable has to answer under it today.
- **Strangers pulling the public image** from Docker Hub. They are an intended audience, not a
  side effect. That makes the README, sensible defaults and forgiving behaviour part of the
  product rather than housekeeping — nobody can ask the author a question before deploying.

The job in both cases: point a domain somewhere and be done in minutes, without building a site.

## Product Purpose

A placeholder website that ships as a container. Point a domain at it while the real site does not
exist yet; every URL answers with the same page, so the domain is fully covered from the first
request.

Success is that nobody has to think about it: it starts, it answers, it says the right thing, and
it is thrown away without ceremony once the real site is ready.

## Positioning

There is nothing to build and nothing to configure beyond what fits in a `docker run` line. Two
environment variables produce a finished page; a mounted markdown file produces a richer one. No
build step, no config file, no account, no template language to learn — and the image stays around
23 MB because the runtime does the rendering itself.

## Operating Context

Run under Docker or Compose, usually behind a reverse proxy, with a domain pointed at it. The
operator either passes two environment variables or mounts a directory containing an `index.md`.

Images are published to Docker Hub tagged with the full version only — no `latest`, no moving major
or minor tags — because a deployment that pulls a moving tag gets a different image over time from
an unchanged configuration.

## Capabilities and Constraints

Confirmed capabilities:

- `APP_NAME` and `APP_TEXT_LEAD` render a heading and one sentence.
- A mounted `/app/content/index.md` replaces that page and is rendered as GitHub-flavoured
  markdown, including footnotes and syntax-highlighted code. `APP_NAME` stays the tab title.
- Files next to the markdown, such as images, are served.
- The page's monospace face ships inside the image and is served from it, so code and labels look
  the same everywhere without the page reaching for a font server.
- Every URL, known or not, answers 200 with the page.
- `X-Robots-Tag: noindex, nofollow` is sent on every response, always.

Confirmed constraints, and the ones the maintainer named as permanent:

- It never accepts input. No forms, no newsletter, no submissions, nothing stored.
- No tracking, no analytics, no cookies — not even optionally.
- It stays a single page. No navigation, no sub-pages, no menu.
- No build chain. What lies in the image is what is served; no bundler, no generator, no npm.
- Beyond rendering a supported markdown file when one is present, it does nothing.
- No framework and no network fetches at runtime; a page must render with the machine offline.
- An operator-supplied stylesheet is deliberately not supported.

Known sharp edges an operator has to be told about, because they cannot be designed away:

- The markdown passes through the runtime's template engine, so `{{` in the content is executed and
  a broken one makes every URL answer 500.
- Raw HTML in the markdown passes through unfiltered.
- Everything in the mounted directory is served, not just the markdown.

## Brand Commitments

The name is `amber`. There is no logo or wordmark; the earlier one was removed deliberately.

The written voice is terse and free of marketing prose: short lines, plain statements, a reason
given where a reader would otherwise wonder. The README is the reference for that tone.

## Evidence on Hand

- `demo/index.md` — a demo page that deliberately contains every markdown construct the app can
  render, so styling coverage can be judged rather than claimed.
- `README.md` — the operator-facing documentation.
- Published releases on GitHub with generated notes, and the image on Docker Hub.

There are no users to cite, no adoption numbers, no testimonials and no benchmarks. Future work
must not invent any.

## Product Principles

1. **Nothing is taken in.** No input, no storage, no counting. Anything that would collect
   something from a visitor is out of scope by definition, not by priority.
2. **What lies in the image is what is served.** No build step between the source and the page —
   an operator can read every file that produces the result.
3. **Deployments stay deterministic.** Only full versions are published as tags, so the same
   configuration keeps pulling the same image.
4. **Strangers must succeed unaided.** Defaults, documentation and error behaviour are judged by
   whether someone who has never seen the repository gets a working page.
5. **Both modes carry equal weight.** A one-line placeholder and a small markdown page are equally
   normal uses; neither is the exception that may look worse.

## Accessibility & Inclusion

The page follows the visitor's light/dark setting automatically. Text contrast is held at or above
the WCAG AA threshold in both schemes, including the four tones used for code — this is measured,
not assumed, whenever colours change.
