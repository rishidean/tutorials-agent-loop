# Extensions — hands-on exercises

The main repo is **Exercise 0**: you ran the bare loop and watched it build Click Farm. These
build on it. Each one adds a real piece to the loop and teaches one of the four moves from
[`EXTENDING.md`](../EXTENDING.md) by making you *build* it — not just read about it.

## How they work
- Each folder has a **README** (the brief: goal, task, "done when", hints) and a **`solution/`**
  with a finished version to check yourself against. Try it before you peek.
- You apply each change to the **main repo** — copy the new file into `.claude/`, wire it in,
  re-run `./run.sh`. The exercises extend the loop you already have.
- They're ordered easy → hard, and each teaches a different move. Do them in order or cherry-pick.

## The exercises
| # | Exercise | Move | You'll build |
|---|---|---|---|
| 01 | [Add a QA agent](01-add-a-qa-agent/) | Add a gate | An accessibility check, wired into `run-qa` |
| 02 | [The spec-sprint skill](02-spec-sprint-skill/) | Encode judgment | A skill that writes specs from a roadmap line |
| 03 | [A planning phase](03-planning-phase/) | Encode judgment | An architect step that plans before the Builder builds |
| 04 | [Session wrap-up](04-session-wrapup/) | Close the loop | A skill that commits and logs each sprint |

## Go further
These four are a sampler. The full catalog — `generate-roadmap`, more QA agents, PR-per-sprint,
parallel builders, epics → sprints → features, observability — is in
[`EXTENDING.md`](../EXTENDING.md). It's the same pattern every time: one small file, wired into a
loop that already knows how to find it.

And the rule from EXTENDING.md still holds: in real life, add a piece the day the bare loop hurts
without it. These exercises are practice reps — scale by necessity, not by anticipation.
