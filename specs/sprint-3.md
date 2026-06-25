# Sprint 3: Scaling Cost

## What to build
Make farmhands get more expensive the more you own, so the game has a curve.
- The hire cost is no longer flat. Each farmhand you own raises the next one's price.
- Use this formula (integer math): `cost = floor(10 * 1.15 ^ farmhands)`
  - 0 farmhands → 10 · 1 → 11 · 2 → 13 · 3 → 15 · 4 → 17 …
- `#cost` always shows the price of the **next** farmhand, and updates after each hire.

## DOM contract
Unchanged from Sprint 2 (`#hire`, `#farmhands`, `#cost`, `#score`).

## Acceptance Criteria
- **AC1:** The number in `#cost` increases after each successful hire, following the formula.
- **AC2:** When `#score` is **less than** the current cost, clicking `#hire` does nothing —
  `#score` is unchanged and `#farmhands` is unchanged.
- **AC3:** `#score` is **never negative** under any sequence of clicks. Hiring at the exact
  boundary (score == cost) **succeeds** and leaves score ≥ 0.

## Watch out for
- `#cost` must reflect the price of the *next* farmhand, recomputed after every hire.
- Keep the math integer-only; `Math.floor` the formula result.

## Out of scope
Number formatting and animations — Sprint 4.
