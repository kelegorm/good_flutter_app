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
