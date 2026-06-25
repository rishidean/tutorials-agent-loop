# Exercise 02 — The spec-sprint skill

**Move:** Encode judgment · **Difficulty:** ⭐⭐ · **~30 min**

In the bare loop, *you* hand-write every `specs/sprint-N.md`. This exercise automates that: a
skill that turns a one-line roadmap entry into a full, well-formed spec. The human stops authoring
specs and starts reviewing them — the first real step toward the loop running itself.

## The task
Create `.claude/skills/spec-sprint/SKILL.md` — a skill that, given a roadmap line whose spec is
missing or thin, writes a complete `specs/sprint-N.md` with **What to build**, **Acceptance
Criteria**, and **Watch out for**.

## Done when
- Delete a spec (say `specs/sprint-4.md`), invoke `spec-sprint` for that line, and get back a spec
  good enough that the loop builds the sprint correctly from it.
- The generated **Acceptance Criteria are implementation-free and testable** — they describe
  behavior, so the playwright-tester can turn them straight into assertions.

## Hints
- Skills live at `.claude/skills/<name>/SKILL.md` — directory per skill, uppercase `SKILL.md`,
  `name` + `description` frontmatter.
- The skill should read `CLAUDE.md` (for conventions and the stable DOM ids) and the existing
  specs (to match their shape and tone).
- The hard part is discipline: keep acceptance criteria out of "how," purely "what." That property
  is exactly what makes the tester's job possible — and what makes the planted-bug trick work.

## Solution
[`solution/spec-sprint/SKILL.md`](solution/spec-sprint/SKILL.md) is a finished version. Write
yours first, then compare — especially how it forces the acceptance criteria to stay behavioral.
