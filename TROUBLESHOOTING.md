# Troubleshooting

The most common first-run failures are environment issues, not loop issues. Start here.

## Claude Code is not authenticated

Symptom: the first `claude -p ...` session exits immediately or asks for auth.

Fix:

```bash
claude
```

Sign in once, then return to this repo and run:

```bash
DEMO_MODE=planted ./run.sh
```

You can also use an API key:

```bash
export ANTHROPIC_API_KEY=sk-ant-...
```

## Unknown model alias

Symptom: Claude Code rejects `--model opus`, or a subagent rejects `haiku` / `sonnet`.

Fix: check your installed CLI's accepted model names:

```bash
claude --help
```

Then override the Builder model:

```bash
BUILDER_MODEL=<your-opus-model-name> DEMO_MODE=planted ./run.sh
```

If subagent aliases changed in your CLI, edit the `model:` frontmatter in:

- `.claude/agents/linter.md`
- `.claude/agents/code-reviewer.md`
- `.claude/agents/playwright-tester.md`

## Playwright or Chromium install fails

Symptom: `setup.sh` fails during `npm install` or `npx playwright install chromium`.

Fix:

```bash
npm install
npx playwright install chromium
```

Then re-run:

```bash
./setup.sh
```

If you are behind a corporate proxy, fix npm/proxy access first. The tutorial cannot run browser QA
without the Playwright package and a Chromium browser.

## Playwright cannot launch Chromium

Symptom: tests fail with `browserType.launch` or Chromium permission errors.

Fixes to try:

```bash
npx playwright install chromium
npm test
```

On managed Macs, security tooling can block headless Chromium. If `npm test` fails before any test
body runs, the app may be fine and your local browser launch policy is the blocker.

## The terminal looks stuck

Each sprint launches a fresh headless Claude Code session. It is normal for the terminal to be quiet
for a few minutes while that session builds, tests, fixes, and writes its handoff.

Wait for the wrapper line:

```text
Sprint N: GREEN after Xm Ys
```

If a sprint takes much longer than 10 minutes, stop it and retry with a higher turn cap:

```bash
MAX_TURNS=120 DEMO_MODE=planted ./run.sh
```

## The repo is dirty after a run

That is expected. The tutorial is supposed to generate `index.html`, tests, roadmap updates, and
handoff notes.

To run the workshop again from the beginning:

```bash
./reset-demo.sh
```

## Planted mode does not visibly print RED

`DEMO_MODE=planted` seeds a Sprint 2 fixture with an affordability bug. The Sprint 3 QA path should
catch and fix that bug, but the outer wrapper only guarantees the final sprint status line. Depending
on Claude Code's output style, the internal RED may be described in prose or may only appear in the
session's reasoning about the fix.
