---
name: session-wrapup
description: >
  Use this skill as the final step of a GREEN sprint. It writes the PROGRESS.md handoff and commits
  the sprint's work with a structured message, so the git history reads like a build log.
---

# session-wrapup

Run this only after `run-qa` returned GREEN and the roadmap box is ticked.

1. **Handoff.** Append an entry to `PROGRESS.md`:
   ```
   ## Sprint N — <title>  (<date>)
   - Built: ...
   - Decisions: ...
   - Gotchas: ...
   - Next up: ...
   ```
2. **Commit.** Stage only the files this sprint changed (typically `index.html`, `roadmap.md`,
   `PROGRESS.md`, and any spec you generated), then commit with a structured message:
   ```
   sprint N: <short name> — green
   ```
   Do **not** `git push`. Pushing and merging stay with a human.

## Guardrails
- Never `git add -A` blindly — stage the specific files.
- Never force-push, amend published history, or push.
- If `git` isn't available or the repo isn't initialized, write the PROGRESS entry, report that the
  commit was skipped, and do not fail the sprint over it.
