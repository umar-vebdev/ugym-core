# uCraft Design System 1.1
## Midnight & Cobalt — uGym Ecosystem

**Status:** Approved design specification (v1.0 + v1.1 UX and Layout Addendum, Sections 25–33)  
**Products:** uGym, uGym Business  
**Design language:** Modern, minimal, precise, calm, premium  
**Primary platforms:** Android and iOS  
**Default appearance:** Light theme  
**Supported appearances:** Light and Dark  
**Design system owner:** uCraft

---

# 1. Core Principles

All interfaces must follow these principles:

1. **Clarity over decoration.** Every element must have a clear functional purpose.
2. **Consistency over novelty.** Reuse existing tokens, components, spacing and interaction patterns.
3. **Calm confidence.** Avoid excessive gradients, saturated surfaces, decorative shadows and unnecessary animations.
4. **Functional minimalism.** Reduce visual noise without sacrificing discoverability.
5. **Accessible by default.** Maintain readable contrast, accessible touch targets and clear focus states.
6. **One ecosystem, two experiences.** Both applications share a visual language but may use different navigation structures and feature-specific components.

Never invent new colors, font sizes, spacing values, corner radii or visual styles when an existing token is applicable.

---

# 2. Brand Colors

These are the canonical brand colors.

| Token | HEX | Purpose |
|---|---|---|
| Cobalt | `#507DE8` | Primary brand accent |
| Cobalt Dark | `#3563CC` | Light-theme interactive controls |
| Cobalt Deep | `#244DA8` | Strong emphasis |
| Cobalt Light | `#EAF0FF` | Subtle accent surfaces |
| Midnight | `#111827` | Primary dark background |
| Slate | `#1F2937` | Elevated dark surfaces |
| Slate Light | `#374151` | Dark borders and separators |
| Snow | `#F9FAFB` | Primary light background |
| White | `#FFFFFF` | Light cards and surfaces |
| Muted Gray | `#9CA3AF` | Secondary dark-theme text |

Cobalt is the primary brand color. It must not be replaced with generic Material blue.

The darker Cobalt variant is used for small interactive elements in the light theme to improve contrast.

---

# 3. Semantic Color Tokens

Use semantic tokens in application code. Never reference raw HEX values directly inside screens or reusable widgets.

## 3.1 Light Theme

| Semantic token | HEX |
|---|---|
| background | `#F9FAFB` |
| surface | `#FFFFFF` |
| surfaceSecondary | `#F3F4F6` |
| surfaceTertiary | `#E5E7EB` |
| foreground | `#111827` |
| foregroundSecondary | `#4B5563` |
| foregroundMuted | `#6B7280` |
| border | `#E5E7EB` |
| borderStrong | `#D1D5DB` |
| primary | `#3563CC` |
| primaryHover | `#244DA8` |
| primaryPressed | `#1D408D` |
| primarySubtle | `#EAF0FF` |
| onPrimary | `#FFFFFF` |
| accent | `#507DE8` |
| focusRing | `#3563CC` |
| disabledBackground | `#E5E7EB` |
| disabledForeground | `#6B7280` |
| overlay | `#111827` at 48% opacity |

## 3.2 Dark Theme

| Semantic token | HEX |
|---|---|
| background | `#111827` |
| surface | `#1F2937` |
| surfaceSecondary | `#273244` |
| surfaceTertiary | `#374151` |
| foreground | `#F9FAFB` |
| foregroundSecondary | `#D1D5DB` |
| foregroundMuted | `#9CA3AF` |
| border | `#374151` |
| borderStrong | `#4B5563` |
| primary | `#82A5FF` |
| primaryHover | `#A6BEFF` |
| primaryPressed | `#668BE8` |
| primarySubtle | `#243554` |
| onPrimary | `#111827` |
| accent | `#507DE8` |
| focusRing | `#A6BEFF` |
| disabledBackground | `#374151` |
| disabledForeground | `#9CA3AF` |
| overlay | `#000000` at 60% opacity |

Dark theme must use layered dark surfaces rather than pure black.

---

# 4. Status Colors

## Success

| Token | Light | Dark |
|---|---|---|
| success | `#15803D` | `#4ADE80` |
| successBackground | `#DCFCE7` | `#143D2B` |
| successForeground | `#166534` | `#86EFAC` |

## Warning

| Token | Light | Dark |
|---|---|---|
| warning | `#A16207` | `#FBBF24` |
| warningBackground | `#FEF3C7` | `#453316` |
| warningForeground | `#854D0E` | `#FDE68A` |

## Destructive / Error

| Token | Light | Dark |
|---|---|---|
| destructive | `#B91C1C` | `#F87171` |
| destructiveBackground | `#FEE2E2` | `#4A2026` |
| destructiveForeground | `#991B1B` | `#FCA5A5` |

## Information

| Token | Light | Dark |
|---|---|---|
| info | `#1D4ED8` | `#93C5FD` |
| infoBackground | `#DBEAFE` | `#1E3558` |
| infoForeground | `#1E40AF` | `#BFDBFE` |

Status colors must communicate actual application states.

Do not use success green as an alternative brand accent.

Never communicate status through color alone. Include text or a relevant icon.

---

# 5. Typography

## Font Families

**Primary:** Inter  
**Technical / numeric secondary:** Geist Mono

Fallbacks:
- Android: Roboto
- iOS: system sans-serif

Use Inter for all primary application UI.

Use Geist Mono selectively for identifiers, QR-related codes, technical details and tabular numbers.

## Typography Scale

| Style | Size | Weight | Line Height |
|---|---|---|---|
| Display | 32sp | 700 | 40sp |
| Headline Large | 28sp | 700 | 36sp |
| Headline | 24sp | 650 | 32sp |
| Title Large | 20sp | 600 | 28sp |
| Title | 18sp | 600 | 26sp |
| Body Large | 16sp | 400 | 24sp |
| Body | 14sp | 400 | 21sp |
| Body Medium | 14sp | 500 | 21sp |
| Label | 13sp | 600 | 18sp |
| Caption | 12sp | 400 | 17sp |
| Overline | 11sp | 600 | 16sp |

Use framework-supported font weights closest to the specified values when necessary.

Respect operating-system text scaling. Do not force a fixed global text scale.

Avoid uppercase body text. Uppercase may be used for short overlines and category labels.

---

# 6. Spacing System

Use a 4-point spacing grid.

| Token | Value |
|---|---|
| space0 | 0 |
| space1 | 4 |
| space2 | 8 |
| space3 | 12 |
| space4 | 16 |
| space5 | 20 |
| space6 | 24 |
| space8 | 32 |
| space10 | 40 |
| space12 | 48 |
| space16 | 64 |

Default spacing rules:

- Screen horizontal padding: 20
- Compact screen padding: 16
- Card internal padding: 16
- Card-to-card spacing: 12
- Section spacing: 24
- Major section spacing: 32
- Form field spacing: 16
- Icon-to-label spacing: 8
- Button horizontal padding: 16

All spacing values are logical pixels / density-independent units.

---

# 7. Corner Radius

| Token | Value | Usage |
|---|---|---|
| radiusXs | 4 | Tiny indicators |
| radiusSm | 8 | Buttons, text fields |
| radiusMd | 12 | Cards, list containers |
| radiusLg | 16 | Dialogs, large cards |
| radiusXl | 20 | Bottom sheets |
| radius2xl | 24 | Hero panels |
| radiusFull | 999 | Pills, avatars |

Do not use excessively rounded cards throughout the application.

---

# 8. Borders and Elevation

Prefer borders and surface contrast over heavy shadows.

## Borders

- Default width: 1dp
- Strong border: 1.5dp
- Focus border: 2dp
- Divider width: 1dp

## Shadows

### Elevation 0
No shadow.

### Elevation 1
- Y offset: 2
- Blur: 8
- Opacity: 5%

### Elevation 2
- Y offset: 6
- Blur: 20
- Opacity: 8%

### Elevation 3
- Y offset: 12
- Blur: 32
- Opacity: 12%

Use elevation 0 for most cards.

Use elevation 2 or 3 only for floating menus, dialogs and temporary overlays.

In dark theme, prefer surface layering to shadows.

---

# 9. Iconography

Use **Lucide** icons as the default icon family.

Rules:

- Default icon size: 20dp
- Small: 16dp
- Large: 24dp
- Navigation icons: 24dp
- Stroke width: approximately 2
- Consistent outline style
- No mixing filled and outlined icons without a functional reason

Use filled or strongly highlighted states only for active navigation or meaningful selection.

Do not use emoji as production UI icons.

---

# 10. Buttons

## Primary Button

- Height: 48dp
- Minimum touch target: 48 × 48dp
- Radius: 8dp
- Background: `primary`
- Text: `onPrimary`
- Font: 14sp, weight 600
- Horizontal padding: 16dp

## Secondary Button

- Height: 48dp
- Radius: 8dp
- Background: `surface`
- Border: `borderStrong`
- Text: `foreground`

## Tertiary Button

- Height: 44dp
- Transparent background
- Text: `primary`
- No border

## Destructive Button

- Height: 48dp
- Background: `destructive`
- Text color: theme-specific high-contrast foreground
- Require confirmation for irreversible destructive actions

## Button States

Every button must support:

- Default
- Pressed
- Focused
- Disabled
- Loading

Loading must prevent duplicate submissions.

Disabled buttons must not respond to user interaction.

Use a visible loading indicator and preserve button width during loading.

---

# 11. Form Controls

## Text Fields

- Minimum height: 52dp
- Radius: 8dp
- Background: `surface`
- Border: `border`
- Horizontal padding: 14dp
- Label above field: 13sp, weight 600
- Input text: 16sp
- Helper text: 12sp

### States

- Default
- Focused
- Filled
- Disabled
- Read-only
- Error
- Success, where relevant

Validation errors must appear below the field with a descriptive message.

Never rely only on a red border to communicate an error.

## Other Controls

Use consistent tokens for:

- Checkboxes
- Radio buttons
- Switches
- Search fields
- Dropdowns
- Date and time pickers
- Segmented controls
- Sliders

Use native platform behavior where it materially improves usability, accessibility or reliability.

---

# 12. Cards

## Standard Card

- Background: `surface`
- Radius: 12dp
- Padding: 16dp
- Border: 1dp `border`
- Elevation: 0

## Interactive Card

- Same visual properties
- Visible pressed state
- Entire intended card area clickable
- Minimum interactive target: 48dp

## Highlight Card

- Background: `primarySubtle`
- Radius: 16dp
- Padding: 20dp
- No gradient by default

Use highlight cards sparingly for important product-specific content.

---

# 13. Navigation

## uGym — Member App

Use bottom navigation for 3–5 primary destinations.

Recommended structure:

1. Home
2. Clubs
3. Memberships
4. Activity
5. Profile

Navigation height should respect system safe areas.

Selected items must have a visible icon and label state.

## uGym Business

Use a role-aware navigation structure.

Recommended primary destinations:

1. Overview
2. Members
3. Operations
4. Analytics
5. More

Subsections may include:

- Membership plans
- Payments
- Visits
- Staff
- Schedules
- Club settings

The actual destinations must reflect backend capabilities and user permissions.

Do not show inaccessible actions as if they are available.

For tablets and larger screens, prefer a navigation rail or sidebar when appropriate.

---

# 14. App-Specific Design Rules

## uGym

Audience: fitness-club visitors.

Visual characteristics:

- Clear personal dashboard
- Membership status prominently displayed
- Fast access to QR/check-in
- Simple club discovery
- Readable schedules
- Minimal interaction steps
- Friendly but restrained presentation

Prioritize immediate access to active memberships and relevant actions.

## uGym Business

Audience: club owners, managers, administrators and staff.

Visual characteristics:

- Higher information density
- Clear KPI hierarchy
- Efficient data tables and lists
- Filters and search
- Explicit status indicators
- Reliable form workflows
- Confirmation for sensitive operations

Prioritize operational efficiency over decorative presentation.

Use the same colors, typography and component tokens as uGym.

---

# 15. Data Visualization

Use restrained, accessible charts.

Rules:

- Primary series: `primary`
- Positive states: `success`
- Negative states: `destructive`
- Warning thresholds: `warning`
- Neutral grid lines: `border`
- Axis labels: `foregroundSecondary`

Use text labels, legends and accessible descriptions.

Never rely on color alone to distinguish data series.

Do not fabricate chart values, trends or metrics.

Show empty states when data is unavailable.

---

# 16. Loading, Empty and Error States

Every asynchronous screen must explicitly support:

1. Initial loading
2. Content
3. Empty state
4. Recoverable error
5. Permission-denied state, where applicable

## Loading

Use skeleton placeholders for content-heavy screens.

Use compact progress indicators for short actions.

Avoid blocking the entire application unnecessarily.

## Empty State

Include:

- Relevant icon or simple illustration
- Clear title
- Brief explanation
- Primary action, if available

## Error State

Include:

- Plain-language explanation
- Retry action where appropriate
- No exposure of internal stack traces

Do not display success until the operation has actually succeeded.

---

# 17. Motion and Animation

Motion should be functional, not decorative.

| Animation | Duration |
|---|---|
| Button feedback | 100ms |
| Small transitions | 150ms |
| Standard transitions | 200ms |
| Screen transitions | 250ms |
| Bottom sheet | 300ms |

Use ease-out for entrances and ease-in for exits.

Avoid unnecessary bounce, elastic effects and continuous animation.

Respect reduced-motion accessibility settings.

---

# 18. Responsive Layout

## Breakpoints

- Compact: below 600dp
- Medium: 600–839dp
- Expanded: 840dp and above

Use responsive constraints rather than assuming fixed device sizes.

For compact screens:

- Single-column layouts
- Bottom navigation
- Full-width primary actions
- 16–20dp horizontal padding

For medium and expanded screens:

- Navigation rail or sidebar
- Multi-column layouts where useful
- Maximum readable content width
- Adaptive dialogs and panels

Respect safe areas, keyboard insets and display cutouts.

---

# 19. Accessibility

Mandatory requirements:

- Target WCAG 2.2 AA where applicable.
- Normal text contrast: at least 4.5:1.
- Large text contrast: at least 3:1.
- Meaningful UI component boundaries and indicators: at least 3:1 against adjacent colors.
- Interactive touch targets: aim for at least 48 × 48dp.
- Support screen readers.
- Provide accessible labels for icon-only buttons.
- Support dynamic text sizing.
- Respect reduced-motion preferences.
- Never communicate important information through color alone.
- Ensure forms remain usable with the keyboard and assistive technologies.

Validate actual rendered contrast for every component state.

---

# 20. Localization

Initial supported locales:

- Russian: `ru`
- English: `en`
- Tajik: `tg`

Use localization keys for all user-facing text.

Do not hardcode text inside reusable components.

Support:

- Locale-specific dates
- Locale-specific numbers
- Currency formatting
- Time zones
- Pluralization
- Long translated strings

Do not assume every translated label fits on one line.

---

# 21. Component Architecture

Organize the shared design system into these layers:

```text
design_system/
├── tokens/
│   ├── colors
│   ├── typography
│   ├── spacing
│   ├── radius
│   ├── elevation
│   └── motion
│
├── themes/
│   ├── light
│   └── dark
│
├── components/
│   ├── buttons
│   ├── inputs
│   ├── cards
│   ├── navigation
│   ├── dialogs
│   ├── feedback
│   └── data_display
│
└── patterns/
    ├── forms
    ├── dashboards
    ├── lists
    └── empty_states
```

The exact filenames and extensions depend on the chosen implementation framework.

Keep design-system code independent from product-specific business logic.

---

# 22. Implementation Rules for AI Agents

These rules are mandatory.

1. Use the design-system tokens defined in this document.
2. Never introduce arbitrary HEX colors.
3. Never introduce arbitrary spacing or radius values.
4. Reuse existing components before creating new ones.
5. Use semantic colors rather than raw brand colors for application surfaces and controls.
6. Implement light and dark themes.
7. Use light theme as the initial default unless the user has explicitly selected another theme.
8. Persist the user's theme preference.
9. Support system theme selection as an explicit setting.
10. Respect accessibility and localization requirements.
11. Use real backend data when API integration is available.
12. Never invent API endpoints, response schemas or business rules.
13. Do not display fabricated business metrics in production screens.
14. Do not expose restricted business actions to unauthorized users.
15. Use consistent loading, error and empty states.
16. Keep both applications visually related without making their interfaces identical.
17. Do not add gradients, glassmorphism, neon effects or decorative animations unless explicitly requested.
18. Do not replace Inter, Lucide or the canonical palette without approval.
19. Test components in both themes and across supported screen sizes.
20. If a design decision is not specified, derive it from the closest existing component and established tokens rather than creating a new visual language.

---

# 23. Definition of Done

A screen is complete only when:

- It uses the correct design tokens.
- It works in light and dark themes.
- It supports compact mobile screens.
- It handles loading, empty and error states.
- It supports localization.
- It has accessible labels and interaction targets.
- It follows the correct product navigation.
- It uses backend permissions and real data correctly.
- It has no unexplained hardcoded visual values.
- It has been checked for visual consistency with existing screens.

---

# 24. Brand Identity Summary

**Studio:** uCraft  
**Products:** uGym, uGym Business  
**Design system:** uCraft Design System 1.1  
**Visual language:** Midnight & Cobalt  
**Primary font:** Inter  
**Technical font:** Geist Mono  
**Icons:** Lucide  
**Primary accent:** `#507DE8`  
**Light background:** `#F9FAFB`  
**Dark background:** `#111827`  
**Component philosophy:** Minimal, functional, consistent, accessible

**Final instruction:** Build every screen as part of one coherent product ecosystem. Do not independently redesign components or reinterpret the established visual identity.

---

# uCraft Design System 1.1 — UX and Layout Addendum

**Status:** Approved addendum to uCraft Design System 1.0
**Applies to:** uGym, uGym Business
**Scope:** layout, hierarchy, component composition, screen patterns, interaction
**Precedence:** Section 1–24 of v1.0 remain fully in force. This addendum only adds
composition rules. It does NOT change any token (colors, typography, spacing, radius,
elevation, motion, icons, fonts). If this addendum and v1.0 conflict on a token value,
v1.0 wins.

Terminology used below:
- **Visual hierarchy**: the order in which the eye reads a screen, created by size,
  weight, position and contrast. Not by decoration.
- **Hero element**: the single most important block on a screen.
- **Skeleton**: a gray placeholder shaped like the content while data loads.

---

# 25. Why this addendum exists

v1.0 defines correct tokens, but screens built from it tend to look flat because every
element gets equal weight: identical bordered cards, accent color spread everywhere,
no clear first read. This addendum fixes hierarchy and rhythm without adding any new
visual language.

---

# 26. Screen Composition Rules

1. **One hero element per screen.** Exactly one block is visually dominant
   (for uGym Home: the active membership card). Everything else is secondary.
2. **One primary action per screen.** Exactly one Primary Button is visible at a time.
   All other actions use Secondary or Tertiary buttons.
3. **Hierarchy through size and weight first, color second.** Use the typography scale
   (Headline, Title, Body, Caption) to rank content. Reserve `primary` color for
   actions, links and the active navigation item only.
4. **Cards only for important or grouped objects.** Do not wrap every item in a card.
   Repeated items (schedules, visits, members, payments) are rendered as list rows with
   1dp `border` dividers, not as stacked bordered cards.
5. **Consistent vertical rhythm.** Between sections use space6 (24). Inside a section
   use space3 (12). Between a section title and its content use space1–space2 (4–8).
   Screen horizontal padding is space5 (20).
6. **Content order on every screen:** greeting or title → hero element → primary action
   → secondary sections → navigation. Do not reorder per screen.
7. **Maximum three levels of visual weight** per screen: hero, section content,
   supporting metadata.
8. **Whitespace is a feature.** Do not fill empty space with extra cards, banners or
   decorative blocks.

---

# 27. Component Composition Rules

## 27.1 Highlight (hero) card
- Background `primarySubtle`, radius radiusLg (16), padding space5 (20), elevation 0.
- Contains in order: overline label, title (Title Large), subtitle (Body, `foregroundSecondary`),
  progress or key metric, one line of supporting meta (Caption).
- Status shown as a pill (see 27.3), top-right of the card.
- No gradients, no illustrations by default.

## 27.2 List rows
- Row padding: space3 (12) vertical, 0 horizontal inside the screen padding.
- Divider: 1dp `border` between rows, none after the last row.
- Row structure: leading element (time, icon or avatar) → primary text (Body Medium) with
  secondary text below (Caption, `foregroundMuted`) → trailing meta (Caption) or chevron.
- Entire row is tappable with a visible pressed state and minimum height 48dp.
- Leading time or numeric columns use Geist Mono with tabular numbers and a fixed
  width of space12 (48) so columns align.

## 27.3 Status pill
- Radius radiusFull, horizontal padding space2–space3, text Label or Caption weight 500–600.
- Colors come only from status tokens (successBackground + successForeground, etc.).
- Always icon + text. Never color alone. Icons: Lucide, 16dp.

## 27.4 Progress indicator
- Track: `borderStrong`. Fill: `primary`. Height space2 (8), radius radiusFull.
- Always accompanied by a text label with the real value (for example remaining days).
- Never display a progress value that is not calculated from real data.

## 27.5 Buttons in context
- The primary action is full width on compact screens and sits directly below the hero element.
- Secondary and tertiary actions are placed below or inside sections, never competing
  with the primary button in the same row unless it is a two-button dialog footer.
- Button label: verb first, 1–3 words, sentence case, no trailing punctuation
  (examples: "Show QR code", "Renew membership", "Mark visit").

## 27.6 Section header
- Title (Title) on the left, optional Tertiary action ("See all") on the right,
  baseline-aligned. Section spacing space6 (24) above.

## 27.7 Bottom navigation (uGym)
- 5 destinations, each icon 24dp + label Overline-size or Caption weight 500.
- Active item: `primary` icon and label. Inactive: `foregroundMuted`.
- Background `surface`, 1dp `border` top divider, respects safe area.
- Height: space16 (64) plus system inset.

---

# 28. Numeric and Data Display

- Times, counts, codes, prices and identifiers use Geist Mono with tabular figures.
- Format using locale rules (dates, numbers, currency) from section 20.
- Large single metrics: Headline or Title Large, with a Caption label above or below.
- Never show placeholder or invented numbers. If data is missing, show the empty state.

---

# 29. Screen Specifications

## 29.1 uGym — Home (member app)
Order from top to bottom:
1. Header row: greeting (Caption, `foregroundMuted`) above user name (Headline),
   avatar (space10 = 40dp, radiusFull, `primarySubtle` background) on the right.
2. Hero: active membership card (27.1) showing plan name, club name, status pill,
   progress bar, remaining days label, end date.
3. Primary action: full-width Primary Button "Show QR code" with Lucide `qr-code` icon.
4. Section "Today at your club": list rows (27.2) with time (mono), class name,
   room and trainer, remaining spots. Tertiary action "All".
5. Bottom navigation.

Edge cases:
- No active membership: hero becomes an empty state with a primary action
  "Choose a plan". The QR button is hidden, not disabled.
- Expired membership: status pill uses warning or destructive tokens with text;
  primary action becomes "Renew membership".
- Multiple memberships: hero shows the most relevant one; a Tertiary action
  "All memberships" leads to the Memberships tab.

## 29.2 uGym Business — Overview
Order from top to bottom (compact):
1. Header: club name and role-aware context switcher (if the user has several clubs).
2. KPI strip: 2–3 metrics maximum, real data only
   (for example visits today, active memberships, revenue today). Each metric is a
   Caption label plus Headline value; no charts inside the strip.
3. Primary action: "Mark visit" (or the most frequent staff action, based on role),
   reachable from every Overview state.
4. Search field and filter control on one row.
5. Recent visits or members as list rows (27.2) with explicit status pills.
6. Role-aware navigation (section 13).

Tables on medium and expanded screens:
- Sticky header row, sortable columns where the backend supports it.
- Row actions in an overflow menu (Lucide `more-horizontal`), not as multiple inline buttons.
- Destructive or sensitive actions always require confirmation (section 10).
- Do not show actions the user lacks permission for.

---

# 30. Interaction and Feedback

- Every tappable element shows a pressed state within 100ms.
- Prefer skeletons over full-screen spinners for content-heavy lists and cards.
- Pull-to-refresh on list and dashboard screens where data can change.
- After an action succeeds, confirm with a short snackbar or inline state change.
  Never confirm before the backend confirms.
- Errors: plain-language message, a retry action, no technical details.
- Keep transitions within the durations in section 17. No decorative animation.
- Use platform haptics only for meaningful confirmations (for example successful check-in).

---

# 31. Copy Rules for UI Text

- Sentence case for buttons, headings, tabs and labels.
- No terminal punctuation on labels and headings. Helper text ends with a period.
- Verb-first buttons, no "OK" or "Submit" when a specific verb fits.
- Empty states are an invitation: headline names the space, one line explains, one verb button.
- Error format: what happened, then what to do. No "Error:" prefix.
- All strings go through localization keys (ru, en, tg). Allow 30–40% longer text.

---

# 32. Additional Rules for AI Agents

These extend section 22.

1. Before building a screen, identify its single hero element and single primary action.
2. Render repeated items as list rows, not stacked bordered cards.
3. Use only existing tokens. If a value is needed that has no token (for example a
   progress bar height), map it to the nearest existing spacing token.
4. Do not introduce new components when a composition of existing ones works.
5. Always provide loading (skeleton), empty, error and permission-denied states.
6. Use real data and real permissions. Never invent endpoints, fields or metrics.
7. Verify every screen in light and dark themes and with large system text sizes.
8. Do not add gradients, shadows beyond section 8, emoji icons, or decorative motion.
9. When a design decision is unspecified, follow the closest pattern in this addendum
   or in v1.0, and state the assumption in the pull request description.

---

# 33. Definition of Done (additions)

A screen is complete only if, in addition to section 23:

- It has exactly one hero element and exactly one visible primary action.
- Repeated content is rendered as list rows with dividers.
- Vertical rhythm follows section 26 (24 between sections, 12 within).
- Statuses are shown with icon and text, never color alone.
- Numeric values use Geist Mono with tabular figures and locale formatting.
- Every empty, loading and error state has been implemented and visually checked.
