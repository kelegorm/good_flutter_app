# good_example

A Flutter architecture reference template: `lib/{app, domain, data, ui}/` layering, flutter_bloc + auto_route, and a strict lint + per-layer purity-test gate.

## Where to start

- Agent skills index: [`docs/agents/index.md`](docs/agents/index.md).
- Operational notes and CI gates: [`AGENTS.md`](AGENTS.md).
- Architectural import rules and direction: top of [`analysis_options.yaml`](analysis_options.yaml). Enforced by the tests in [`test/architecture/`](test/architecture).
