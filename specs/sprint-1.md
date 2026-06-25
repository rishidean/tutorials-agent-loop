# Sprint 1: Core Clicker

## What to build
A single-page clicker game in `index.html` (inline CSS + JS, no dependencies).
- A big, obvious **Harvest** button. Clicking it increases the score by **1**.
- A score readout showing the current score.
- The score **persists**: reload the page and the score is still there.

## DOM contract (stable ids — later sprints and tests depend on these)
- `#score` — element showing the current score number
- `#harvest` — the big click button

## State
Persist to `localStorage` under key `clickfarm` as `{ score, farmhands }`.
`farmhands` stays `0` this sprint (Sprint 2 uses it). Load on start; save on every change.

## Acceptance Criteria
- **AC1:** Clicking `#harvest` increases the number shown in `#score` by exactly 1.
- **AC2:** After a reload, `#score` shows the same value it had before reloading (persistence works).
- **AC3:** `#score` is a non-negative integer at all times.

## Watch out for
- Don't keep the score only in a JS variable — it must survive a reload via localStorage.
- Use the ids exactly as specified; the e2e test selects by them.

## Out of scope
Auto-harvesting, upgrades, styling polish — later sprints.
