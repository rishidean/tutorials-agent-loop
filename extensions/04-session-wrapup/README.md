# Exercise 04 — Session wrap-up

**Move:** Close the loop · **Difficulty:** ⭐⭐ · **~30 min**

Right now the loop leaves no trail beyond `PROGRESS.md` and a tree full of changes. A
**session-wrapup** skill makes each sprint auditable: it writes the handoff and commits the work
with a consistent message, so the git history reads like a build log.

## The task
Create `.claude/skills/session-wrapup/SKILL.md` — a skill the Builder runs as its final step on a
GREEN sprint. It should append the `PROGRESS.md` handoff entry, then `git add` + `git commit` the
sprint's changes with a structured message. Wire `prompt.md`'s document step to call it.

## Done when
- After each GREEN sprint there's exactly one commit, with a consistent message
  (e.g., `sprint N: <name> — green`).
- `PROGRESS.md` has the handoff entry for that sprint.
- The git log alone tells the story of the build, sprint by sprint.

## Hints
- This skill has a real side effect (a commit). Keep it scoped: commit only within the repo, never
  `git push`, and use a conventional message. A human still owns pushing and merging.
- Stage the specific files you expect to change (`index.html`, `roadmap.md`, `PROGRESS.md`, any
  generated spec) rather than a blind `git add -A`.
- In `prompt.md`, replace the manual "append to PROGRESS.md" instruction in step 4 with
  "invoke the session-wrapup skill."

## Solution
[`solution/session-wrapup/SKILL.md`](solution/session-wrapup/SKILL.md) is a finished version.
Note how it keeps the commit narrow and the message structured — that discipline is what makes the
history useful later.
