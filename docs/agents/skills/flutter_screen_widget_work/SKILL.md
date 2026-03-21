---
name: flutter-screen-widget-work
description: MANDATORY for any task touching Flutter widgets/screens. Use when creating, updating, or refactoring Flutter screens and large composite widgets.
---

# Flutter Screen Widget Work

Apply consistent rules for Flutter screens and large state-driven widgets.

## State-Driven Rendering

### Rules

- Keep state-to-UI mapping explicit with `switch`.
- For multi-branch UI state handling, keep each branch minimal and delegate UI to named private
  methods.
- Prefer branch methods like `_buildReady`, `_buildLoading`, `_buildError` instead of large inline
  widget trees.
- Keep branch body to one clear return/delegation whenever possible.
- Prefer `Widget` as the return type for builder helpers like `_buildSmth`, unless a
  more specific widget type is required for a clear code reason.
- Any on-screen text must follow `UI Strings` usage rules from
  `.agent/skills/flutter_ui_strings_usage/SKILL.md`.

## Widget Method Order

### Rules

- In widget/state class bodies, place overridden widget lifecycle methods first.
- Keep lifecycle overrides in lifecycle order, with one layout exception: keep `build` as the last
  method in the lifecycle block.
- Right after `build`, place private `Widget` build helpers (`_build...`).
- After build helpers, place remaining private methods (handlers/mappers/utilities).
- Widgets usually should not expose extra public methods beyond widget/state interface overrides.

## Widget File Organization

### Rules

- Keep one widget per file; avoid accumulating multiple unrelated widgets in a single Dart file.
- Place reusable system-wide widgets in shared folders (for this project, `lib/components/`).
- Place feature/screen-local widgets next to the owning screen/feature (for example, under
  `lib/features/<feature>/components/` or inside the screen folder).
- Promote a local widget to shared only when it is reused across multiple features/screens.

## Navigation

### Rules

- Handle navigation through `Bloc`/`Cubit`.
- Do not call router/navigation APIs directly from screens/widgets.
- Do not trigger direct `Navigator`/router transitions from UI event handlers.
- Exception: local popup UI actions (dialogs, bottom sheets, snackbars, and similar popup elements).

## BlocProvider Initialization

### Rules

- В `BlocProvider` задай `lazy: false`, чтобы `Bloc`/`Cubit` предсказуемо создавался сразу же.

## Growth Template (Add New Sections Here)

When adding new principles, use this format:

### [New Principle Title]

- Scope: where this rule applies.
- Rule: what to do.
- Rationale: why this helps readability/maintenance.
- Example: short before/after snippet.

Suggested next section slots:

- Widget composition and extraction boundaries.
- Screen lifecycle and side effects.
- Stream/listener setup and teardown in widgets.
- Navigation and action wiring from UI state.
- Screen/widget documentation conventions.
