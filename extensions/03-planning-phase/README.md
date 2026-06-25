# Exercise 03 — A planning phase

**Move:** Encode judgment · **Difficulty:** ⭐⭐⭐ · **~45 min**

On easy sprints the Builder just builds. On hard ones it flails — writing, second-guessing,
rewriting. A **planning phase** fixes that: an architect produces an approach first, and the
Builder executes the plan instead of improvising one mid-build. This is the highest-leverage
quality change in the whole catalog.

## The task
1. Create an architect subagent at `.claude/agents/plan-sprint.md` that reads the sprint spec and
   produces a short plan: files to touch, the approach, and the risks/edge cases.
2. Insert a **plan step before build** in `prompt.md`: the Builder calls `plan-sprint`, writes the
   plan to a scratch file (`PLAN.md`), then builds against it.

## Done when
- On a sprint, the session produces a written plan *before* it writes `index.html`.
- The plan names the specific changes and the edge cases — for Sprint 3, the affordability guard
  and the exact-cost boundary should appear in it.
- The build follows the plan, and the loop still ends GREEN.

## Hints
- `plan-sprint` is a subagent (`.claude/agents/plan-sprint.md`), `model: sonnet`,
  `tools: Read, Grep, Glob` — it plans, it doesn't write app code.
- The Builder invokes it via the Task tool — the same mechanism `run-qa` uses for its agents.
- In `prompt.md`, add the plan step between **Orient** and **Build**. Want the enterprise version?
  Gate it: a human reads `PLAN.md` and approves before the build proceeds.

## Solution
[`solution/plan-sprint.md`](solution/plan-sprint.md) is the architect agent. Wire it into
`prompt.md` by adding, right after Orient:

```
## 1.5 Plan
- Invoke the plan-sprint agent with the active sprint's spec.
- Write its plan to PLAN.md.
- Build against that plan in the next step.
```
