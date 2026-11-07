# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

This repo is single-context. Its domain docs live in `vault/`, not in the default `GLOSSARY.md` / `docs/adr/` locations.

## Before exploring, read these

- **`vault/glosario.md`**: business term (Spanish) ↔ identifier in the code, as a table.
- **`vault/decisiones/registro.md`**: one row per ADR with what it affects. Use it to find the `vault/decisiones/ADR-000N-*.md` files that touch the area you're about to work in, and read those.

If any of these files don't exist, **proceed anyway, but say in one line which one is missing**. Don't suggest creating it upfront.

## File structure

```
/
├── vault/
│   ├── glosario.md
│   └── decisiones/
│       ├── registro.md
│       ├── ADR-0001-stack-mvp-flutter-supabase.md
│       └── ...
├── app/
└── supabase/
```

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term as defined in `vault/glosario.md`. Don't drift to synonyms the glossary explicitly avoids.

If the concept you need isn't in the glossary yet, that's a signal: either you're inventing language the project doesn't use (reconsider) or there's a real gap (note it for `/domain-modeling`).

## Where new terms and decisions go

New terms go in `vault/glosario.md`; new decisions go in `vault/decisiones/` as `ADR-000N-<slug>.md`, plus a row in `registro.md`. Follow the format (frontmatter, columns) of the existing ones. Never create a root `GLOSSARY.md` or a `docs/adr/` directory.

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it explicitly rather than silently overriding:

> _Contradice ADR-0005 (ingresos por suscripción), pero conviene reabrirlo porque…_
