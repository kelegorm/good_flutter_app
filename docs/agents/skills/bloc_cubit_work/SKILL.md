---
name: bloc-cubit-work
description: Use when the task requires creating, updating, or refactoring Bloc/Cubit-based feature code.
---

# Bloc Cubit Work

Apply consistent rules for day-to-day work with `Bloc` and `Cubit`.

## General Focus

- Keep `Bloc`/`Cubit` code readable and predictable.
- Keep transition logic explicit.
- Keep state contracts stable and easy to consume from UI.

## State Types

- Model states as either `enum` or `sealed` class families.
- Do not model feature state with ad-hoc mutable flags spread across unrelated objects.
- Keep state variants explicit and finite.

## Internal vs Outward State

- Treat internal processing state and outward emitted state as different levels of abstraction.
- Do not merge internal orchestration details into UI-facing emitted states.
- Keep emitted states focused on what consumers need to render or react to.
- Keep internal state focused on transition mechanics, intermediate steps, and control flow.
- Practical rule:
    - If a piece of data is needed only to drive transitions, keep it internal.
    - If a piece of data is needed by widgets or external subscribers, expose it through emitted
      state.

## Event Handlers and Stream Subscriptions

- Keep `on<Event>` handlers as explicit private named methods (for example `_onBootstrapStarted`).
- Distinguish between **wiring** (the `.listen` call) and **logic** (the event handler):
    - **Inlining Wiring**: Inline the `.listen()` call in the most appropriate lifecycle method (for
      example constructor, `initState`, or `onActivate`). Do not create `_startSub()` or `_init()`
      wrappers just for one subscription.
    - **Naming Handlers**: Always use a named private method for the handler (the callback), even if
      it just forwards a call. This makes the entry point semantic (e.g., `_onMidiEvent` instead of
      just passing `_midi.send`).
- For every stream subscription, store a dedicated `StreamSubscription` field. Prefere `late final`
  when initialized in the constructor.
- Always cancel all stored subscriptions in the bloc/cubit destruction lifecycle (`close`/
  `dispose`).

## File Organization

- Always place state class definitions and helper/support classes in separate `[name]_state.dart`
  files.
- Do not keep full state/helper class declarations inline inside `bloc` or `cubit` implementation
  files.
- Let the main `bloc`/`cubit` file export its related state/event files (when present), so feature
  code can import one entry file.

## Documentation

- Every app `Bloc`/`Cubit` class must have at least a short Dart doc comment.
- The first doc line must be one sentence that explains what the class is and what it controls.
- Keep this first sentence concise and immediately understandable.
- Add extra details only when needed, below a blank doc line.

Example:

```dart
/// Controls lesson session flow and publishes UI-ready training state.
///
/// Handles session bootstrap, answer validation, and transition between
/// warmup and active practice phases.
final class TrainingSessionCubit extends Cubit<TrainingSessionState> {
  // ...
}
```
