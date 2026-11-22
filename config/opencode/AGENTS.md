# Global Agent Rules

## Uncertainty and verification

- FIRST: ground yourself in the workspace. Never guess CLI flags, library APIs,
  version behaviors, or config schemas from memory. Read local files, inspect
  existing repo code, or run `--help` before proposing changes.
- Before modifying files, writing task commands, or proposing configurations,
  check whether any critical requirements, environment details, or external API
  behaviors remain unverified after inspecting the workspace.
- If gaps or assumptions remain, output a `<verification>` block and STOP
  immediately:

  ```markdown
  <verification>
  - Verified: <facts confirmed from prompt or workspace>
  - Unverified: <specific flags, schemas, or behaviors not confirmed>
  - Assumptions: <any blanks you would otherwise guess>
  </verification>
  ```

- Read-only verification commands (such as `<tool> --help`, `man`, or file
  inspection) are always allowed; the stop rule applies to writes and generated
  solutions, not checking.
- Do not generate placeholder code, partial implementations, or best-guess
  commands when `Unverified` or `Assumptions` is non-empty. Ask the user to
  clarify or confirm before proceeding.

## Commit message style

- FIRST: match the repository's existing conventions. Scan recent commit history
  (and the project's AGENTS.md if present) and use the dominant style of that
  repo. Project-level rules override these global rules.
- Work repos (tickets): `TICKET-XXXX: <imperative verb> <specific what>` e.g.
  `TEAM-1255: Replace the legacy status helper with the ownership metric`
- Multiple tickets: `TICKET-A,TICKET-B: <subject>`
- No open ticket: use `XXX-0` with the Jira project relevant to the change
  (`PROJECT-0: ...` for your team's primary project; use the affected domain's
  prefix otherwise). Don't invent fake ticket numbers.
- Personal repos (GitHub issues): `Issue #N: <subject>`
- Personal repos (no issue): conventional style as used in that repo, e.g.
  `fix: ...`, `feat: ...`, `docs: ...`, `chore: ...`
- Imperative mood, capitalized verb (Add, Fix, Remove, Update, Replace, ...).
- Name the specific file/alert/entity when relevant.
- Body (when useful): blank line, then `- ` bullets explaining _why_, backticks
  around file/metric names, 2-space-indented nested bullets, trailing periods.
  Multi-ticket: one `- TICKET - explanation` bullet each.

## Writing style

- In any prose you draft or edit, use periods or commas instead of em dashes or
  semicolons to separate phrases or sentences. Dashes in other roles are fine.
  Do not sweep existing text outside your edits unless asked.
- Open a commit message body or MR/PR description with why the change is needed,
  then explain the approach and what changed.

## Commit organization

- One logical change per commit; each commit self-contained and standalone, with
  a reason it exists on its own.
- For stacked MR series, keep each MR's logically related changes in one
  review-friendly commit. Split only when the changes form distinct, meaningful
  review units.
- Prefer under 100 changed lines per commit (soft cap; hard max 150).
- Logical boundaries always take precedence over the line cap: never split a
  logical change just to fit, and never bundle unrelated changes together.
- No wip/mega-commits.
- Don't create trivial one-line commits; fold them into a related commit
  instead, so each commit earns its existence.

## Code changes

- Optimize code for readability and reviewability by an engineer with no
  context. Prefer the smallest implementation that meets the requirement, and
  keep comments focused on intent.
- Prefer focused, representative tests over exhaustive parameter matrices.

## Push / MR policy

- Work repos (GitLab): branch name
  `<username>/TICKET-XXXX/kebab-case-description` (or `<username>/kebab-case`
  when no ticket).
- GitHub repos: branch name `<issue #>/kebab-case-description` when an issue
  exists (e.g. `61/opencode-global-rules`), or `kebab-case-description` when
  not. Never include the username in GitHub branch names: it is implicit on
  personal repos, and only add it on GitHub when there is a critical mass of
  contributors (shared/team repos).
- Push the branch first, once it has at least one commit with a diff:
  `git push -u origin <branch>`. Do not push an empty branch for review. Do NOT
  create the GitLab MR / GitHub PR unless explicitly asked.
- Conditional authorization: when the user authorizes MR/PR creation on stated
  conditions (e.g. "create it if you're highly confident"), act autonomously
  once every condition holds; if any condition fails, stop and report instead of
  creating.
- Never push to main/master/default branches, unless the repository's own
  `AGENTS.md` documents a different push policy. The repository's policy wins.
- If the user says "just create the branch": create it locally, do not push;
  they'll review locally first.
- After pushing, report branch name and status, then stop.

## MR descriptions and test verification

- Omit `#validation` sections from MR descriptions.
- Use concrete, literal MR titles that name the actual change
  (`"Add docstring"`, not `"Document"`); keep MR descriptions succinct.
- When the user defers testing to CI ("let the CI run the tests"), do not run
  local tests during that iteration; push and let the MR pipeline validate.

## Unattended multi-step work

- Resolve or surface material unknowns before starting an approved autonomous
  run, so it never has to stop mid-run.
- When the user approves continued execution of a multi-step plan, request all
  required permissions upfront before continuing, so the work can proceed
  unattended.

## Sessions and workspace

- Work the topic the user named as the priority. Do not front-load
  de-prioritized work.
- For multi-session local work, keep a handoff or status document in the
  workspace so a fresh OpenCode session can continue without relying on chat
  history.
- Create durable ticket worktrees inside the ticket's working folder, not under
  `~/`.
- Do not kill or restart tmux or terminal sessions while other work may be
  active. Ask before any action that would stop them.

## MR reviews

- When an MR has reviewer or AI CI comments, read them and suggest reply text to
  the user where a reply adds value. NEVER post replies or resolve threads
  automatically.
- Not every comment needs a reply. Skip replies when the comment is
  self-evidently addressed by the code itself - e.g. a single change in the code
  alters the flagged behavior and the comment links to that changed code. In
  that case note "no reply needed" (or acknowledge briefly) and move on.
- When the user asks you to address a review, address all findings and nits in
  one pass, not only the major ones.

## Outbound communication

- Draft outbound comments, messages, and mentions for the user to post. Do not
  post them, tag people, or name individual reviewers without explicit approval.

## Ticket hygiene

- During an active implementation task, do not propose or create unrelated
  follow-up tickets; surface them only when asked.
- Do not create a Jira ticket unless the user explicitly asks for one. Approval
  to publish a document is not approval to create a ticket.
- Write Jira tickets in human, outcome-first language. Use a short outcome
  title, then describe the problem, the intent, and what done looks like. Keep
  evidence dumps and implementation detail out of the description.
- Jira text must stand alone, so a reader can get started without opening any
  other document. Link a shared document for more detail when one exists, but
  never depend on it, and never reference local files or their sections.

## Rule evolution

- This file is a living document, but never edit it on your own: propose changes
  via the observation log and `/review-global-rules`, and only apply them after
  explicit user approval.
- Project-specific conventions belong in that project's `AGENTS.md`, not here.

## Observation log

- Location: `~/.local/state/opencode/AGENTS-observations.md` (local state, never
  committed or synced).
- Record only explicit user instructions or corrections of your behavior. Never
  record model inference or user acceptance of your output.
- Record one observation per distinct task, at the end of the task. If the user
  says "note this as an observation", record it immediately.
- Group related observations beneath a `## Candidate: <pattern>` heading:
  ```markdown
  - status: collecting
  - scope: <where the pattern applies>
  - observations:
    - date: YYYY-MM-DD | task: <task> | repo: <repo> | confidence:
      explicit|repeated evidence: "<verbatim instruction or factual correction>"
  ```
- Candidates the user declines are marked `status: declined` with a `declined:`
  date and reason; the review skips them unless new distinct evidence emerges.
- `explicit` is an always/never-style directive. `repeated` is a recurring
  instruction or correction. `/review-global-rules` proposes explicit directives
  with 1-2 observations and repeated patterns with at least 3 independent
  observations.
- An observation is independent only when it comes from a distinct task. Do not
  count multiple instructions from one task more than once.
- The review command shows 2-observation near-misses and flags observations
  older than 6 months as `[stale]`; stale entries still count and the user
  decides their relevance.
- When a candidate reaches its threshold, mention it in the closing summary and
  suggest `/review-global-rules` when convenient. Never interrupt work.
- On approval, add the rule here and mark its supporting observations
  `resolved`. Resolved entries may be removed to keep the log compact.
