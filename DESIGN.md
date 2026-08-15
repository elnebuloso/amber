---
name: amber
description: A placeholder page that reads as a technical document
colors:
  bg: "oklch(0.99 0.002 250)"
  bg-sunken: "oklch(0.965 0.004 250)"
  bg-note: "oklch(0.965 0.008 60)"
  fg: "oklch(0.2 0.005 250)"
  fg-muted: "oklch(0.38 0.005 250)"
  fg-subtle: "oklch(0.42 0.005 250)"
  fg-faint: "oklch(0.55 0.005 250)"
  fg-note: "oklch(0.33 0.02 60)"
  accent: "oklch(0.58 0.14 45)"
  accent-ink: "oklch(0.5 0.14 45)"
  accent-code: "oklch(0.45 0.13 45)"
  border-strong: "oklch(0.2 0.005 250)"
  border: "oklch(0.91 0.004 250)"
  code-comment: "oklch(0.54 0.008 250)"
  code-keyword: "oklch(0.46 0.14 300)"
  code-number: "oklch(0.5 0.13 40)"
  code-string: "oklch(0.44 0.11 155)"
  bg-dark: "oklch(0.18 0.006 250)"
  bg-sunken-dark: "oklch(0.225 0.006 250)"
  bg-note-dark: "oklch(0.25 0.02 60)"
  fg-dark: "oklch(0.93 0.004 250)"
  fg-muted-dark: "oklch(0.76 0.005 250)"
  fg-faint-dark: "oklch(0.66 0.005 250)"
  fg-note-dark: "oklch(0.88 0.01 60)"
  accent-dark: "oklch(0.8 0.13 50)"
  accent-ink-dark: "oklch(0.82 0.12 50)"
  border-strong-dark: "oklch(0.93 0.004 250)"
  border-dark: "oklch(0.28 0.006 250)"
  code-comment-dark: "oklch(0.66 0.008 250)"
  code-keyword-dark: "oklch(0.78 0.12 300)"
  code-number-dark: "oklch(0.82 0.11 45)"
  code-string-dark: "oklch(0.8 0.11 155)"
typography:
  display:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "2.75rem"
    fontWeight: 700
    lineHeight: 1.05
    letterSpacing: "-0.03em"
  lead:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "1.125rem"
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "normal"
  headline:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "1rem"
    fontWeight: 700
    lineHeight: 1.62
    letterSpacing: "-0.01em"
  title:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "0.96875rem"
    fontWeight: 700
    lineHeight: 1.62
    letterSpacing: "normal"
  body:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "0.96875rem"
    fontWeight: 400
    lineHeight: 1.62
    letterSpacing: "normal"
  label:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "0.6875rem"
    fontWeight: 700
    lineHeight: 1.62
    letterSpacing: "0.14em"
  label-mono:
    fontFamily: "IBM Plex Mono, ui-monospace, SFMono-Regular, Menlo, Consolas, monospace"
    fontSize: "0.6875rem"
    fontWeight: 500
    lineHeight: 1.62
    letterSpacing: "0.12em"
  code:
    fontFamily: "IBM Plex Mono, ui-monospace, SFMono-Regular, Menlo, Consolas, monospace"
    fontSize: "0.8125rem"
    fontWeight: 400
    lineHeight: 1.7
    letterSpacing: "normal"
rounded:
  none: "0"
spacing:
  "2": "0.5rem"
  "3": "0.75rem"
  "4": "1rem"
  "5": "1.25rem"
  "6": "1.5rem"
  "8": "2rem"
  "10": "2.5rem"
  "14": "3.5rem"
  "16": "4rem"
components:
  section-label:
    textColor: "{colors.fg}"
    typography: "{typography.label}"
    rounded: "{rounded.none}"
    padding: "0.75rem 0 0"
  link:
    textColor: "{colors.accent-ink}"
    typography: "{typography.body}"
  code-inline:
    textColor: "{colors.accent-code}"
    typography: "{typography.code}"
  code-block:
    backgroundColor: "{colors.bg-sunken}"
    textColor: "{colors.fg}"
    typography: "{typography.code}"
    rounded: "{rounded.none}"
    padding: "1.25rem"
  note:
    backgroundColor: "{colors.bg-note}"
    textColor: "{colors.fg-note}"
    rounded: "{rounded.none}"
    padding: "1rem 1.25rem"
  table-head:
    textColor: "{colors.fg}"
    typography: "{typography.label-mono}"
    padding: "0 0.75rem 0.5rem 0"
  table-cell:
    textColor: "{colors.fg}"
    typography: "{typography.body}"
    padding: "0.75rem 0.75rem 0.75rem 0"
  caption:
    textColor: "{colors.fg-faint}"
    typography: "{typography.label-mono}"
  task-checkbox:
    backgroundColor: "transparent"
    rounded: "{rounded.none}"
    size: "0.85em"
  task-checkbox-checked:
    backgroundColor: "{colors.accent}"
    rounded: "{rounded.none}"
    size: "0.85em"
---

# Design System: amber

## Overview

**Creative North Star: "The Technical Document"**

amber looks like a page torn out of a well-set manual: a flat sheet, ruled into
sections, with nothing on it that is not text. There is no chrome, no card, no
container — the page *is* the container. Sections are announced by a small
uppercase tracked label sitting under a 2px rule that runs the full width of the
column; everything else is body text, a table, a quote or a block of code. One
warm accent at hue 45–50 carries links, inline code and the one filled control
the system has, and it is the only saturated colour outside a code block.

The system is built for two surfaces of very different weight, and both have to
look deliberate. The default is a heading and one sentence on an otherwise empty
window; the richer one is an operator's markdown file rendered whole. The same
rules serve both because the page column is centred vertically by `min-height`
rather than `height` — two lines sit in the middle of the viewport, a long
document grows from the top under the identical stylesheet.

Every value lives in `app/tokens.css` and is authored in OKLCH, light as the
default and dark applied from `prefers-color-scheme`. Contrast is not a review
step here; it is a constraint the palette was tuned to. Text tones were measured
in-browser against their own surface in both schemes and the lowest pair reads
4.58:1, above the WCAG AA floor. There is no build chain and no runtime network
fetch: the monospace face ships inside the image as two `woff2` files, so the
page renders complete with the machine offline.

**Key Characteristics:**

- Flat sheet, no shadows, no radii, no gradients, no motion.
- Two line weights only: a 2px structural rule and a 1px hairline.
- Uppercase tracked labels for section heads, table heads and captions.
- One warm accent; four code tones; everything else neutral at hue 250.
- Styled by element selector — the renderer emits no classes to hook.
- Light and dark are peers, both measured to AA.

## Colors

Cool near-grey neutrals at hue 250 carrying one warm accent at hue 45–50 and a
warm note tint at hue 60 — the only three hue families on the page outside
syntax highlighting.

### Primary

- **Ember** (`{colors.accent}`): the one filled shape in the system — a checked
  task-list box and the disclosure triangle's marker. Full-strength accent,
  used as a fill, never as text.
- **Ember Ink** (`{colors.accent-ink}`): links, footnote references and the
  focus outline. A step darker than Ember because it has to be read as text.
- **Ember Deep** (`{colors.accent-code}`): inline code only. Darkest of the
  three, so a code span inside a sentence is distinguishable from a link
  without borrowing an underline.

### Neutral

- **Paper** (`{colors.bg}`): the page. Not white — a barely-warmed near-white
  that stops the sheet from glaring.
- **Sunken Paper** (`{colors.bg-sunken}`): code blocks. Depth here is a tone
  step, not a shadow or a border.
- **Note Tint** (`{colors.bg-note}`): the blockquote panel, and the selection
  highlight — the same warm wash means "set aside" in both places.
- **Ink** (`{colors.fg}`): headings, body text, code-block text.
- **Muted Ink** (`{colors.fg-muted}`): the lead sentence, and h5/h6.
- **Subtle Ink** (`{colors.fg-subtle}`): nested list items and the collected
  footnotes — text one level away from the main argument.
- **Faint Ink** (`{colors.fg-faint}`): captions and struck-through text. The
  quietest tone that still clears AA.
- **Note Ink** (`{colors.fg-note}`): text inside the note panel, warmed to
  hue 60 to belong to its own surface.
- **Rule** (`{colors.border-strong}`): the 2px structural rule; the same value
  as Ink, so a section head and its rule are one mark.
- **Hairline** (`{colors.border}`): 1px dividers — table row lines, `hr`, the
  nested-quote stripe, an unchecked checkbox.

### Tertiary

Four code tones, and only four, measured against Sunken Paper:
**Comment Grey** (`{colors.code-comment}`), **Keyword Violet**
(`{colors.code-keyword}`), **Number Amber** (`{colors.code-number}`),
**String Green** (`{colors.code-string}`). The renderer emits the full Chroma
class vocabulary; every class is mapped onto one of these four, and anything
unmapped falls back to body Ink.

### Named Rules

**The Four Tones Rule.** Syntax highlighting has exactly four colours. A new
Chroma token class joins one of the four groups in `app/style.css` or it stays
body colour. A fifth tone is not added to distinguish a fifth category.

**The Measured Palette Rule.** No colour value ships until its pair has been
measured in-browser against the surface it actually sits on, in both schemes.
The floor is 4.5:1; the system's current lowest is 4.58:1. A value is never
lightened to make a design read better — that is the one direction this rule
does not bend.

**The One Warm Hue Rule.** Outside code blocks the page carries a single warm
family (hue 45–60): the accent and the note tint. A second accent hue is not
introduced to mark a new kind of content; tone, rule weight or the mono face
does that job instead.

## Typography

**Display / Body Font:** Helvetica (with Helvetica Neue, Arial, sans-serif)
**Label / Mono Font:** IBM Plex Mono, self-hosted at 400 and 500

**Character:** A plain grotesque doing all the reading, with a monospace used
strictly as a *signal* rather than a texture — it appears only where something
is machine-shaped (code) or is a label rather than a sentence (table heads,
captions). Nothing is set in a display face; the page has no voice beyond the
one the operator's words carry.

### Hierarchy

- **Display** (700, 2.75rem / 2.125rem below 34rem, 1.05, -0.03em): the page
  title, once. It is the only large type in the system.
- **Lead** (400, 1.125rem / 1.0625rem below 34rem, 1.5, Muted Ink): the first
  paragraph after the title, clamped to 34ch so it breaks into a short stack
  rather than running the full column.
- **Label** (700, 0.6875rem, 0.14em, uppercase): section heads (`h2`), set
  under a 2px rule. This is the system's signature mark.
- **Headline** (700, 1rem, -0.01em): `h3`, the first heading that reads as a
  heading rather than a label.
- **Title** (700, 0.96875rem): `h4`, `h5`, `h6` — body size, bold. `h5` and
  `h6` step back to Muted Ink.
- **Body** (400, 0.96875rem, 1.62): everything else, in a 40rem column with
  `text-wrap: pretty`.
- **Label Mono** (500, 0.6875rem, 0.12em / 0.08em, uppercase): table heads and
  figure captions.
- **Code** (400, 0.8125rem, 1.7): inline and block code, and footnote text at
  the same size in the sans face.

### Named Rules

**The Ruled Label Rule.** A section head is small, uppercase, tracked at 0.14em
and sits directly beneath a full-width 2px rule with 0.75rem of air between
them. The rule and the label are one unit: neither appears without the other,
and no other element in the system draws a 2px horizontal line.

**The Tone-Not-Size Rule.** The type scale runs out of sizes before markdown
runs out of heading levels. Below `h4`, depth is expressed by dropping to Muted
Ink, never by shrinking below body size. A future level does the same.

**The Mono-Means-Machine Rule.** The monospace face marks code, table heads and
captions. It is never used for body prose, a heading, or emphasis.

## Layout

A single centred column, `max-width: 40rem`, on a `min-height: 100vh` flex body
that centres its content vertically. That one declaration serves both surfaces:
the two-line environment-variable page sits mid-viewport, a long markdown
document starts at the top and grows. Page padding is 3.5rem top / 1.5rem
side / 4rem bottom, tightening to 2rem / 1.25rem / 2.5rem below 34rem — the
single breakpoint in the system, which also shrinks the display and lead sizes.

Vertical rhythm comes from a small step scale (0.5 / 0.75 / 1 / 1.25 / 1.5 /
2 / 2.5 / 3.5 / 4rem). Block elements share a 1.25rem bottom margin; a section
head opens 2.5rem of space above itself, an `h3` 2rem, an `h4` 1.5rem. List
items are separated by 0.5rem and the last item's margin is zeroed so a list
does not double-space against the block below it.

`overflow-wrap: break-word` is set on `body` and `min-width: 0` on the column:
a bare URL or a long identifier in a table cell breaks rather than widening the
page. Code blocks scroll horizontally instead of breaking, because a wrapped
command line is a wrong command line.

### Named Rules

**The Unbreakable Column Rule.** Nothing an operator writes may push the
document sideways. Any new element either wraps, breaks or scrolls within the
40rem column.

**The Both-Modes Rule.** Every layout rule is checked against both surfaces —
the two-line placeholder and the full markdown page. A rule that only looks
right on one of them is not a rule yet.

## Elevation & Depth

There are no shadows anywhere in this system, and none may be added. Depth is
tonal and linear only: a code block recedes by sitting on a slightly darker
surface, a note steps forward by carrying a warm tint, and structure is drawn
with exactly two line weights — a 2px rule at full ink for section boundaries
and a 1px hairline at low contrast for dividers and small controls. There is
also no motion: no transitions, no transforms, no animation, on any state.

### Named Rules

**The Two Weights Rule.** Every line on the page is either the 2px structural
rule or the 1px hairline. A third weight, a dashed line or a coloured border is
not part of the vocabulary.

**The Tint-Once Rule.** A tinted surface does not nest inside a tinted surface.
A quote inside a quote drops the tint and steps back to a hairline stripe;
anything nested deeper does the same rather than stacking washes.

## Shapes

Every corner is square. There is no border-radius token because there is no
radius: not on code blocks, not on the note panel, not on the drawn checkbox,
not on the focus outline. The only drawn geometry in the system is the
0.85em square checkbox — hairline outline when empty, solid accent fill when
checked — and it is square for the same reason everything else is.

Form language is horizontal: full-width rules that segment the column,
full-width table row lines, full-bleed code and note panels that run edge to
edge of the column with no inset. Nothing is boxed on all four sides except the
checkbox.

## Components

There are no interactive components in this product — no buttons, no inputs, no
navigation, no forms, by product constraint. What follows is the full set of
things the page actually renders.

### Section Head

The signature mark. A 2px full-ink rule across the column, 0.75rem of air, then
the section name in 11px uppercase tracked 0.14em at weight 700. Opens 2.5rem
above, closes 0.75rem below. Used for `h2` and for the footnotes block, which is
the only other element allowed to draw the rule.

### Links

Ember Ink with a standard underline offset 2px. Hover thickens the underline to
2px; there is no colour change and no transition. Footnote references and
back-references drop the underline entirely — they are digits and arrows, and
an underline would read them as part of the sentence.

### Code

- **Inline:** mono at 13px in Ember Deep, no background, no border, no padding.
  Inside a table cell it reverts to body Ink so the cell does not read as a row
  of links.
- **Block:** 1.25rem of padding on Sunken Paper, square, no border, body Ink
  for unhighlighted text, line-height 1.7, horizontal scroll on overflow. The
  four syntax tones sit on top.

### Note (blockquote)

A warm tint panel, 1rem / 1.25rem padding, square, explicitly borderless — the
tint alone marks it. Its last child's bottom margin is zeroed. A nested quote
drops the tint for a hairline left stripe.

### Table

Full width, collapsed borders, body size. The head row is mono, 11px, weight
500, uppercase, tracked 0.12em, left-aligned, sitting on the 2px rule. Body
cells carry 0.75rem of vertical padding and a hairline bottom line. The last
column's right padding is zeroed so the table aligns flush with the column.

### Figure and Caption

Images are block-level, `max-width: 100%`, no frame and no radius. The caption
sits 0.5rem below in mono, 11px, uppercase, tracked 0.08em, in Faint Ink.

### Task List

A drawn checkbox, because the renderer emits the control `disabled` and a
disabled control ignores `accent-color`. `appearance: none`, 0.85em square,
hairline outline when empty, Ember fill when checked. The list marker is removed
per item — not per list — and the item pulls back by the list indent, because an
ordinary bullet may sit in the same list.

### Disclosure

Raw HTML passes through the renderer, so `details`/`summary` is a usable idiom.
The summary is bold body text with a pointer cursor; its native marker is tinted
Ember. Nothing else about it is styled — the native triangle is the affordance.

### Footnotes

The collected notes sit below a section rule at 13px in Subtle Ink, with the
renderer's own `hr` hidden so the rule is not drawn twice.

### Focus and Selection

`:focus-visible` draws a 2px solid Ember Ink outline offset 2px — the
structural rule weight, reused as a focus ring. Selection uses the Note Tint
background with body Ink text.

## Do's and Don'ts

### Do:

- **Do** put every value in `app/tokens.css` and author it in OKLCH; hue 250 for
  neutrals, hue 45–50 for the accent, hue 60 for the note tint.
- **Do** style by element selector. The markdown renderer emits no classes, so a
  rule that needs a class only works for hand-written markup and silently fails
  on the operator's page.
- **Do** measure both schemes in a browser whenever a colour changes, and record
  the lowest ratio. The floor is 4.5:1.
- **Do** define every colour in both the light block and the
  `prefers-color-scheme: dark` block. A token that exists in only one scheme is
  a bug.
- **Do** check every change against both surfaces — the two-line placeholder and
  the full `demo/index.md` page, which exercises every construct the product can
  render.
- **Do** ship any new font file inside the image and declare it with
  `@font-face` locally.
- **Do** express new depth with a tone step or one of the two line weights.

### Don't:

- **Don't** add a box-shadow, a border-radius, a gradient, a transition or an
  animation. The sheet is flat and still.
- **Don't** fetch anything at runtime — no font CDN, no script, no image from
  another host. The page must render with the machine offline.
- **Don't** introduce a third line weight, a second accent hue, or a fifth
  syntax tone.
- **Don't** add a fifth heading size. Below `h4`, step back in tone instead.
- **Don't** set body prose, headings or emphasis in the monospace face.
- **Don't** let any element exceed the 40rem column or force horizontal page
  scroll; wrap, break, or scroll inside the block.
- **Don't** nest a tinted surface inside a tinted surface.
- **Don't** add a logo, wordmark or decorative image — the product has none by
  commitment, and the page's only mark is the ruled section label.
