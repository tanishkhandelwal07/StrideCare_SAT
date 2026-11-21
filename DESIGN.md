# StrideCare design

The patient may be reading with one hand on a cane. Give each screen the pace of a printed recovery booklet. Name the section, put the most important sentence first, and leave room around it.

## Colour and type

All Flutter visual values live in `lib/design/tokens.dart`. The Material 3 theme and patient screens share these tokens.

| Role | Token | Use |
| --- | --- | --- |
| Page | #FAF6F0 | Warm paper background |
| Surface | #FFFFFF | Navigation and separate objects |
| Rule | #E8E0D4 | One logical pixel between sections |
| Primary | #1F5F5B | Brand, active destination, primary action |
| Accent | #D9822B | One small highlight per screen |
| Text | #2B2B2B | Headings and reading text |
| Muted | #6B645B | Supporting information |
| Alert | #C8503E | Marker alongside an explicit message |

Set sentence-case headings and large figures in Fraunces. Use Nunito Sans for body copy, with bundled Noto fallbacks for Devanagari and Gurmukhi. Use tabular figures in tables and charts. Body text starts at 17sp. The current screens follow the system text setting, including 200%. Let paragraphs wrap and scroll.

## Layout and interaction

- Give each page one dominant heading. Keep reading text left-aligned and limit its line length.
- Use thin dividers for lists. Reserve bordered white cards for distinct objects such as one prescription or one walk.
- Keep touch targets at least 56 logical pixels wide and tall. Give destinations visible labels and screen-reader names. Mark selection with a line, weight or shape as well as colour.
- Keep the five destinations reachable at large text sizes. Reflow labels without shrinking text.
- Prefer flat surfaces. Use at most two elevation levels. Avoid heavy shadows.
- Use a single outline icon family for controls. For meaningful illustrations, use a rounded two-pixel line and a restrained hand-drawn shape.
- When charts arrive, use direct labels, few gridlines, a quiet target band and a dot on the latest reading. Label speed as “estimated pace” and load as “cane load trend”.
- Keep motion brief. Allow 200–250 ms fades or slides, a ring filling once, and a gentle pulse during device search. Respect reduced motion. The foundation uses static pages.

## Copy

Use short sentences that tell the patient what happened or what will appear. Describe difficult days gently. Give errors a concrete next step. Use everyday dates and verbs for actions. Use the wellness reminder “Confirm with your doctor or physio.” Keep the same tone in English, Hindi and Punjabi. Mark translations awaiting native-speaker review in the ARB metadata.

## Avoid

- Gradients, glow, neon, glass, blurred panels and decorative animation.
- Rows of matching icon cards, centre-aligned reading text and symmetrical dashboard grids.
- Mixed icon families, emoji, confetti, bouncing controls and hover effects.
- Empty praise, marketing claims, decorative exclamation marks, invented activity figures and testimonials.
- Clinical certainty, shaming language and colour-only success or failure cues.
- Manual walk controls. The cane supplies the signals for automatic detection in the next phase.
