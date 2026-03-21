---
name: dart-architecture-boundaries
description: Write and refactor Dart code at app/screen architecture level with strict UI boundary and SOLID-oriented class design. Use when creating new classes, splitting large objects, or restructuring module responsibilities. Do not use for small local edits inside one existing class, tiny helper methods, or UI-only tweaks that do not introduce/reshape classes.
---

# Dart Architecture Boundaries

Apply this skill only for architecture-impacting Dart work: new classes, large-object refactoring,
and responsibility redistribution across layers.

Keep app logic and UI concerns separated:

- Keep app-level `Bloc`/`Cubit`, services, and use-case classes free from Flutter/UI dependencies.
- Avoid `BuildContext`, `Widget`, `context.router`, and `package:flutter/...` imports in app-level
  logic classes.
- Use absolute `package:` imports only. Do not use relative imports (`./`, `../`) in Dart code.
- Let UI layer adapt framework details and call app logic through explicit interfaces.

Apply SOLID as a design filter during changes:

- Split mixed-responsibility objects into focused classes.
- Depend on abstractions at boundaries (navigation, IO, platform services).
- Keep public APIs small, explicit, and test-friendly.
- Prefer constructor injection and composition over hidden global coupling.

For refactoring large classes:

1. Identify responsibilities and seams.
2. Extract one responsibility per class behind clear contracts.
3. Move framework-specific code to adapters in infra/UI-facing layer.
4. Keep behavior stable while reducing coupling.

Before finalizing, verify:

- New boundaries are clearer than before.
- App-level logic remains framework-agnostic Dart.
- Resulting classes are easier to reason about, test, and evolve.
