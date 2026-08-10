# Global Git Workflow Rules

## Commit message style
- FIRST: match the repository's existing conventions. Scan recent commit
  history (and the project's AGENTS.md if present) and use the dominant
  style of that repo. Project-level rules override these global rules.
- Work repos (tickets): `TICKET-XXXX: <imperative verb> <specific what>`
  e.g. `TEAM-1255: Replace the legacy status helper with the ownership metric`
- Multiple tickets: `TICKET-A,TICKET-B: <subject>`
- No open ticket: use `XXX-0` with the Jira project relevant to the change
  (`PROJECT-0: ...` for your team's primary project; use the affected domain's
  prefix otherwise). Don't invent fake ticket numbers.
- Personal repos (GitHub issues): `Issue #N: <subject>`
- Personal repos (no issue): conventional style as used in that repo,
  e.g. `fix: ...`, `feat: ...`, `docs: ...`, `chore: ...`
- Imperative mood, capitalized verb (Add, Fix, Remove, Update, Replace, ...).
- Name the specific file/alert/entity when relevant.
- Body (when useful): blank line, then `- ` bullets explaining *why*,
  backticks around file/metric names, 2-space-indented nested bullets,
  trailing periods. Multi-ticket: one `- TICKET - explanation` bullet each.

## Commit organization
- One logical change per commit; each commit self-contained and standalone,
  with a reason it exists on its own.
- Prefer under 100 changed lines per commit (soft cap; hard max 150).
- Logical boundaries always take precedence over the line cap: never split a
  logical change just to fit, and never bundle unrelated changes together.
- No wip/mega-commits.
- Don't create trivial one-line commits; fold them into a related commit
  instead, so each commit earns its existence.

## Push / MR policy
- Work repos (GitLab): branch name `<username>/TICKET-XXXX/kebab-case-description`
  (or `<username>/kebab-case` when no ticket).
- GitHub repos: branch name `<issue #>/kebab-case-description` when an issue
  exists (e.g. `61/opencode-global-rules`), or `kebab-case-description` when
  not. Never include the username in GitHub branch names: it is implicit on
  personal repos, and only add it on GitHub when there is a critical mass of
  contributors (shared/team repos).
- Push the branch first: `git push -u origin <branch>`. Do NOT create the
  GitLab MR / GitHub PR unless explicitly asked.
- Conditional authorization: when the user authorizes MR/PR creation on
  stated conditions (e.g. "create it if you're highly confident"), act
  autonomously once every condition holds; if any condition fails, stop and
  report instead of creating.
- Never push to main/master/default branches.
- If the user says "just create the branch": create it locally, do not push;
  they'll review locally first.
- After pushing, report branch name and status, then stop.

## MR descriptions and test verification
- Omit `#validation` sections from MR descriptions.
- Use concrete, literal MR titles that name the actual change (`"Add
  docstring"`, not `"Document"`); keep MR descriptions succinct.
- When the user defers testing to CI ("let the CI run the tests"), do not run
  local tests during that iteration; push and let the MR pipeline validate.

## Unattended multi-step work
- When the user approves continued execution of a multi-step plan, request
  all required permissions upfront before continuing, so the work can
  proceed unattended.

## MR review replies
- When an MR has reviewer or AI CI comments, read them and suggest reply
  text to the user where a reply adds value. NEVER post replies or resolve
  threads automatically.
- Not every comment needs a reply. Skip replies when the comment is
  self-evidently addressed by the code itself - e.g. a single change in the
  code alters the flagged behavior and the comment links to that changed
  code. In that case note "no reply needed" (or acknowledge briefly) and
  move on.

## Ticket hygiene
- During an active implementation task, do not propose or create unrelated
  follow-up tickets; surface them only when asked.

## Rule evolution
- This file is a living document, but never edit it on your own: propose
  changes via the observation log and `/review-global-rules`, and only apply
  them after explicit user approval.
- Project-specific conventions belong in that project's `AGENTS.md`, not here.

## Observation log
- Location: `~/.local/state/opencode/AGENTS-observations.md` (local state,
  never committed or synced).
- Record only explicit user instructions or corrections of your behavior.
  Never record model inference or user acceptance of your output.
- Record one observation per distinct task, at the end of the task. If the
  user says "note this as an observation", record it immediately.
- Group related observations beneath a `## Candidate: <pattern>` heading:
  ```markdown
  - status: collecting
  - scope: <where the pattern applies>
  - observations:
    - date: YYYY-MM-DD | task: <task> | repo: <repo> | confidence: explicit|repeated
      evidence: "<verbatim instruction or factual correction>"
  ```
- Candidates the user declines are marked `status: declined` with a
  `declined:` date and reason; the review skips them unless new distinct
  evidence emerges.
- `explicit` is an always/never-style directive. `repeated` is a recurring
  instruction or correction. `/review-global-rules` proposes explicit
  directives with 1-2 observations and repeated patterns with at least 3
  independent observations.
- An observation is independent only when it comes from a distinct task.
  Do not count multiple instructions from one task more than once.
- The review command shows 2-observation near-misses and flags observations
  older than 6 months as `[stale]`; stale entries still count and the user
  decides their relevance.
- When a candidate reaches its threshold, mention it in the closing summary
  and suggest `/review-global-rules` when convenient. Never interrupt work.
- On approval, add the rule here and mark its supporting observations
  `resolved`. Resolved entries may be removed to keep the log compact.
