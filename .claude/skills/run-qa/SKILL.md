---
name: run-qa
description: Run the Click Farm quality gate: lint, code review, and Playwright acceptance tests. Returns one GREEN or RED verdict.
---

# run-qa

Run the three QA checks in order by delegating to the project subagents:

1. `linter` - validates `index.html` structure and inline JavaScript.
2. `code-reviewer` - reviews the implementation against the active sprint spec.
3. `playwright-tester` - runs browser behavior checks for the active sprint acceptance criteria.

Use the Task tool for each subagent. Pass along the active sprint name, the active spec path, and
any relevant previous failure details if this is a retry.

## Verdict

Return exactly one final verdict:

- `GREEN` if the linter is clean, the reviewer reports no `CRITICAL` findings, and the Playwright
  tests pass.
- `RED` if there is any lint error, any `CRITICAL` review finding, or any failed Playwright test.

For `RED`, include the shortest actionable failure list: what failed, where it failed, and the
smallest likely fix. Do not mark the sprint complete until this skill returns `GREEN`.
