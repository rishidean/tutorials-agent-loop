# Sprint 2: Farmhands (auto-harvest)

## What to build
Let the player spend score to hire **Farmhands** that harvest automatically.
- A **Hire Farmhand** button. Hiring costs **10** score (flat cost this sprint).
- Hiring deducts the cost and increases the farmhand count by 1.
- Each farmhand adds **+1 score per second**, automatically (a 1000ms interval).
- Show the farmhand count and the current hire cost on screen.

## DOM contract (new stable ids)
- `#hire` — the hire button
- `#farmhands` — farmhand count readout
- `#cost` — current hire cost readout

## State
Extend the persisted `clickfarm` object: `{ score, farmhands }`. Persist both.
The auto-harvest interval runs while the page is open (no offline earnings).

## Acceptance Criteria
- **AC1:** Clicking `#hire` when score ≥ 10 deducts 10 from `#score` and increases `#farmhands` by 1.
- **AC2:** With at least one farmhand, `#score` increases on its own over ~1 second.
- **AC3:** `#cost` shows the cost to hire (10 this sprint).

## Watch out for
- Keep saving state from the auto-harvest interval so progress survives a reload.

## Out of scope
Scaling cost and the affordability guard — that's Sprint 3.
