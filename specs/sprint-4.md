# Sprint 4: Polish

## What to build
Two small touches that make Click Farm feel finished.

1. **Readable big numbers.** Once score or cost reaches 1,000+, show an abbreviated form:
   - 1,200 → `1.2K` · 3,400,000 → `3.4M` · 5,600,000,000 → `5.6B`
   - Below 1,000, show the plain integer.
   - Apply the same formatting to `#score` and `#cost`.
2. **Click feedback.** When `#harvest` is clicked, give a brief visual pulse (a quick scale
   or flash via a CSS class that's added then removed). Purely cosmetic.

## DOM contract
Unchanged. Formatting changes only what's *displayed* in `#score` and `#cost` — the
underlying integer state stays exact (don't store the abbreviated string).

## Acceptance Criteria
- **AC1:** With score ≥ 1000, `#score` shows an abbreviated string (e.g., `1.2K`), not the raw integer.
- **AC2:** With score < 1000, `#score` shows the plain integer.
- **AC3:** Underlying state is still an exact integer (abbreviation is display-only — a hire
  for an exact cost still works correctly).

## Watch out for
- Format on *display* only. If you round the stored value, the economy math breaks.

## Out of scope
Anything else — this is the last sprint.
