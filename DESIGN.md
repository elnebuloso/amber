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
  fg-subtle-dark: "oklch(0.71 0.005 250)"
  fg-faint-dark: "oklch(0.66 0.005 250)"
  fg-note-dark: "oklch(0.88 0.01 60)"
  accent-dark: "oklch(0.8 0.13 50)"
  accent-ink-dark: "oklch(0.82 0.12 50)"
  accent-code-dark: "oklch(0.87 0.11 50)"
  border-strong-dark: "oklch(0.76 0.004 250)"
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
    fontSize: "1.25rem"
    fontWeight: 700
    lineHeight: 1.62
    letterSpacing: "-0.01em"
  title:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "0.96875rem"
    fontWeight: 700
    lineHeight: 1.62
    letterSpacing: "normal"
  title-quiet:
    fontFamily: "Helvetica, Helvetica Neue, Arial, sans-serif"
    fontSize: "0.96875rem"
    fontWeight: 500
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
  "1": "0.25rem"
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
  footnotes:
    textColor: "{colors.fg-subtle}"
    typography: "{typography.code}"
    padding: "0.75rem 0 0"
  selection:
    backgroundColor: "{colors.accent-ink}"
    textColor: "{colors.bg}"
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
container — the page *is* the container.

The system serves two surfaces of very different weight, and both have to look
deliberate: a heading and one sentence on an otherwise empty window, or an
operator's markdown file rendered whole. One declaration serves both — the
column is centred vertically by `min-height` rather than `height`, so two lines
sit mid-viewport and a long document grows from the top under the identical
stylesheet. Both reach the same element vocabulary, because `APP_TEXT_LEAD` runs
through the same markdown renderer as a mounted file. What separates the
surfaces is where the text comes from, not what it can be.

`APP_NAME` is the one thing held back from the renderer and set as a literal
`h1`: composed into the same markdown document it came back as
`<h1><em>star</em> site</h1>` (measured), and a page title must not be
reformatted by its own value. The principle runs both ways — `APP_NAME` is
emitted through `| html` in `<title>` and `<h1>`, so markup written into a name
shows as characters instead of breaking out of the element it names.
`APP_TEXT_LEAD` stays unescaped, because markdown there is the promise.

There is no build chain and no runtime fetch: the monospace face ships inside
the image as two `woff2` files, so the page renders complete with the machine
offline.

**Key Characteristics:**

- Flat sheet, no shadows, no radii, no gradients, no motion.
- Two line weights only: a 2px structural rule and a 1px hairline.
- Uppercase tracked labels for section heads, table heads and captions.
- One warm accent; four code tones; everything else neutral at hue 250.
- Styled by element selector — the renderer emits no classes to hook.
- Light and dark are peers, both measured to AA, with the same tone relations.
- One surface only — the failed page is the placeholder page, not an error design.

## Colors

Cool near-grey neutrals at hue 250 carrying one warm accent at hue 45–50 and a
warm note tint at hue 60 — the only three hue families outside syntax
highlighting. Every value is authored in OKLCH in `app/tokens.css`, light as the
default and dark from `prefers-color-scheme`.

### Primary

- **Ember** (`{colors.accent}`): the one filled shape in the system — a checked
  task-list box, the disclosure marker. A fill, never text.
- **Ember Ink** (`{colors.accent-ink}`): links, footnote references, focus
  outline, selection background. The one accent step also measured for use
  *behind* text.
- **Ember Deep** (`{colors.accent-code}`): inline code only. The far end of the
  cascade from Ember Ink, so a code span inside a sentence is distinguishable
  from a link without borrowing an underline.

The three steps are a cascade in both schemes, mirrored rather than repeated:
where light steps down in lightness from fill to link to code, dark steps up.

### Neutral

- **Paper** (`{colors.bg}`): the page — a barely-warmed near-white rather than
  white, so the sheet does not glare. Also the text colour inside a selection.
- **Sunken Paper** (`{colors.bg-sunken}`): code blocks. Depth is a tone step,
  not a shadow or a border.
- **Note Tint** (`{colors.bg-note}`): the blockquote panel. A wash this close to
  the page can mark a block that already has padding; it cannot carry a
  transient highlight, which is why selection uses the accent instead.
- **Ink** (`{colors.fg}`): headings and body text.
- **Muted Ink** (`{colors.fg-muted}`): the lead sentence, `h5`/`h6`.
- **Subtle Ink** (`{colors.fg-subtle}`): text one level from the main argument —
  nested list items, collected footnotes. One step below Muted Ink in both
  schemes.
- **Faint Ink** (`{colors.fg-faint}`): captions and struck-through text. The
  quietest tone that still clears AA.
- **Note Ink** (`{colors.fg-note}`): note-panel text, warmed to hue 60 to belong
  to its own surface.
- **Rule** (`{colors.border-strong}`): the structural rule and the unchecked
  checkbox outline. In light it is Ink's own value, so a section head and its
  rule read as one mark. Dark does not repeat that literally: at Ink's lightness
  seven near-white bands bloomed against the dark page and read louder than the
  labels beneath them, so the dark rule sits at 8.73:1 against the page — the
  weight of secondary text, not of a heading. 8.73:1 also clears WCAG 1.4.11's
  3:1 for the checkbox outline, a component boundary rather than text; that
  number is what makes the dimming safe rather than a matter of taste.
- **Hairline** (`{colors.border}`): every 1px divider — table rows, `hr`, the
  nested-quote stripe, the footnote block's top line, an unchecked checkbox.

### Tertiary

Four code tones, and only four, measured against Sunken Paper: **Comment Grey**
(`{colors.code-comment}`), **Keyword Violet** (`{colors.code-keyword}`),
**Number Amber** (`{colors.code-number}`), **String Green**
(`{colors.code-string}`). The renderer emits the full Chroma class vocabulary;
every class maps onto one of the four, and anything unmapped falls back to Ink.

### Named Rules

**The Four Tones Rule.** Syntax highlighting has exactly four colours. A new
Chroma token class joins one of the four groups in `app/style.css` or it stays
body colour. A fifth tone is not added to distinguish a fifth category.

**The Measured Palette Rule.** No colour value ships until its pair has been
measured in-browser against the surface it actually sits on, in both schemes.
The floor is 4.5:1; 26 of 26 pairs clear it and the lowest is 4.58:1 (code
comment on Sunken Paper, light). This rule bit once and is recorded so it bites
again: the first selection highlight used `{colors.accent}` and measured 4.41:1,
so the shipped value is `{colors.accent-ink}` at 6.2:1 light and 10.3:1 dark. A
value is never lightened to make a design read better.

**The Mirrored Scheme Rule.** Dark is not a separate palette, it is the same
*relationships* inverted — which is not the same as the same lightness values.
Two tokens once collapsed onto their neighbours in dark only — Subtle Ink onto
Muted Ink, Ember Deep onto Ember Ink — silently deleting distinctions the light
scheme still made. When a token moves, check its neighbours in the *other*
scheme. The heavy rule is the documented exception: mirroring Ink's lightness
literally made a line that measured almost identically (17.66:1 light, 15.28:1
dark) read far louder, because a light line on a dark ground blooms and a dark
line on a light ground does not. Where perception and arithmetic disagree,
perception decides which value ships and the number is measured afterwards to
prove it is safe — never the other way round.

**The One Warm Hue Rule.** Outside code blocks the page carries a single warm
family: the accent and the note tint. A second accent hue is not introduced to
mark a new kind of content; tone, rule weight or the mono face does that job.

## Typography

**Display / Body Font:** Helvetica (with Helvetica Neue, Arial, sans-serif)
**Label / Mono Font:** IBM Plex Mono, self-hosted at 400 and 500

**Character:** A plain grotesque doing all the reading, with a monospace used as
a *signal* rather than a texture — it appears only where something is
machine-shaped (code) or is a label rather than a sentence (table heads,
captions). Nothing is set in a display face; the page has no voice beyond the
one the operator's words carry.

### Hierarchy

- **Display**: the page title, once, and the only large type in the system. It
  hyphenates (`hyphens: auto`) so a long single-word `APP_NAME` breaks at a
  syllable boundary rather than mid-word, and the break points are correct
  rather than arbitrary because the page language is set from `APP_LANG`.
- **Lead**: the first paragraph after the title, clamped to 40ch so it sits on a
  shorter measure than the body column and registers as an opening. It is not
  meant to stack: at 34ch the sentence fell into four lines under the 44px
  display and read as a wrapping accident, and at 48ch it filled 88% of the
  narrowed column and stopped reading as a shorter measure at all. 40ch is 74%
  of the column and still three lines. Below the breakpoint the clamp is inert,
  so this is a desktop decision. The selector `h1 + p` is deliberately literal:
  a plain sentence in `APP_TEXT_LEAD` still gets the treatment, but text opening
  with a heading or a list does not match and gets none. That is correct — the
  lead is the *first sentence under the title*, not a slot the first block falls
  into whatever it is. Do not loosen it to `h1 + *`.
- **Label**: section heads (`h2`), set under the 2px rule. The signature mark.
- **Headline**: `h3`, the first heading that reads as a heading rather than a
  label, and the last with a size of its own.
- **Title** / **Title Quiet**: `h4` bold at body size, `h5` bold muted, `h6`
  medium muted.
- **Body**: everything else, with `text-wrap: pretty`.
- **Label Mono**: table heads and figure captions.
- **Code**: inline and block code, and footnote text at the same size in the
  sans face.

### Named Rules

**The Ruled Label Rule.** A section head sits directly beneath a full-width 2px
rule. The rule and the label are one unit: neither appears without the other.
The heavy rule appears in exactly two places — the section head and the table
head — and both carry an uppercase label, which is what makes the rule true
rather than aspirational; the footnote block, which the renderer gives no label,
takes a hairline instead. Inside one section the eye can meet both, a heavy
stripe roughly sixty pixels under another heavy stripe, and it reads as a
repeat. That is intended and it is what the rule costs: the fix is never to drop
the rule from one of the two places.

**The Tone-Not-Size Rule.** The type scale runs out of sizes before markdown
runs out of heading levels. `h3` is the last level with a size; below it depth
steps first in tone (Ink to Muted Ink at `h5`) and then in weight (700 to 500 at
`h6`), never in size. A future level does the same or does not exist.

**The Mono-Means-Machine Rule.** The monospace face marks code, table heads and
captions. Never body prose, a heading, or emphasis.

**The Counted Measure Rule.** A claim about line length is worth what the
counting method is worth. `ch` is the width of the digit zero, not a character
count, and in a proportional face it understates the real count — an earlier
pass read the column as "74ch" and shipped a line of 82 characters on that
reading. The measure is counted in the browser over the paragraph's actual text
nodes and held inside 45–75: at 40rem the first line ran 82 characters, at 34rem
it runs 75, at 30rem it would run 63. Change the column, count again; never
convert.

## Layout

A single centred column on a `min-height: 100vh` flex body that centres its
content vertically — the one declaration that serves both surfaces. There is a
single breakpoint, at the column width, which tightens page padding and shrinks
the display and lead sizes.

Vertical rhythm comes from the step scale in the frontmatter. The 0.25rem step
exists for one job — the task-list checkbox's right margin, where it lines a
task label up with the ordinary items beside it (measured: 0.37px residual, down
from 4px).

Sideways containment has two mechanisms, and which applies depends on the
element. `overflow-wrap: break-word` on `body` plus `min-width: 0` on the column
handles text: a bare URL or long identifier breaks instead of widening the page.
It cannot handle a table, because a cell never shrinks below its longest word —
six columns at 390px pushed the document 530px sideways. So `pre` and `table`
are both scroll containers (`table` is `display: block` with `overflow-x: auto`)
and absorb the overflow inside the block. A wrapped command line would be a
wrong command line, and a wrapped table an unreadable one.

**Known limit.** Both scroll containers happen to be reachable by keyboard in
Chromium, which makes a scrollable region focusable on its own (measured:
`pre.chroma` is a tab stop with a visible ring). That is browser behaviour, not
a guarantee. Neither carries `tabindex="0"`, because markdown cannot set an
attribute and the page carries no JavaScript.

### Named Rules

**The Unbreakable Column Rule.** Nothing an operator writes may push the
document sideways. Text wraps or breaks; anything with an internal minimum width
of its own becomes its own scroll container. A new block picks one of the two
mechanisms deliberately, because the body-level wrap rule silently fails to
cover the second kind.

**The Both-Modes Rule.** Every layout rule is checked against both surfaces —
the two-line placeholder and the full markdown page. A rule that only looks
right on one of them is not a rule yet.

## Elevation & Depth

There are no shadows anywhere in this system, and none may be added. Depth is
tonal and linear only: a code block recedes onto a darker surface, a note steps
forward with a warm tint, structure is drawn with two line weights. There is
also no motion — no transitions, no transforms, no animation, on any state.

### Named Rules

**The Two Weights Rule.** Every line is either the 2px structural rule or the
1px hairline. A third weight, a dashed line or a coloured border is not part of
the vocabulary.

**The Tint-Once Rule.** A tinted surface does not nest inside a tinted surface.
A quote inside a quote drops the tint for a hairline stripe; anything deeper
does the same rather than stacking washes.

## Shapes

Every corner is square, and there is no radius token because there is no radius.
Form language is horizontal: full-width rules segmenting the column, full-width
table row lines, full-bleed code and note panels running edge to edge with no
inset. The checkbox is the only drawn geometry and the only thing boxed on all
four sides.

## Components

There are no interactive components in this product — no buttons, inputs,
navigation or forms, by product constraint. Everything below is reachable from
both surfaces, because the branch in `app/index.html` chooses the *source* of
the text, not what the text may become.

### Section Head

The signature mark, used for `h2` and nothing else; the only element that draws
the heavy rule above a block. Reachable from both surfaces.

### Links

Underlined, thickening on hover — the state change is weight, never colour.
Footnote references and back-references drop the underline entirely: they are
digits and arrows, and an underline would read them as part of the sentence.

**Known limit.** A footnote reference is about 6×12px. WCAG 2.2 SC 2.5.8 exempts
targets inside a block of text, so this is an ergonomic note rather than a
conformance failure, and enlarging one would cost the inline set of the sentence
it sits in.

### Code

Inline code is unboxed — colour alone marks it — and inside a table cell it
reverts to body Ink so the cell does not read as a row of links.

### Note (blockquote)

A warm tint panel, explicitly borderless — the tint alone marks it.

### Table

The flush right edge takes two declarations, and the mechanism is worth stating
because for a while only half of it was there. `th:last-child, td:last-child`
zero the right padding *and* set `width: 100%`. Without the width the table was
flush only by accident: `display: block` makes the `<table>` a block box whose
internal grid sits in an anonymous table box at `width: auto`, which
shrink-wraps to its content — so `width: 100%` on the element sizes the block,
not the grid, and `min-width: 100%` does nothing (both measured). Before the
fix, a two-column table drew its grid across 100 of 544px while every `h2` rule
above and below ran the full width; after it, two columns fill the column at
both viewports and an over-wide table still scrolls inside itself.

**Known limit.** All remaining width lands in the last column, so a table ending
in a short value gets a wide final column. Distributing the slack needs
`table-layout: fixed`, which trades away content-driven column sizing — rejected
for that reason.

`demo/index.md`'s table happens to fill the column on its own content, which is
why the defect survived every visual pass. A fixture that happens to look
correct proves nothing; check a two-column table against the rules above and
below it.

### Figure and Caption

Images are block-level and unframed, with the caption below in mono uppercase.
An image shipped with the product carries the scheme itself — `demo/image.svg`
holds its own `prefers-color-scheme: dark` block, having otherwise been the
brightest object on the dark page, and a renderer ignoring the query falls back
to the light fills. An operator's own image is served as-is and cannot be
expected to do the same, so the page never assumes it will.

### Task List

A drawn checkbox, because the renderer emits the control `disabled` and a
disabled control ignores `accent-color`. The list marker is removed per item,
not per list, because an ordinary bullet may sit in the same list.

Under `forced-colors: active` the box returns to `appearance: auto`. Forced
colours discard `background-color`, the only thing separating a ticked box from
an empty one — verified by screenshot, both read as empty before. The system's
answer to forced colours is to hand the control back to the platform, not to
invent a second visual language for it.

### Disclosure

Raw HTML passes through the renderer, so `details`/`summary` is a usable idiom.
The native marker is tinted Ember and nothing else is styled — the native
triangle is the affordance.

### Footnotes

The collected notes sit below a hairline rather than the structural rule,
because the heavy rule always carries an uppercase label and the renderer emits
none here. The renderer's own `hr` is hidden so the line is not drawn twice.

### Focus and Selection

`:focus-visible` reuses the structural rule weight as a focus ring. Selection
paints Ember Ink with Paper as the text colour, so a dragged range is plainly
stronger than the browser default it replaces.

### Failed Template

The page answers with itself when it cannot render. A broken `{{` in a mounted
file fails the template; `docker/caddy/Caddyfile` catches it in `handle_errors`
and re-serves `/index.html`, and the branch in `app/index.html` is guarded with
`(eq (placeholder "http.error.status_code") "")` so the error route takes the
environment-variable path instead of re-rendering the file that just failed. The
guard is load-bearing and was proven so: without it the error route renders the
broken file again, fails again, and the visitor gets a zero-byte body. The
status stays 500 so the operator sees the failure.

### Named Rules

**The One Surface Rule.** The system has exactly one error surface, and it is
the environment-variable page. No separate error design, no apology copy, no
status number set in type, no warning glyph — the failed page *is* the
placeholder page. That is the only rendition consistent with never looking like
a maintenance screen, and it is why the guard on the branch, not a new template,
is where the work went.

**The Silent Default Rule.** The default surface carries none of the system's
marks — no rule, no uppercase label, no mono face, no accent — and that is
settled, not an oversight. A placeholder is allowed to look like almost nothing;
the restraint is the statement. Measured: that page loads three files and not
one of them is a font. Every mark is available the moment an operator writes
markdown into `APP_TEXT_LEAD`, and nothing is to be added to make the empty
state look designed.

## Do's and Don'ts

### Do:

- **Do** put every value in `app/tokens.css` and author it in OKLCH.
- **Do** style by element selector. The renderer emits no classes, so a rule
  needing a class works for hand-written markup and silently fails on the
  operator's page.
- **Do** define every colour in both scheme blocks. A token that exists in only
  one scheme is a bug.
- **Do** hand a control back to the platform (`appearance: auto`) when forced
  colours would strip what carries its state.
- **Do** ship any new font file inside the image and declare it with
  `@font-face` locally.
- **Do** escape anything an operator sets that is not meant to be markup.
- **Do** delete a token nothing consumes, and restore it the moment something
  consumes it again. Delete on the evidence of today's build and restore on the
  same evidence — neither move needs an apology.

### Don't:

- **Don't** add a box-shadow, a border-radius, a gradient, a transition or an
  animation. The sheet is flat and still.
- **Don't** fetch anything at runtime — no font CDN, no script, no image from
  another host. The page must render with the machine offline.
- **Don't** dress the default surface up with marks the operator did not ask
  for.
- **Don't** add a logo, wordmark or decorative image — the product has none by
  commitment, and the page's only mark is the ruled section label.
