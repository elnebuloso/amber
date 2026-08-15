---
name: amber
description: A placeholder page that says its piece and stops
colors:
  background: "#fbfbfa"
  text: "#1a1a18"
  muted: "#5c5c56"
  line: "#dededa"
  surface: "#f1f1ee"
  code-comment: "#6b6b61"
  code-string: "#7a5230"
  code-keyword: "#6a4a86"
  code-number: "#2b6660"
  background-dark: "#16161a"
  text-dark: "#ececea"
  muted-dark: "#9a9a95"
  line-dark: "#2f2f35"
  surface-dark: "#1f1f25"
  code-comment-dark: "#8b8b95"
  code-string-dark: "#d8ab7c"
  code-keyword-dark: "#c3a2dd"
  code-number-dark: "#79c7bd"
typography:
  display:
    fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, sans-serif"
    fontSize: "clamp(2.5rem, 8vw, 4rem)"
    fontWeight: 600
    lineHeight: 1.6
    letterSpacing: "-0.02em"
  headline:
    fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, sans-serif"
    fontSize: "1.6rem"
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "-0.01em"
  title:
    fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, sans-serif"
    fontSize: "1.3rem"
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "-0.01em"
  title-sm:
    fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, sans-serif"
    fontSize: "1.1rem"
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "-0.01em"
  title-xs:
    fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, sans-serif"
    fontSize: "1rem"
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "-0.01em"
  label:
    fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, sans-serif"
    fontSize: "0.95rem"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "normal"
  body:
    fontFamily: "system-ui, -apple-system, Segoe UI, Roboto, sans-serif"
    fontSize: "clamp(1.05rem, 2.5vw, 1.25rem)"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "normal"
  code:
    fontFamily: "ui-monospace, SFMono-Regular, Menlo, Consolas, monospace"
    fontSize: "0.85rem"
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "normal"
rounded:
  sm: "4px"
  md: "6px"
spacing:
  rhythm: "1.25rem"
  section: "2rem"
  frame: "2rem"
  measure: "34rem"
components:
  code-inline:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text}"
    typography: "{typography.code}"
    rounded: "{rounded.sm}"
    padding: "0.15em 0.35em"
  code-block:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text}"
    typography: "{typography.code}"
    rounded: "{rounded.md}"
    padding: "0.9rem 1rem"
  table-cell:
    backgroundColor: "{colors.background}"
    textColor: "{colors.muted}"
    padding: "0.5rem 0.7rem"
  quote:
    backgroundColor: "{colors.background}"
    textColor: "{colors.muted}"
    padding: "0 0 0 1rem"
  figure:
    backgroundColor: "{colors.background}"
    rounded: "{rounded.md}"
    width: "100%"
---

# Design System: amber

## Overview

**Creative North Star: "The Quiet Notice"**

A notice that does not press. It says what there is to say and then stops — no countdown, no
invitation to sign up, no rhetoric of anticipation. The page exists because a domain resolves
somewhere before its real site does, and its whole ambition is to make that moment unembarrassing.
Everything in the system follows from that: one column, no chrome, no motion, nothing to click but
the links the operator wrote.

The material is paper rather than screen. Every neutral leans warm — the background is off-white
rather than white, the text near-black rather than black — so the page reads as a printed card
someone left on the table, not as an interface that happens to be empty. Depth comes from tone and
a hairline, never from a shadow. Type is whatever the visitor's device already has, which means the
page appears complete on the first paint and looks native on every platform instead of importing a
personality from a font file.

Two things the page must never resemble were named explicitly. It is not a **maintenance or error
screen**: nothing here is broken, it is only not there yet, so there is no warning glyph, no
apology, no grey-on-grey. And it is not a **developer surface**: no terminal window, no monospace
headings, no green-on-black. The visitor is a visitor, not an operator.

**Key Characteristics:**
- One centred column, at most 34rem wide, on an otherwise empty field
- Warm neutrals only; colour appears exclusively inside code
- Flat by construction — no shadow anywhere in the system
- System type at every level, no web font, nothing fetched at render time
- Both colour schemes are first-class; neither is the afterthought

## Colors

A near-colourless palette of warm neutrals, with a single exception: syntax highlighting, where
four hues do the work that would otherwise need bold or italics.

### Primary

The system has no accent colour. Emphasis is made with weight, size and space, not with hue — the
absence is the point, and the four code tones below are the only saturated values in the product.

### Neutral

- **Warm Paper** (`{colors.background}` light, `{colors.background-dark}` dark): the page ground.
  Off-white in daylight, a warm-tinted near-black at night; never `#ffffff` and never `#000000`.
- **Warm Ink** (`{colors.text}` / `{colors.text-dark}`): headings and running text.
- **Quiet Ink** (`{colors.muted}` / `{colors.muted-dark}`): body text under a heading, list items,
  table cells, quotes. The tone that says "secondary" without shrinking the type.
- **Hairline** (`{colors.line}` / `{colors.line-dark}`): table rules, the horizontal rule, the mark
  beside a quote. The only structural line in the system.
- **Sunken Surface** (`{colors.surface}` / `{colors.surface-dark}`): the ground behind code, inline
  and block. One step away from the page, never two.

### Tertiary

Reserved for code, and only for code:

- **Comment** (`{colors.code-comment}` / `{colors.code-comment-dark}`): comments, set in italic.
- **String** (`{colors.code-string}` / `{colors.code-string-dark}`): all string and escape tokens.
- **Keyword** (`{colors.code-keyword}` / `{colors.code-keyword-dark}`): keywords, builtins, and the
  keys of a mapping.
- **Number** (`{colors.code-number}` / `{colors.code-number-dark}`): numeric literals and constants.

### Named Rules

**The Warm Paper Rule.** No pure white and no pure black, in either scheme. Every neutral carries a
warm cast; a cool grey reads as software and breaks the material.

**The Four Tones Rule.** Code gets exactly four colours. A highlighter emits sixty token classes;
anything not in the four groups keeps body colour. Adding a fifth means arguing why the page needs
it more than it needs quiet.

**The Measured Contrast Rule.** Whenever a colour changes, its contrast against its own ground is
measured in both schemes and held at or above 4.5:1. The lowest value in the system today is 4.76
(comment on sunken surface, light). No colour ships on the assumption that it "looks fine".

## Typography

**Display Font:** system-ui (falling back through -apple-system, Segoe UI, Roboto, sans-serif)
**Body Font:** the same stack — one family throughout
**Label/Mono Font:** ui-monospace (SFMono-Regular, Menlo, Consolas)

**Character:** The page borrows the visitor's own interface font, so it looks like it belongs on
whatever device opened it. That is a deliberate refusal of a signature typeface: nothing to
download, nothing to flash, no imported personality on a page that is meant to be temporary.

### Hierarchy

- **Display** (600, `clamp(2.5rem, 8vw, 4rem)`, tight `-0.02em`): the page's name. Exactly one per
  page, scaling with the viewport instead of wrapping.
- **Headline** (600, 1.6rem, 1.3): the top-level division within a markdown page.
- **Title** (600, 1.3rem, 1.3): the third heading level, with `title-sm` (1.1rem) and `title-xs`
  (1rem) carrying the fourth, fifth and sixth.
- **Body** (400, `clamp(1.05rem, 2.5vw, 1.25rem)`, 1.6): the sentence under the name, and every
  paragraph. Held to a 34rem measure.
- **Label** (400, 0.95rem, 1.6): table text, the one place where the ramp steps below body size for
  a reason other than code.
- **Code** (400, 0.85rem in blocks, 0.9em inline, 1.5): monospace, on the sunken surface.

The sixth heading level drops to quiet ink instead of shrinking further — the system runs out of
size before it runs out of levels, and colour is the gentler way to say "deepest".

### Named Rules

**The Borrowed Type Rule.** Only fonts the device already has. No web font, no `@font-face`, no
preconnect — the page must render complete with the machine offline.

**The One Voice Rule.** One family for everything except code. A second display face would make the
page an identity; it is a notice.

## Layout

A single column, centred on both axes in an otherwise empty field. The body is a flex container at
`min-height: 100vh` with a `{spacing.frame}` frame; the column itself is capped at
`{spacing.measure}` and — critically — carries `min-width: 0`, without which wide content stretches
the column past the viewport and the page scrolls sideways instead of the content scrolling inside
itself.

Vertical rhythm is one value: `{spacing.rhythm}` between every pair of siblings in the column.
Headings take `{spacing.section}` above instead, which is what separates a section from the
paragraph that ended it. Nothing else adjusts spacing; the exceptions are the system.

Because the container uses `min-height` rather than `height`, a short page sits optically centred
while a long one starts at the top and simply grows — the same rule serves a two-line placeholder
and a full markdown document without a breakpoint between them.

Responsive behaviour is carried by the type scale (`clamp`) and by the measure, not by media
queries: the only media query in the system switches the colour scheme. At 360px the display drops
to its floor of 2.5rem and the column takes the width it is given.

### Named Rules

**The One Column Rule.** Everything lives in one column of at most 34rem. No sidebar, no grid, no
second region — a placeholder that needs a layout has stopped being a placeholder.

**The Content Scrolls, Not The Page Rule.** Anything that cannot fit — a wide table, a long code
line — scrolls inside its own box. The document itself never scrolls horizontally, at any width.

## Elevation & Depth

There is no shadow anywhere in this system, and none should be added. Depth is expressed by tone
and by a hairline: code sits on a surface one step from the page, tables and rules are separated by
a single-pixel line, a quote is marked by a 3px stroke down its left edge. That is the entire
vocabulary.

The reason is material, not minimalism: a shadow implies a floating object above a plane, and this
page is a printed card. Nothing floats over it.

### Named Rules

**The Flat Rule.** No `box-shadow`, no `filter: drop-shadow`, no layered card. If something needs
to read as separate, it changes tone or gains a hairline.

## Shapes

Two radii, both small enough to read as a softened edge rather than a pill: `{rounded.sm}` for
inline code, `{rounded.md}` for code blocks and images. Everything else is square, because
everything else is text.

Borders exist only as hairlines and only in three places: under a table row, across a horizontal
rule, and down the left side of a quote. There is no boxed container, no outlined card, no framed
region — a border that encloses content would build the panel this system does not have.

## Components

There are no buttons, inputs, chips or navigation in this product, and none should be invented for
it: the page takes no input and has nowhere to go. What follows are the text elements a markdown
page produces, which is the entire component set.

### Headings

- **Character:** confident but unornamented; weight and size do all the work.
- **Display** carries the page name at `{typography.display}`; every markdown page has exactly one.
- **Sub-levels** take `{spacing.section}` of air above them and none below — the rhythm rule
  supplies the gap to the paragraph that follows.

### Body and Lists

- **Character:** quiet ink at a comfortable measure, never full black.
- Lists indent by 1.4rem and set their items in quiet ink, with 0.35rem between items and around a
  nested level. A list reads as one block of secondary text, not as a stack of separate lines.

### Code

- **Inline:** sunken surface, `{rounded.sm}`, a hair of padding (0.15em 0.35em), 0.9em so it does
  not tower over the surrounding sentence.
- **Block:** sunken surface, `{rounded.md}`, 0.9rem/1rem padding, horizontally scrollable, with the
  four syntax tones. The inline background is removed inside a block so the surface is not painted
  twice.

### Tables

- **Character:** ruled, not boxed.
- Header cells in warm ink at weight 600, body cells in quiet ink, each row closed by a hairline.
  The table is a block-level scroll container at `width: max-content` capped to 100%, so an
  over-wide table scrolls within itself.

### Quotes

- **Character:** set aside rather than boxed.
- Quiet ink, italic, a 3px hairline stroke down the left edge, 1rem of padding after it. No
  background tint and no quotation glyph.

### Images

- Full column width at most, height automatic, `{rounded.md}` corners. No frame, no caption
  styling, no shadow.

## Do's and Don'ts

### Do:
- **Do** measure contrast in both schemes whenever a colour changes; hold 4.5:1 or better.
- **Do** keep `min-width: 0` on the column — it is what makes the scroll rules work at all.
- **Do** express a new distinction with tone, weight or space before reaching for a colour.
- **Do** let wide content scroll inside its own box.
- **Do** treat both colour schemes as equally finished; test the dark one before shipping.

### Don't:
- **Don't** add a shadow, a boxed card, or an outlined container.
- **Don't** load a web font, an icon set, or any asset from the network.
- **Don't** introduce an accent colour outside the four code tones.
- **Don't** make it look like a maintenance or error screen — no warning glyph, no apology, no
  grey-on-grey.
- **Don't** make it look like a developer surface — no terminal frame, no monospace headings.
- **Don't** add motion, a hero image, or anything that asks for attention.
