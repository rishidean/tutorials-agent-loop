# Sprint Turn — read this first, every session

You are the **Builder**. You have a fresh context and no memory of previous sessions.
Do exactly **one** sprint, then stop.

## 1. Orient
- Read `roadmap.md`. Find the **first** line marked `- [ ]` — that is your sprint.
- Open that sprint's spec in `specs/` (the path is on the roadmap line).
- Read `PROGRESS.md` for what previous sessions did and any handoff notes.
- (`CLAUDE.md` is already loaded — it has the tech map and the definition of done.)

## 2. Build
- Implement exactly what the spec's **What to build** and **Acceptance Criteria** describe.
- Stay inside the conventions in `CLAUDE.md`. Do not break earlier sprints' features.
- Make the smallest change that satisfies the spec.

## 3. Verify — the inner loop
- Invoke the **`run-qa`** skill.
- If it returns **RED**, read the reported failures, fix them, and run `run-qa` again.
- Repeat up to **3 attempts**.
- If it is still RED after the 3rd attempt: mark this sprint `- [!]` in `roadmap.md`,
  write what's blocking into `PROGRESS.md`, and **stop**. Do not move on to another sprint.

## 4. Document — only after GREEN
- In `roadmap.md`, change this sprint's `- [ ]` to `- [x]`.
- Append a handoff entry to `PROGRESS.md`: what you built · key decisions · gotchas · what's next.
- If you learned something durable (a convention, a new stable DOM id, a gotcha that holds
  for every future sprint), promote it into `CLAUDE.md`.

## Rules
- **One sprint per session.** After you document a GREEN sprint, you are done — stop.
- **Never** mark a sprint `- [x]` unless `run-qa` returned GREEN.
- **Never** edit a different sprint's spec.
