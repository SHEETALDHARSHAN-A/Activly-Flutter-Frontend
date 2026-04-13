# Flutter Architecture Rules for Activly

## Purpose
Keep the app maintainable by splitting UI and state into clear feature boundaries while preserving behavior and visual output.

## Core Principles

### SOLID
- **Single Responsibility**: each file should own one primary concern (types, constants, shell orchestration, auth flow, landing flow, shared widgets, painters).
- **Open/Closed**: extend behavior by adding files in feature/shared folders, not by bloating existing screens.
- **Liskov Substitution**: keep widget contracts stable when refactoring (constructor arguments and semantics must remain compatible).
- **Interface Segregation**: use focused callback typedefs and small widget APIs instead of broad multi-purpose interfaces.
- **Dependency Inversion**: feature screens depend on abstractions/callbacks and core models, not direct cross-feature internals.

### KISS
- Prefer straightforward widget composition over deep abstraction layers.
- Keep existing names and flows unless a rename is required for correctness.
- Reuse existing shared widgets before creating new ones.

## Feature Boundaries
- `lib/app/core/types/`: enums, typedefs, shared low-level types.
- `lib/app/core/models/`: immutable data models and copy structures.
- `lib/app/core/constants/`: constants and static maps (translations, asset lists, durations).
- `lib/app/features/shell/`: app shell orchestration, page switching, global flow state.
- `lib/app/features/landing/`: landing page-specific UI and transitions.
- `lib/app/features/auth/`: auth step flow, forms, OTP/reset interactions.
- `lib/app/shared/widgets/`: reusable widgets used across 2+ features.
- `lib/app/shared/painters/`: custom painters and drawing logic.

## Part File Rules (Current Project Pattern)
- `lib/activly_app.dart` is the library root.
- Root file contains:
  - imports
  - `part` directives
  - app bootstrap (`runActivlyApp`, `ActivlyApp`)
- Feature/core/shared implementation lives in `part of 'package:activly/activly_app.dart';` files.
- Private identifiers are allowed across part files to preserve behavior without risky API renames.

## Widget Reuse Rules
- Extract to `shared/widgets` only when reused across features or representing generic behavior (loading buttons, toggles, overlays, spinners).
- Keep feature-specific composition in feature files.
- Do not duplicate loading/animation button patterns; centralize into shared widgets.

## Naming Conventions
- Public widgets/types: `UpperCamelCase`.
- Private/internal classes/helpers: leading underscore (`_ClassName`).
- Constants: `lowerCamelCase` prefixed with `k` where applicable (`kTranslations`, `kVideoAssets`).
- Callback typedefs end with `Callback`.

## Refactor Safety Checklist
Before considering a refactor complete:
1. Entrypoint unchanged:
   - `lib/main.dart` calls `runActivlyApp()`
   - `runActivlyApp()` runs `ActivlyApp`
2. Behavior parity:
   - page flow unchanged
   - loader and animation timings unchanged
   - button loading logic unchanged
3. No dead duplicate classes remain.
4. Analyzer and tests are green.

## Verification Checklist
Run from project root:
- `flutter analyze`
- `flutter test`
- `flutter build web --debug`

## Boundary Guardrails
- `core/*` must not import from `features/*`.
- `shared/*` must not import from `features/*`.
- Feature-to-feature direct coupling is discouraged; move shared behavior to `shared/` or `core/`.
- Keep feature state localized to the feature file/folder unless truly global.

## Test Structure Rule
- Mirror `lib/` structure under `test/` as features evolve:
  - `test/app/features/shell/*`
  - `test/app/features/landing/*`
  - `test/app/features/auth/*`

If project graph tooling is enabled, rebuild graph data after code edits.
