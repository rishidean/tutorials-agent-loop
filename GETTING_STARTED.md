# Getting Started

Two ways to use this repo. Pick your path:

- **"Just show me it run"** → Part 1 (5 minutes).
- **"I want to build my own loop"** → Part 2 (what's where and why) then Part 3 (place the pieces).

If your first run misbehaves, jump to [Troubleshooting](#troubleshooting-your-first-run).

---

## Part 1 — Run the tutorial

Everything in this repo is already wired and in the right place. You don't move any files —
you just set up and run.

**Prerequisites** (macOS): Node 18+, the Claude Code CLI, and Claude Code authenticated.
Full list in the [README](README.md#prerequisites-macos).

```bash
git clone https://github.com/rishidean/tutorials-agent-loop
cd tutorials-agent-loop
bash setup.sh        # installs Playwright + Chromium, checks prereqs, chmods run.sh
```

Make sure Claude Code is authed (`claude` once and sign in, or `export ANTHROPIC_API_KEY=...`),
then:

```bash
./run.sh                      # emergent run — honest, RED not guaranteed
DEMO_MODE=planted ./run.sh    # planted run — Sprint 3 goes RED → fix → GREEN, every time
```

Expect a full four-sprint run to take roughly **10-20 minutes** after setup. Each sprint launches a
fresh Claude Code session, and the terminal can be quiet for a few minutes while that session builds,
tests, fixes, and documents. First-time setup can add a few minutes because Playwright may download
Chromium.

When it finishes, open the app the loop just built:

```bash
open index.html               # the loop's own output
open reference/index.html     # or the finished answer key — no run required
```

That's the whole demo. The rest of this doc is about understanding the machine and reusing it.

---

## Part 2 — The anatomy: where every piece lives, and why

```
tutorials-agent-loop/
├── CLAUDE.md          ← broad context. Auto-loaded at the start of every session.
├── prompt.md          ← the Builder's marching orders. Fed in with claude -p.
├── roadmap.md         ← the manifest + state machine ([ ] / [x] / [!]).
├── PROGRESS.md        ← handoff memory. The Builder appends to it each sprint.
├── run.sh             ← the orchestrator (the outer loop).
├── specs/
│   └── sprint-N.md    ← one spec per sprint. The roadmap line points at the path.
├── .claude/
│   ├── skills/
│   │   └── run-qa/
│   │       └── SKILL.md      ← the quality gate (a skill).
│   └── agents/
│       ├── linter.md         ← subagent (Haiku)
│       ├── code-reviewer.md  ← subagent (Sonnet)
│       └── playwright-tester.md ← subagent (Sonnet)
├── fixtures/          ← the planted bug for DEMO_MODE=planted. Tutorial-only.
└── reference/         ← the finished app (answer key). NOT part of the exercise.
```

The four placement rules that matter — get these wrong and Claude Code silently won't find
your pieces:

**CLAUDE.md** lives at the project root. Claude Code reads it automatically at the start of
every session — *as long as you don't run with `--bare`*, which turns auto-discovery off. This
is your broad context: stack, conventions, and the one rule that makes the loop trustworthy
(`done = run-qa GREEN`).

**Skills** live at `.claude/skills/<skill-name>/SKILL.md`. Three things people get wrong:
it's a **directory per skill** (named for the skill), the file is **`SKILL.md` in uppercase**,
and it needs YAML frontmatter with `name` and `description`. The description is what lets Claude
invoke it by name (`run-qa`) when it's relevant. (Note: "commands" have been folded into skills
in current Claude Code — a skill is the thing to reach for now.)

**Subagents** live at `.claude/agents/<name>.md` — one file each, not a directory. Frontmatter:
`name`, `description`, optional `tools` (a comma-separated allowlist; omit it to inherit all),
optional `model` (`haiku` / `sonnet` / `opus`, a full id, or `inherit`). The body of the file is
the subagent's system prompt. The main session calls a subagent through the **Task tool** — so
whatever runs the gate needs the Task tool available (the loop gets it via
`--dangerously-skip-permissions`; otherwise put `Task` in `--allowedTools`).

**Specs** are plain markdown at `specs/sprint-N.md`. Nothing magic — each `roadmap.md` line just
names the path, and `prompt.md` tells the Builder to open the spec for the sprint it picked up.
The shape that works: **What to build**, **Acceptance Criteria**, **Watch out for**. The
acceptance criteria are what your tester turns into real assertions, so write them precisely.

Two more facts worth knowing: project-level `.claude/` (committed in the repo) is what makes the
loop self-contained and shareable — prefer it over user-level `~/.claude/`. And every sprint is a
**fresh session** with empty context; continuity comes only from the files (`roadmap` = state,
`PROGRESS` = memory, `CLAUDE.md` = durable learning), never from the model remembering.

---

## Part 3 — Build your own loop

To point this pattern at your own project, recreate this structure in your repo:

```
your-project/
├── CLAUDE.md                       # your stack + "done = run-qa GREEN"
├── prompt.md                       # copy from this repo as-is (app-agnostic)
├── roadmap.md                      # your sprints, each → specs/sprint-N.md
├── PROGRESS.md                     # empty to start
├── run.sh                          # copy as-is; set BUILDER_MODEL at the top
├── specs/
│   └── sprint-1.md                 # your first spec
└── .claude/
    ├── skills/run-qa/SKILL.md      # copy, then adjust the checks to your stack
    └── agents/
        ├── linter.md               # copy as templates — the ones here are
        ├── code-reviewer.md        #   Click-Farm-flavored, so swap the app
        └── playwright-tester.md    #   specifics for your stack
```

Step by step:

1. **Make the directories:** `mkdir -p specs .claude/skills/run-qa .claude/agents`
2. **CLAUDE.md** — write your architecture, conventions, and the definition of done.
3. **prompt.md** — copy this repo's verbatim. It's app-agnostic (orient → build → verify → document).
4. **roadmap.md** — list your sprints as `- [ ] Sprint N: <name> — specs/sprint-N.md`.
5. **specs/sprint-1.md** — What to build + Acceptance Criteria. Start with the dumbest repetitive
   task you do every week.
6. **The skill** — copy `.claude/skills/run-qa/SKILL.md`, then change the three checks to your
   stack (your linter, your reviewer focus, your test runner).
7. **The agents** — copy the three files in `.claude/agents/` as starting points and replace the
   Click-Farm specifics (the DOM ids, the `clickfarm` localStorage, `index.html`) with yours.
8. **run.sh** — copy as-is; set `BUILDER_MODEL` at the top.
9. **Run it:** `./run.sh`.

Or skip the copying:

```bash
./scaffold-loop.sh ../my-loop
```

That generates the whole skeleton in a target directory — the dirs, the app-agnostic files
copied straight over, the agents and skill copied as editable templates, and stub
`CLAUDE.md` / `roadmap.md` / `specs/sprint-1.md` with `TODO`s for you to fill.

Once your own loop runs green, see [`EXTENDING.md`](EXTENDING.md) for where it goes from here —
input skills, planning phases, more QA gates, PR-per-sprint, and the climb to enterprise scale.

---

## Troubleshooting your first run

- **The Builder skipped QA / never went GREEN-or-RED.** Skills are model-invoked. If it didn't
  call `run-qa`, make the instruction in `prompt.md` more explicit ("invoke the `run-qa` skill").
- **"Agent not found" / the gate didn't run the three checks.** The subagents must be at
  `.claude/agents/*.md`, and the session needs the **Task tool**. The loop grants it via
  `--dangerously-skip-permissions`; if you removed that flag, add `Task` to `--allowedTools`.
- **The loop re-runs Sprint 1 forever.** The Builder isn't ticking the roadmap. Confirm it edits
  `roadmap.md` `[ ]→[x]` as its final step — the outer loop greps for `- [ ]` to decide what's next.
- **It dies mid-sprint.** Raise the turn cap: `MAX_TURNS=120 ./run.sh`.
- **Planted mode didn't go RED.** The agent re-added the guard on its own. Trim the affordability
  hints in `specs/sprint-3.md` so only the acceptance criteria (not the build steps) mention it.
- **Playwright can't open the app.** The tester opens it via `file://` + an absolute path. Make
  sure `bash setup.sh` finished (Chromium installed) and `index.html` exists at the repo root.
- **Auth error on the first session.** Run `claude` once and sign in, or
  `export ANTHROPIC_API_KEY=...` before `./run.sh`.
- **"Unknown model" on a `--model` flag.** Your CLI may use different aliases; check
  `claude --help` and adjust `BUILDER_MODEL` / the agent frontmatter.
