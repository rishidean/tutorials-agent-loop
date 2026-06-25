# Extending the Loop

This repo is the **seed**, not the destination. The pattern doesn't get more *complex* as it
scales — it gets more *pieces*, and every piece is the same shape you already know: a markdown
file with a little frontmatter, dropped into `.claude/`. That's the whole point. A solo demo and
an enterprise build pipeline are the same loop with different files plugged in.

Everything you can add is one of **four moves**:

1. **Encode more of your judgment** — turn work you do by hand into a skill, so you review instead of author.
2. **Add a gate** — raise the bar on what "GREEN" means before code is trusted.
3. **Add structure** — let the manifest grow levels so the loop scales across sprints, services, and teams.
4. **Close the loop** — make runs durable, auditable, and self-improving.

Mapped onto the Continuum from the talk: the bare loop gets you to **Helicopter** — airborne, a
different process. These four moves are how you climb to **Jet** (a team) and **Rocket** (an org).

---

## Move 1 — Encode more of your judgment

In the bare loop, *you* still write the roadmap and every spec by hand. Each of these turns that
authoring into a skill you invoke — the human becomes a reviewer, not a typist.

| Skill | Plugs in | What it does |
|---|---|---|
| `generate-roadmap` | before the loop | A goal or PRD in → a sprint breakdown out. Writes `roadmap.md`. |
| `spec-sprint` | per roadmap line | Expands one line into a full spec with acceptance criteria in `specs/`. |
| `update-roadmap` | mid-project | Re-sequences, splits, or inserts sprints as scope shifts. |
| `plan-sprint` | between orient & build | An architect pass: reads the spec, produces an approach (files, interfaces, risks) the Builder then executes. |

`plan-sprint` is worth calling out — inserting a **planning phase before build** is the single
biggest quality lever on hard sprints. The Builder stops flailing because it executes a plan
instead of improvising one mid-build.

## Move 2 — Add a gate

The bare QA crew is lint → review → test. The gate is *composable* — `run-qa`'s SKILL.md just
decides which agents to run, so adding a check is adding one `.claude/agents/*.md` file.

| QA agent | Catches |
|---|---|
| `security-reviewer` | injection, leaked secrets, authz holes |
| `accessibility-auditor` | WCAG / a11y regressions |
| `performance-checker` | bundle bloat, N+1 queries, blown perf budgets |
| `contract-tester` | API / schema contract drift |
| `visual-regression` | unintended UI changes (screenshot diff) |
| `dependency-auditor` | license and CVE problems |

Gates aren't only agents. They're also **process checkpoints**:

- **Planning approval** — a human signs off `plan-sprint`'s output before any code is written (high-stakes work).
- **PR-per-sprint** — the loop opens a pull request instead of committing to `main`; CI runs; a human merges. This is the step that turns the loop from a script into a teammate.
- **Budget / circuit-breaker** — a max cost or turn count per sprint; exceed it and the loop stops and flags.

## Move 3 — Add structure

The manifest is just a checkbox state machine. Give it levels and it scales without getting more complicated.

| Extension | What it does |
|---|---|
| Epics → Sprints → Features | Nest the manifest. Same `[ ]/[x]/[!]` state machine, more levels. (The "roadmap · scaled" slide shows this.) |
| Parallel builders | Independent sprints on git worktrees / branch-per-sprint, run concurrently. |
| Multi-repo orchestration | One loop spans several services — a `CLAUDE.md` per repo, shared specs. |

## Move 4 — Close the loop

Make runs repeatable, auditable, and self-improving. (These first two are skills — what you'd
have called "commands" — invoked at the top and tail of a session.)

| Skill / feature | What it does |
|---|---|
| `session-start` | Pulls latest, loads context, surfaces the next sprint, sanity-checks the tree. |
| `session-wrapup` | Summarizes the work, updates `PROGRESS.md`, commits with a structured message, flags follow-ups. |
| Structured logs | `--output-format stream-json` → a run dashboard, cost/turn tracking, an audit trail. |
| Knowledge base | Promote durable learnings beyond `PROGRESS.md`; retrieve over past decisions so the loop stops repeating mistakes. |

---

## Every extension is the same shape

Adding `spec-sprint` isn't a new framework — it's another `SKILL.md`:

```
---
name: spec-sprint
description: Expand one roadmap line into a full spec with acceptance criteria. Use when a
  sprint is marked [ ] but specs/sprint-N.md is missing or thin.
---
# spec-sprint
Given a roadmap line and the project's CLAUDE.md:
1. Draft "What to build", "Acceptance Criteria" (precise and testable), and "Watch out for".
2. Write it to specs/sprint-N.md.
3. Keep the acceptance criteria implementation-free — they become the tester's assertions.
```

That's it. Every item in this doc is a file this size. You are never re-architecting; you are
adding one more small, single-purpose file to a structure that already knows how to find it.

---

## Practice it

Four of these are turned into hands-on exercises in [`extensions/`](extensions/) — add a QA gate,
write the `spec-sprint` skill, insert a planning phase, and build `session-wrapup`. Each has a
brief and a reference solution. Reading the move is one thing; wiring it into your own loop is
where it sticks.

## The climb to enterprise

Same loop, more pieces, at three altitudes:

- **Helicopter — this repo.** One app. You author the roadmap and specs. A three-agent gate.
  Serial sprints. Commits to a branch.
- **Jet — a team.** `generate-roadmap` and `spec-sprint` write the inputs; a `plan-sprint` phase
  precedes build; the gate adds security / a11y / performance; PR-per-sprint with CI; session
  bookends. You review the work — you don't author it.
- **Rocket — an org.** Fleets of loops across many services; org-level context and a shared
  knowledge base; budgets, observability, and audit trails on every run; humans set goals and
  approve gates while the loops do the building.

---

## One caution: earned complexity

The minimal loop is the point. Every agent and skill above is *overhead* until a real failure
justifies it. Add the security agent the day a vulnerability ships, the planning phase the day a
sprint flails, `generate-roadmap` the day hand-writing roadmaps becomes your bottleneck. Scale by
necessity, not by anticipation — a loop with twenty agents and no reason for nineteen of them is
slower, costlier, and harder to trust than the six files you started with.
