# Activly (Flutter)

This project contains the Activly Flutter app plus an AI-assisted workflow stack for design and engineering.

## App entry structure

- `lib/main.dart`: thin entrypoint
- `lib/activly_app.dart`: full app implementation

## Design profile installed

- Active project design spec: `DESIGN.md`
- Source profile: OpenCode-inspired design via `getdesign`

Use this in prompts when generating/refining UI:

> Follow `DESIGN.md` for colors, spacing, typography, and interaction style.

## OpenCode-only skills & agent resources

### Flutter skills

Installed from `flutter/skills` for OpenCode only:

```bash
npx skills add flutter/skills -y --copy --agent opencode
```

The installed skills are under:

- `.agents/skills/*`

### Graphify knowledge graph

Installed and integrated for OpenCode:

```bash
python -m pip install graphifyy
graphify opencode install
```

OpenCode integration artifacts:

- `opencode.json`
- `.opencode/plugins/graphify.js`
- `AGENTS.md`

Graph outputs:

- `graphify-out/graph.json`
- `graphify-out/GRAPH_REPORT.md`

After code changes, refresh graph data:

```bash
python -c "from graphify.watch import _rebuild_code; from pathlib import Path; _rebuild_code(Path('.'))"
```

Removed non-OpenCode agent artifacts from this project (`.claude`, `.kiro`, `.codex`, root `skills/`) to keep setup OpenCode-only.

## External repositories linked locally

Cloned under `external/`:

- `external/autoskills`
- `external/flutter-skills-repo`
- `external/awesome-design-md`
- `external/awesome-agent-skills`

These are resource repos; they are excluded from Flutter analyzer to keep app analysis clean.
They are also git-ignored (`/external/`) to avoid accidentally committing large third-party snapshots.

## Run & verify

```bash
flutter analyze
flutter test
flutter build web --debug
```
