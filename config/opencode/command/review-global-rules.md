---
description: Review local OpenCode rule observations and propose global rule updates.
agent: build
---

Review `~/.local/state/opencode/AGENTS-observations.md` against the global
rules at `~/.config/opencode/AGENTS.md`.

- If the observation log does not exist or has no entries, report that and
  stop.
- Parse candidates by their heading, scope, status, and observations. Treat
  observations from the same task as one observation.
- Never infer a pattern from an agent action or the user's passive acceptance.
  Evidence must be an explicit user instruction or a user correction.
- Check whether an existing global rule already covers each candidate. Report
  covered candidates separately; do not propose duplicate rules.
- For unresolved candidates, propose `explicit` directives with 1-2
  independent observations and `repeated` patterns with at least 3. Flag
  evidence older than 6 months as `[stale]`, but keep it in the count.
- Also list unresolved repeated patterns with exactly 2 observations as
  near-misses. Do not suggest rules for other incomplete patterns.
- For every candidate or near-miss, show the scope, dated evidence, and exact
  proposed rule wording. Explain why the candidate meets its threshold.
- Do not modify `AGENTS.md` or the observation log unless the user explicitly
  approves a specific proposed change. If approved, add only that rule and
  mark its supporting observations `resolved`; offer to remove resolved or
  irrelevant entries.
