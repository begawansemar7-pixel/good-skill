# GoodSkill Automation Runbook

## Initial setup

From repository root:

```bash
claude
```

Then:

```text
Read AGENTS.md and docs/GOODSKILL_AGENT_ARCHITECTURE.md.

Do a read-only repository audit.
Do not change code.

Report:
1. current branch
2. current git status
3. current test status
4. highest-priority unblocked backlog item
5. required dependencies
6. risks
```

## Run one autonomous feature

Use:

```text
/goodskill-next
```

The agent should:
- select one task
- implement
- test
- review
- commit
- report

## Review

Use:

```text
/goodskill-review
```

## QA

Use:

```text
/goodskill-qa
```

## Recommended cadence

One feature:
- one feature branch
- one focused PR
- one review cycle

Avoid autonomous multi-epic changes.

## GitHub workflow

```text
feature branch
      |
      v
Claude implementation
      |
      v
QA
      |
      v
Reviewer
      |
      v
Pull Request
      |
      v
Human approval
      |
      v
develop
      |
      v
Vercel Preview
      |
      v
Staging validation
      |
      v
Human release approval
      |
      v
main
      |
      v
Vercel Production
```

## Emergency stop

Stop the agent if:
- unexpected production credentials appear
- migration is destructive
- payment behavior changes unexpectedly
- certificate rules change unexpectedly
- RLS is disabled
- tests reveal cross-tenant data
- agent modifies unrelated modules
- generated AI content is being published without approval
