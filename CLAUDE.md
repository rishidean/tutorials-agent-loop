# Click Farm — Project Context

> This file is loaded automatically at the start of **every** Claude Code session.
> It is the *broad* context: things that are true for every sprint, no matter what's
> being built. Sprint-specific detail lives in `specs/`, not here.

## Identity & mission
You maintain **Click Farm**, a tiny incremental ("clicker") game that runs entirely in
the browser. You pick up one sprint at a time, build it, prove it works, and hand off.

## Definition of done
A sprint is **DONE** only when all three are true:
1. The feature in that sprint's spec is implemented, and
2. the `run-qa` skill returns **GREEN**, and
3. nothing that previously worked is broken.

> If `run-qa` is not GREEN, you are not done. This one rule is what makes the loop trustworthy.

## The map (architecture)
- The entire app is a single file: `index.html` — inline `<style>` and `<script>`,
  **no build step, no dependencies, no frameworks, no CDNs**.
- It opens directly from disk (`file://`). There is no server.
- Game state is one object, persisted to `localStorage` under the key `clickfarm`:
  ```js
  { score: number, farmhands: number }
  ```
- On load: read state from localStorage (default to a fresh game `{score:0, farmhands:0}`).
  On every change: write it back.

## Conventions
- Vanilla HTML/CSS/JS only. Keep all logic in the one inline `<script>`, in small readable functions.
- `score` and `farmhands` are integers and must **never go negative**.
- Money math is integer-only (no fractional score).
- Don't rename DOM ids/classes that earlier sprints established — later specs and the e2e
  tests select by them. Stable hooks so far:
  - `#score` — the score readout
  - `#harvest` — the big click button
  - `#hire` — hire-a-farmhand button (Sprint 2)
  - `#farmhands` — farmhand count readout (Sprint 2)
  - `#cost` — current hire cost readout (Sprint 2)

## How to verify your work
When the build is ready, invoke the **`run-qa`** skill. It runs three checks in order
(lint → review → e2e) and returns a single **GREEN** or **RED** verdict. On RED, fix the
reported issues and run it again.

## Promote durable learnings here
If you discover something true for *all future sprints* — a convention, a gotcha, a new
stable id — append it under **Conventions** so the next (fresh, amnesiac) session inherits it.
