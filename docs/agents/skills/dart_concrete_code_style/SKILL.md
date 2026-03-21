---
name: dart-concrete-code-style
description: MANDATORY for any task touching Dart code (`*.dart`). Write and refactor concrete local Dart implementation code inside existing methods and functions. For architecture-level changes, use together with `dart_architecture_boundaries`.
---

# Dart Concrete Code Style

Apply a clean style for local Dart code.

## Variant Handling (`enum` and `sealed`)

### Rules

- Iterate variants with `switch`.
- Make branches explicit and exhaustive.
- Avoid long `if` and `else if` chains when checking the same state variant.
- Do not use `default` in such switches, name each variant explicitly.
- Use grouping for variants for same actions.
- For grouped variants, avoid `case A() || B()` in one dense line; prefer `switch` statement with
  stacked `case` lines for each variant.

### Minimal Refactoring Flow

1. Find places with `if` chains over `enum` or `sealed` variants.
2. Rewrite them as `switch` with explicit branches.
3. Reduce nesting with early exits.
4. Keep behavior unchanged and verify cases.

### Example

```dart
// Before:
if (state is Loading) {
return showLoading();
} else if (state is Data) {
return showData(state.value);
} else if (state is Error) {
return showError(state.message);
}


// After:
switch (state) {
case Loading():
return showLoading();
case Data(:final value):
return showData(value);
case Error(:final message):
return showError(message);
}
```

```dart
// Before:
builder: (context, state) => switch
(
state) {
BootstrapReady() => const AppShell(),
BootstrapLoading() || BootstrapError() => const BootstrapScreen(),
},

// After:
builder: (context, state) {
switch (state) {
case BootstrapReady():
return const AppShell();

case BootstrapLoading():
case BootstrapError():
return const BootstrapScreen();
}
},
```

## Local Readability Rules

- Use descriptive short names and avoid unclear abbreviations.
- Separate code lines with different intent by one blank line.
- Keep 2-3 lines that perform one single action together without extra blank lines.

## Callback and Handler Style

### Rules

- Use named methods for semantic entry points (for example button tap handlers and `on<Event>`
  handlers), even when the body is short.
- Keep trivial technical wiring inline when it is one obvious statement (for example one-line stream
  subscription setup).
- **Wiring vs Handler Distinction**:
    - Never extract a dedicated private method only for a single-line stream subscription statement.
      Inline it in the constructor, `initState`, or other appropriate lifecycle entry points.
    - **But** do use a named method for the callback passed to `.listen(...)` if it represents a
      meaningful event handler.
- Do not create wrapper methods whose body only forwards one call without adding meaning or
  behavior, **unless** they serve as a semantic entry point for an external event.
- Extract callback logic into a named method when it has branching, multiple side effects, reuse, or
  domain meaning.
- Always ensure every created subscription is eventually canceled.

**Example (Stream subscription in Cubit):**

```dart
// GOOD (inlined wiring, named handler)
MyCubit
() : super
(
Initial()) {
_sub = service.events.listen(_onEvent);
}
void _onEvent(Event e) => _process(e);

// BAD (wrapped wiring)
MyCubit() : super(Initial()) {
_init();
}
void _init() => _sub = service.events.listen((e) => _process(e)
);
```

## Function Scope and Size

### Rules

- Keep each function focused on one clear, simple responsibility.
- Extract methods by semantic boundary, not by line count.
- Prefer short functions that are easy to scan and understand quickly.
- If a function grows long or mixes multiple responsibilities, split it into smaller helper
  functions with explicit names.
- Extract coherent blocks of logic instead of keeping large mixed control flow in one place.

## Class Method Order

### Rules

1. Constructors first (unnamed/default first, then named constructors).
2. Overridden public/protected methods (`@override` methods).
3. Other public methods.
4. Private instance methods.
5. Private static methods at the end.

## File Splitting Style

### Rules

- When splitting Dart code into multiple files, prefer regular files with imports, do not use `part`
  and `part of` by default.
- Use `part` and `part of` only when technically required.
- Use absolute `package:` imports only. Do not use relative imports (`./`, `../`) in Dart code.

## Parameter Formatting (Methods, Functions, Constructors)

### Rules

- Allow inline parameters only for simple signatures:
    - few parameters,
    - short descriptive names,
    - no optional/named complexity.
- Use multiline named parameters for non-trivial signatures:
    - partially optional input,
    - many parameters,
    - mixed required and optional settings.
- If a function takes multiple parameters of the same type (especially `bool`, also `num` and
  `String`), prefer named parameters with `required` even for otherwise simple signatures to keep
  call sites unambiguous.
- In multiline named signatures, place one parameter per line inside `{}`.
- Mark mandatory named parameters with `required`.
- Keep a trailing comma after the last parameter in multiline signatures.
- Keep the same formatting policy for regular functions, class methods, and constructors.

### Examples

```dart
// Inline is fine for simple required params.
void sum(int a, int b, int c) {
  // body
}

// Same-type params should be named to avoid ambiguity at call sites.
void setFlags({
  required bool isEnabled,
  required bool useCache,
}) {
  // body
}

// Use multiline named params for partially optional/more complex input.
void someFunc({
  required Type1 param1,
  required Type2 param2,
  Type3 param3 = val3,
}) {
  // body
}

class SomeClass {
  SomeClass({
    required this.param1,
    required this.param2,
    this.param3 = val3,
  });

  final Type1 param1;
  final Type2 param2;
  final Type3 param3;
}
```
