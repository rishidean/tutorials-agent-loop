# Exercise 01 — Add a QA agent

**Move:** Add a gate · **Difficulty:** ⭐ · **~20 min**

The bare gate is lint → review → test. The gate is composable: adding a check is adding one file
and one line. You'll add an **accessibility auditor** and wire it into `run-qa`.

## Why
Click Farm is clickable — but is it *keyboard* operable? Do its buttons have accessible names? A
real product has gates the demo doesn't. This is how you add one.

## The task
1. Create `.claude/agents/accessibility-auditor.md` — a subagent that checks `index.html` for
   basic accessibility (keyboard operability, accessible names, not relying on color alone).
2. Wire it into `.claude/skills/run-qa/SKILL.md` so the gate runs it alongside the other three.
3. Re-run the loop and confirm the new check runs.

## Done when
- `run-qa` runs **four** checks, and its verdict reflects the new one.
- A build that fails accessibility (e.g., a clickable `<div>` with no label instead of a
  `<button>`) comes back **RED** with an accessibility reason.
- A clean build still goes **GREEN**.

## Hints
- Subagents live at `.claude/agents/<name>.md`. Frontmatter: `name`, `description`, `tools`,
  `model`; body = the system prompt. Accessibility needs some judgment — use `model: sonnet`.
- It's read-only: `tools: Read, Grep, Glob`.
- End the agent's output with a clear `A11Y: PASS` / `A11Y: FAIL` line, like the other agents.
- In `run-qa`'s SKILL.md, add it to the ordered list **and** to the RED condition.

## Solution
A finished agent is in [`solution/accessibility-auditor.md`](solution/accessibility-auditor.md).
Wire it into `run-qa` by adding a fourth step and extending the verdict:

```
4. accessibility-auditor — keyboard, names, contrast (model: sonnet).
...
RED if: any lint error, any CRITICAL, any failed test, OR any A11Y: FAIL.
```
