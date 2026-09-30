# GoodSkill Development Package

This package converts the GoodSkill PRD into an implementation baseline.

## Files

All paths are relative to this directory (`docs/goodskill/`) unless noted.

- `AGENTS.md` — GoodSkill development agent rules (read before any GoodSkill work)
- `GOODSKILL_PRD.md` — product + technical requirements
- `../../supabase/goodskill/SUPABASE_SCHEMA.draft.sql` — GoodSkill extension schema (**draft, not a migration**; see below)
- `GOODSKILL_BACKLOG.md` — epics and delivery backlog
- `GOODSKILL_USER_STORIES.md` — user stories and acceptance criteria
- `LMS_FRONT_MAPPING.md` — mapping from GoodSkill requirements to lms-front
- `GOODSKILL_AGENT_ARCHITECTURE.md`, `GOODSKILL_AGENT_STATE.md`, `GOODSKILL_AUTOMATION_RUNBOOK.md`, `GOODSKILL_FORK_PUSH_RUNBOOK.md`, `GOODSKILL_CLAUDE_CODE_*.md` — agent process and runbooks

## Draft schema status

`SUPABASE_SCHEMA.draft.sql` is kept outside `supabase/migrations/` on purpose. Before it becomes a migration:

- verify every referenced lms-front table/column (`tenants`, `profiles`, `courses`, `transactions`) against `supabase/migrations/`
- enable RLS on the tables it currently omits (competency, diagnostic, assessment template and certification rule tables)
- add policies following lms-front's tenant/RLS model — the draft defines none

## Recommended base

Fork:

`https://github.com/guillermoscript/lms-front`

The repository already contains the LMS primitives required by GoodSkill: multi-tenancy, course/lesson management, exams, progress, commerce, entitlements, revenue infrastructure, certificates, gamification and AI Tutor/MCP.

Use:

`https://github.com/course-code-framework/coursecode`

as an authoring/export component/reference for AI-assisted course production and portable formats.

## Immediate next steps

1. Fork `lms-front` into the GoodSkill organization.
2. Create a GoodSkill Supabase project.
3. Run the existing migrations and verify baseline tests.
4. Apply GoodSkill migrations in a separate migration sequence.
5. Implement E01 → E03 first.
6. Implement diagnostic and learning path.
7. Implement AI Content Factory after the competency model is stable.
8. Keep SME approval as a mandatory publication gate.
9. Integrate Indonesian payment provider after commerce model is validated.
10. Deploy to a staging Vercel project before production.

## Important

Do not overwrite existing lms-front tables or payment logic without first confirming their current implementation and RLS behavior.
