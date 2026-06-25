---
name: spec-sprint
description: >
  Expand one roadmap line into a complete sprint spec with acceptance criteria. Use when a sprint
  is marked [ ] in roadmap.md but its specs/sprint-N.md is missing or too thin to build from.
---

# spec-sprint

Turn a single roadmap line into a full spec the loop can build from.

## Inputs
- The roadmap line you're specing (its name and the `specs/sprint-N.md` path it points to).
- `CLAUDE.md` — for the architecture, conventions, and stable DOM ids.
- The existing `specs/*.md` — match their structure and level of detail.

## Write specs/sprint-N.md with these sections
1. **What to build** — the feature in plain language. Describe visible behavior, not code.
2. **Acceptance Criteria** — precise, testable statements of behavior. Implementation-free: say
   *what* must be true (what the user sees, what the state does), never *how* to code it. These
   become the playwright-tester's assertions, so each must be checkable in a browser.
3. **Watch out for** — known edge cases and boundaries (off-by-one, persistence, never-negative).

## Rules
- Reuse the stable DOM ids from `CLAUDE.md`. Only invent new ones if the feature needs them — and
  if so, name them in a DOM-contract line.
- Keep acceptance criteria behavioral. If a criterion names a function or variable, rewrite it as
  an observable outcome.
- One spec, one sprint. Don't pull later sprints' scope forward.

Write the file, then stop — the Builder picks it up on its next turn.
