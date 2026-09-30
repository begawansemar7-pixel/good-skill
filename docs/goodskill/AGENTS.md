# GoodSkill AI Development Agent

## Mission

Build and maintain GoodSkill automatically from the existing `lms-front` foundation.

Primary repository:

`https://github.com/begawansemar7-pixel/good-skill`

GoodSkill is an AI-powered competency, learning and certification platform for Indonesian UMKM.

Core journey:

`Diagnose → Learning Journey → Learn → Practice → Assess → Certify → Skill Passport → Business Impact`

## Operating principle

The agent is autonomous for implementation work but human-controlled for:
- production deployment
- production database migrations
- financial/payment changes
- certificate policy changes
- destructive database operations
- merging to `main`

## Reuse before rebuild

Prefer existing lms-front capabilities:
- authentication
- tenant management
- RLS
- courses
- lessons
- exams
- progress
- commerce
- entitlements
- certificates
- revenue
- gamification
- AI Tutor

Build GoodSkill-specific domain logic:
- UMKM profile
- competency framework
- diagnostic
- personalized journey
- AI content factory
- SME approval
- practical assessment
- stage certification
- Skill Passport
- creator economy
- business impact
- program/cohort

## Coding rules

1. Read existing implementation before changing it.
2. Never invent existing table names or APIs.
3. Preserve existing tenant isolation.
4. Preserve RLS.
5. Prefer additive migrations.
6. Never expose service-role credentials to browser code.
7. AI output is non-authoritative until reviewed.
8. AI cannot directly publish content.
9. AI cannot directly issue certificates.
10. AI cannot directly mark payment successful.
11. AI cannot directly alter authoritative competency scores.
12. Creator revenue is calculated server-side.
13. Payment webhooks must be idempotent.
14. Long AI/video tasks must be asynchronous.
15. Every AI artifact must be versioned and auditable.
16. Every feature needs tests.
17. Do not refactor unrelated code.

## Git rules

- `main`: production
- `develop`: integration
- feature branches: implementation

Never force-push.
Never reset another developer's branch.
Never commit secrets.

Feature branch naming:

`feat/gs-<issue>-<slug>`

Commit convention:

`feat(goodskill): ...`
`fix(goodskill): ...`
`chore(goodskill): ...`
`docs(goodskill): ...`
`test(goodskill): ...`

## Definition of Done

A task is complete only when:
- implementation exists
- acceptance criteria are satisfied
- typecheck passes
- lint passes
- relevant tests pass
- migration is included when required
- RLS/authorization is checked
- docs are updated when behavior changes
- git diff is reviewed
- no secrets are introduced
- residual risks are reported

## Stop conditions

Stop and request human approval if:
- production DB changes are required
- destructive migration is proposed
- payment behavior changes
- revenue split changes
- certificate issuance policy changes
- legal/compliance policy is ambiguous
- an external provider requires credentials not present
- acceptance criteria conflict
- security vulnerability is found and scope is unclear

## Agent workflow

`DISCOVER → PLAN → IMPLEMENT → TEST → REVIEW → DOCUMENT → COMMIT → PR`

Never skip REVIEW.
