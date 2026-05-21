# Good Example — Flutter Architecture Reference

## Skills

Before starting any task, check the skills index for relevant guidelines:
@docs/agents/index.md

## Design System

All UI must be built exclusively through the design system located in `lib/ui/design_system/`.

**Never hardcode:**
- Numbers for spacing or padding — use `AppSpacing` (`AppSpacing.md`, `AppSpacing.xl`, etc.)
- Numbers for dimensions — use `AppDimens` (`AppDimens.maxContentWidth`, etc.)
- Colors — use `AppColors` or let the theme handle it via components
- Text styles — use `AppHeadline`, `AppBodyText`, etc. Never call `Theme.of(context).textTheme.*` directly in screens
- `ThemeData(...)` inline — use `AppTheme.light()`

**Always use design system components:**
- Primary action button → `AppPrimaryButton`
- Secondary action button → `AppSecondaryButton`
- Screen title / header → `AppHeadline`
- Descriptive text → `AppBodyText`

When adding new UI patterns, add a component to `lib/ui/design_system/components/` first, then use it in the screen.

## CI Gates

After any change to `lib/`, before declaring the task done you **must** run all three commands and all three **must** pass cleanly (no new issues, no failing tests):

```bash
flutter analyze --no-pub
flutter test --no-pub
dart run dart_code_linter:metrics analyze lib 2>&1 | tee /tmp/dcl.out; ! grep -qE '^(ERROR|WARNING)' /tmp/dcl.out
```

The third command runs `dart_code_linter` (DCL) for rules that core Dart lints don't ship — notably `avoid-non-null-assertion` (the `!` ban). DCL's CLI doesn't return a non-zero exit on violations in this version, so we grep the output: any `ERROR` or `WARNING` line fails the gate.

`flutter test --no-pub` includes the architectural purity tests in `test/architecture/`. Those tests are the canonical enforcement for the layer rules described in `analysis_options.yaml` (allowed externals per layer, no cross-screen UI imports). When you add a new external dependency under `lib/ex_systems/` or `lib/ui/`, update the corresponding allowlist in `test/architecture/ex_systems_purity_test.dart` or `test/architecture/ui_purity_test.dart`.

Do not announce work as finished if any of the three commands reports new issues or failures.
