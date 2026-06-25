# tutorials-agent-loop — the autonomous double-loop

> A tiny, runnable example of an **autonomous, self-verifying, multi-sprint development loop**
> built on Claude Code. You point it at a roadmap; it builds a whole app sprint by sprint,
> tests its own work, fixes what it breaks, and only marks a sprint done when the quality gate
> is green — **no hands on the keyboard.**

The app it builds is **Click Farm**, a little clicker game. The app is incidental. The point is
the *loop* — the file layout and the handful of conventions that let a stateless agent make real,
compounding progress across many sessions.

Repo: https://github.com/rishidean/tutorials-agent-loop

> **New here?** [`GETTING_STARTED.md`](GETTING_STARTED.md) is the hands-on walkthrough — how to
> run it, where every file lives and why, and how to scaffold the pattern into your own project.

---

## The idea in one picture

```
OUTER LOOP  (run.sh — dumb bash)
  while the roadmap has an unchecked sprint:
        │
        ▼
   ┌───────────────────────────────────────────────┐
   │  INNER LOOP  (one fresh Claude Code session)   │
   │                                                │
   │   orient ── read roadmap → next sprint spec    │
   │     │        + PROGRESS + CLAUDE.md            │
   │     ▼                                          │
   │   build ── write index.html                    │
   │     │                                          │
   │     ▼                                          │
   │   verify ─ run-qa skill:                       │
   │     │        linter → reviewer → e2e           │
   │     │        🔴 RED → fix → retry (≤3)          │
   │     │        🟢 GREEN ─────────┐               │
   │     ▼                          ▼               │
   │   document ─ tick roadmap, append PROGRESS,    │
   │              promote learnings to CLAUDE.md    │
   └───────────────────────────────────────────────┘
        │
        ▼
   next sprint, brand-new session (clean context)
```

Every sprint gets a **fresh brain** (a new session, empty context). Continuity doesn't come from
memory — it comes from **files**: the roadmap is the state machine, PROGRESS is the handoff log,
CLAUDE.md is the durable context. That's the whole trick.

---

## Prerequisites (macOS)

- **macOS** with a terminal (the loop is bash).
- **Node.js 18+** — <https://nodejs.org>
- **Claude Code CLI** — `npm install -g @anthropic-ai/claude-code`
- **Auth** — either run `claude` once and sign in, **or** `export ANTHROPIC_API_KEY=sk-ant-...`

Cost note: the full run launches four fresh Claude Code sessions plus QA subagents. Expect real
Claude usage. For a workshop, run `DEMO_MODE=planted` once ahead of time so you know your local
environment is ready.

## Cold-clone checklist

```bash
git clone https://github.com/rishidean/tutorials-agent-loop
cd tutorials-agent-loop
./setup.sh
claude                         # sign in if you have not already
DEMO_MODE=planted ./run.sh
```

Expected: after roughly **10-20 minutes**, the final wrapper line should say:

```text
ALL SPRINTS COMPLETE - 4 / 4 GREEN
```

To run the workshop again from the beginning:

```bash
./reset-demo.sh
```

## Setup

```bash
git clone https://github.com/rishidean/tutorials-agent-loop
cd tutorials-agent-loop
./setup.sh        # installs Playwright + Chromium, checks prereqs, chmods scripts
```

## Run it

```bash
./run.sh                      # emergent mode — the honest run
DEMO_MODE=planted ./run.sh    # planted mode — seeds the Sprint-3 bug for QA to catch
```

Runtime expectation: after setup, the full four-sprint run is usually **10-20 minutes**. A sprint can
look quiet while its fresh Claude Code session is working; wait for the wrapper's per-sprint GREEN /
BLOCKED / ERROR line before deciding it is stuck.

Then open `index.html` in a browser and play what it built.

> **Just want to play the finished game?** Open [`reference/index.html`](reference/) — a
> completed build of all four sprints. No setup, no loop run, no tokens. It's an answer key,
> kept deliberately separate from the exercise at the repo root.

---

## What you'll see

The loop walks the four sprints in `roadmap.md`:

| Sprint | Builds | Why it's here |
|---|---|---|
| 1 | Core clicker — a harvest button + a score that persists | One-shot. Proves the basic loop. |
| 2 | Farmhands — buy auto-harvesters that earn while idle | Adds state + an economy. |
| 3 | Scaling cost + a spend guard | **The money moment** — where QA should catch the planted bug and the inner loop self-corrects. |
| 4 | Polish — number formatting (1.2K / 3.4M) + a click pulse | Cosmetic finish. |

In planted mode, Sprint 3 starts from a fixture that lets you hire a farmhand you can't afford,
sending the score negative. The Sprint 3 QA path should catch that bug, the Builder fixes it, and the
sprint ends **GREEN**. Depending on Claude Code's output style, the internal RED may appear as a
literal line or as prose inside the Sprint 3 session summary.

### Two modes, on purpose

- **emergent** (default): nothing is seeded. The Builder's own Sprint 1–2 output stands, and
  whether Sprint 3 goes RED depends on what the model actually wrote. Honest, but not guaranteed.
- **planted**: right before Sprint 3, `run.sh` swaps in `fixtures/index.sprint2-buggy.html` — a
  complete, working build that deliberately ships **without** an affordability guard. Sprint 3's
  acceptance tests are written to catch and fix that bug. It's documented here in the open — no
  smoke, no mirrors.

---

## The files (a tour)

```
tutorials-agent-loop/
├── run.sh            ← the orchestrator. Dumb bash. The outer loop.
├── prompt.md         ← the Builder's marching orders, read every session.
├── CLAUDE.md         ← broad context: tech map + definition of done. Auto-loaded.
├── roadmap.md        ← the manifest AND the state machine ([ ] / [x] / [!]).
├── PROGRESS.md       ← handoff memory. The Builder appends to it each sprint.
├── specs/
│   ├── sprint-1.md   ← one spec per sprint: what to build + acceptance criteria.
│   ├── sprint-2.md
│   ├── sprint-3.md   ← the spend guard lives in the acceptance criteria, not the
│   │                   build steps — that's what the e2e test catches.
│   └── sprint-4.md
├── fixtures/
│   └── index.sprint2-buggy.html  ← planted-mode seed (the deliberate bug).
├── .claude/
│   ├── skills/
│   │   └── run-qa/SKILL.md        ← the quality gate. Runs the three agents, returns
│   │                                one verdict: GREEN or RED.
│   └── agents/
│       ├── linter.md             ← structure & syntax        (Haiku)
│       ├── code-reviewer.md      ← logic & bugs, read-only   (Sonnet)
│       └── playwright-tester.md  ← real browser e2e          (Sonnet)
├── package.json · playwright.config.js · setup.sh · .gitignore · LICENSE
├── GETTING_STARTED.md  ← run-it walkthrough + where-everything-goes + build-your-own
├── EXTENDING.md        ← the catalog of extensions (four moves → enterprise)
├── extensions/         ← hands-on follow-on exercises, each with a reference solution
├── scaffold-loop.sh    ← generates a fresh loop skeleton in a target dir
├── reset-demo.sh       ← restores the repo to the pre-run exercise state
├── TROUBLESHOOTING.md  ← first-run fixes for auth, models, Playwright, and resets
├── reference/
│   └── index.html    ← the finished app (answer key). NOT part of the exercise.
└── index.html        ← NOT committed. The loop generates it. Run ./run.sh to see it appear.
```

### Who runs on what

The **Builder** (the main session) runs on **Opus** — it's doing the reasoning and the writing.
The QA crew is cheaper and scoped: the **linter** on **Haiku**, the **code-reviewer** and
**playwright-tester** on **Sonnet**. Each subagent's model is set in its own frontmatter, so you
can retune cost per role without touching the loop.

---

## Make it yours

The loop is the reusable part; Click Farm is just cargo. To point it at your own work:

1. Replace `CLAUDE.md` with your service's stack, conventions, and the one line that matters:
   **done = run-qa GREEN.**
2. Replace `specs/*.md` with your real backlog — one spec per sprint, each with crisp
   **acceptance criteria** (that's what the tester turns into assertions).
3. Swap the QA agents for your real linter / reviewer / test runner.
4. `./run.sh`.

Start with the dumbest repetitive task you do every week. That's your first spec.

Once the bare loop is running, [`EXTENDING.md`](EXTENDING.md) is the catalog of where it goes
next — input skills that write your roadmaps and specs, a planning phase, more QA gates,
PR-per-sprint, parallelism — all the way up to enterprise scale. Same loop, more pieces.

---

## A word on `--dangerously-skip-permissions`

`run.sh` launches the Builder with `--dangerously-skip-permissions` because there's no human at
the keyboard to approve each file write — without it, the loop just hangs. That flag removes real
guardrails. It's fine **here** because this repo is a disposable sandbox that only touches its own
folder. Don't carry that flag into a real codebase; there, scope tools with `--allowedTools` and a
permission mode instead.

## Troubleshooting and reset

- First-run issues: see [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md).
- Run it again from scratch: `./reset-demo.sh`.

## License

MIT — see `LICENSE`.
