# GOODSKILL_CLAUDE_CODE_DEVELOPMENT_GUIDE.md

## 0. Objective

Build GoodSkill in:

`https://github.com/begawansemar7-pixel/good-skill`

starting from the MIT-licensed:

`https://github.com/guillermoscript/lms-front`

Do not rebuild generic LMS capabilities. Reuse the base application, then add GoodSkill-specific domain capabilities:
- UMKM Profile
- Competency Framework
- AI Diagnostic
- Personalized Learning Journey
- Stage Certification
- AI Content Factory
- SME Approval
- Skill Passport
- Creator Revenue 20%
- Indonesia payment adapter
- Program/Cohort
- Business Impact
- HUBUNK/PCD integration

`lms-front` currently documents Next.js 16, React 19, TypeScript, Supabase/Postgres/RLS, Tailwind v4, Stripe Connect, AI Tutor/MCP, certificates, gamification, community, i18n and multiple payment rails. Its default branch is `master`.

---

# 1. Prerequisites

Install/check:

```bash
node -v
npm -v
git --version
docker --version
supabase --version
claude --version
```

Recommended:
- Node.js 20+
- Docker Desktop
- Supabase CLI
- Claude Code
- GitHub CLI (`gh`) optional but useful
- VS Code

---

# 2. Repository Strategy

Recommended local remotes:

```text
good-skill/
├── upstream: guillermoscript/lms-front
└── origin:   begawansemar7-pixel/good-skill
```

Use:
- `main` = stable
- `develop` = integration
- feature branches = implementation

Branch convention:

```text
feat/<scope>-<short-name>
fix/<scope>-<short-name>
chore/<scope>-<short-name>
docs/<scope>-<short-name>
```

Examples:

```text
feat/goodskill-competency-framework
feat/goodskill-ai-diagnostic
feat/goodskill-content-factory
```

---

# 3. Bootstrap the Repository

Because `good-skill` is already an empty repository, clone the upstream repo locally and point `origin` to the target repo.

```bash
mkdir -p ~/Projects
cd ~/Projects

git clone https://github.com/guillermoscript/lms-front.git good-skill
cd good-skill

git remote rename origin upstream
git remote add origin https://github.com/begawansemar7-pixel/good-skill.git

git remote -v
```

Expected:

```text
origin   https://github.com/begawansemar7-pixel/good-skill.git
upstream https://github.com/guillermoscript/lms-front.git
```

Push the upstream default branch to the target `main`:

```bash
git push -u origin master:main
```

Then align the local branch:

```bash
git branch -M main
git fetch origin
git branch --set-upstream-to=origin/main main
```

Create development branch:

```bash
git checkout -b develop
git push -u origin develop
```

Preserve the upstream MIT license and relevant attribution/notices.

---

# 4. First Claude Code Session — Repository Recon

Start:

```bash
cd ~/Projects/good-skill
claude
```

Paste:

## PROMPT 01 — RECON

You are the lead engineer for GoodSkill.

We are building an AI-powered competency, learning and certification platform for Indonesian UMKM.

The current repository is based on:
https://github.com/guillermoscript/lms-front

Before modifying code, perform a read-only architecture audit.

Tasks:
1. Inspect repository structure.
2. Read CLAUDE.md.
3. Read README.md.
4. Read docs/GETTING_STARTED.md.
5. Read docs/DATABASE_SCHEMA.md.
6. Read docs/AUTH.md.
7. Read docs/MONETIZATION.md.
8. Inspect Supabase migrations.
9. Identify auth, tenant, course, lesson, exam, progress, certificate, payment, revenue, gamification and AI Tutor implementations.
10. Identify existing tables we should reuse.
11. Identify naming conventions and folder conventions.
12. Identify existing test commands.
13. Identify incompatibilities with the GoodSkill PRD.

Do NOT change files.

Produce:
A. architecture map
B. existing capability inventory
C. reuse/extend/build-new matrix
D. database dependency map
E. migration risks
F. recommended implementation order
G. list of files that GoodSkill will likely add/change

Do not invent repository facts. Quote exact file paths when possible.

Expected artifact:
`docs/GOODSKILL_ARCHITECTURE_AUDIT.md`

---

# 5. Add Claude Code Project Instructions

Create/replace project-level `CLAUDE.md` with GoodSkill-specific engineering rules, while preserving useful upstream conventions.

Use:

```bash
cp CLAUDE.md CLAUDE.upstream.md
```

Then ask Claude:

## PROMPT 02 — CLAUDE RULES

Read `CLAUDE.upstream.md`.

Create a new `CLAUDE.md` for GoodSkill.

Preserve all valid upstream architecture conventions, especially:
- Next.js App Router
- Supabase/RLS
- tenant resolution
- auth
- payment patterns
- migration discipline
- test commands

Add GoodSkill-specific rules:

1. GoodSkill is an AI-powered competency, learning and certification platform for Indonesian UMKM.
2. Core journey:
   Diagnose -> Learning Journey -> Practice -> Assessment -> Certification -> Skill Passport -> Business Impact
3. Reuse existing lms-front capabilities before creating replacements.
4. GoodSkill-specific domains:
   - UMKM
   - Competency
   - Diagnostic
   - Learning Journey
   - AI Content Factory
   - SME Approval
   - Practical Assessment
   - Stage Certification
   - Skill Passport
   - Creator Economy
   - Business Impact
   - Program Management
   - HUBUNK/PCD integrations
5. New database tables should use `gs_` naming where appropriate.
6. Preserve tenant isolation and RLS.
7. Server-side secrets only.
8. AI-generated content must be versioned and auditable.
9. AI content cannot be published without SME approval.
10. AI cannot be authoritative for payment status, certification eligibility, or source competency scores.
11. Creator revenue is calculated server-side; target creator share is 20%.
12. Payment webhooks must be idempotent.
13. Public Skill Passport/certificate pages must expose only safe data.
14. Every feature must have tests and docs.

Do not remove useful upstream rules.

---

# 6. Baseline Run

Before changing application behavior:

```bash
npm install
cp .env.example .env.local

supabase start
supabase status
npm run db:reset
npm run db:types
npm run dev
```

Use:

`http://lvh.me:3000`

for the baseline app because the upstream implementation resolves tenant through the subdomain.

Run:

```bash
npm run typecheck
npm run lint
npm run test:unit
npm run build
```

Record any pre-existing failures before continuing.

## PROMPT 03 — BASELINE HEALTH CHECK

Run the baseline checks.

Do not fix unrelated upstream defects yet.

Create:
`docs/BASELINE_HEALTH.md`

Record:
- commands run
- passed checks
- pre-existing failures
- warnings
- risk assessment
- recommended next action

---

# 7. Documentation Baseline

Create:

```text
docs/
├── GOODSKILL_ARCHITECTURE.md
├── GOODSKILL_DATABASE.md
├── GOODSKILL_AI_ARCHITECTURE.md
├── GOODSKILL_CONTENT_WORKFLOW.md
├── GOODSKILL_CERTIFICATION.md
├── GOODSKILL_REVENUE.md
├── GOODSKILL_SECURITY.md
└── GOODSKILL_BACKLOG.md
```

## PROMPT 04 — DOCUMENTATION

Read:
- GOODSKILL_PRD.md
- GOODSKILL_ARCHITECTURE_AUDIT.md
- CLAUDE.md
- upstream database/auth/monetization docs

Create the GoodSkill documentation files above.

Rules:
- Use exact verified existing file/table names.
- Clearly mark REUSE / EXTEND / BUILD.
- Do not invent upstream implementation details.
- Explain migration dependencies and RLS.
- Document boundaries between generic LMS and GoodSkill domain logic.

---

# 8. Database: UMKM + Competency

Create the migration:

```bash
supabase migration new goodskill_umkm_competency
```

## PROMPT 05 — UMKM + COMPETENCY

Implement only the foundation for:
- UMKM profile
- competency domains
- competencies
- stages
- stage competency requirements
- course-to-competency mapping

Before SQL:
1. Inspect existing `profiles`, `tenants`, `tenant_users`, `courses`.
2. Confirm actual FK types.
3. Confirm existing RLS patterns.
4. Do not create duplicate generic tables.

Requirements:
- UUID PKs for GoodSkill domain tables unless existing FK constraints dictate otherwise.
- tenant-aware rows where appropriate.
- RLS enabled.
- seed START/GROW/SCALE/EXPORT/CHAMPION.
- deterministic competency services.

Create:
`lib/goodskill/competency/`

Suggested functions:
- `calculateCompetencyScore`
- `calculateCompetencyGap`
- `calculateStageProgress`
- `getRequiredCompetenciesForStage`
- `getNextStage`

Do not use LLM for authoritative score calculation.

Add unit tests.
Run:
`npm run db:reset`
`npm run db:types`
`npm run typecheck`

---

# 9. AI Diagnostic

Create migration:

```bash
supabase migration new goodskill_diagnostic
```

## PROMPT 06 — DIAGNOSTIC

Implement GoodSkill AI Diagnostic.

Flow:
Intro -> questions -> progress -> submit -> results.

Requirements:
- questions map to competencies
- answers are persisted
- deterministic scoring
- AI summary
- gap analysis
- recommended learning priorities
- resumable progress

Rules:
- AI must not invent scores.
- underlying scores are computed by deterministic code.
- AI only summarizes/recommends from stored results.
- server-side authorization is mandatory.
- tenant isolation is mandatory.

Result UI must show:
- domain score
- competency score
- competency gap
- recommended stage
- top learning priorities

Add unit tests and an E2E flow.

---

# 10. Learning Journey

## PROMPT 07 — LEARNING JOURNEY

Implement personalized GoodSkill Learning Journey.

Inputs:
- UMKM profile
- competency scores
- competency gaps
- current stage
- completed courses

Outputs:
- required courses
- recommended courses
- optional courses
- ordering
- rationale

Use existing lms-front courses/lessons/progress/entitlement models.

Add a course-to-competency mapping table.

Requirements:
- never recommend unauthorized content
- preserve completed content when journey is regenerated
- deterministic recommendation service
- explain why each recommendation was selected

UX:
- current stage
- competency map
- path
- course cards
- progress
- next action

---

# 11. Stage Certification

## PROMPT 08 — CERTIFICATION

Build GoodSkill stage certification on top of the existing certificate infrastructure.

Reuse existing certificate generation and public verification where possible.

Add:
- certification rules
- stage certification state
- eligibility engine

Eligibility can include:
- required courses
- quiz/exam threshold
- assignments
- practical assessment
- competency requirements

Rules:
- browser-submitted scores are never trusted.
- eligibility is checked server-side.
- no certificate without meeting configured requirements.
- certificate has unique ID and public verification.
- revocation state is supported.

Tests:
- fail case
- pass case
- duplicate issue prevention
- verification
- revocation

---

# 12. Creator Studio

## PROMPT 09 — CREATOR STUDIO

Implement creator workflow:

Topic -> AI Generate -> Edit -> SME Review -> Approve -> Publish

Topic brief:
- topic/title
- audience
- level
- duration
- competency
- intended business outcome

Use existing teacher/creator identity where practical.

Build:
- creator dashboard
- content job
- artifact list
- editor
- review status
- publish workflow

Do not duplicate generic course authoring unnecessarily.

---

# 13. AI Content Factory

## PROMPT 10 — AI CONTENT FACTORY

Implement an asynchronous GoodSkill AI content pipeline.

Pipeline:
1. Research Agent
2. Curriculum Agent
3. Narrative Agent
4. Slide Agent
5. Quiz Agent
6. Assignment Agent
7. Video Script Agent
8. QA Agent

MVP:
- learning objectives
- outline
- narrative
- quiz
- assignment

P1:
- slides
- video script
- video provider integration

Every artifact must store:
- artifact type
- version
- model
- prompt version
- sources
- status
- reviewer
- timestamps

Requirements:
- background/async jobs
- retry
- failure recovery
- structured JSON validation
- server-only API keys
- source references
- audit trail

Do not provide a direct publish shortcut.

---

# 14. SME Approval

## PROMPT 11 — SME APPROVAL

Implement the state machine:

DRAFT
-> AI_GENERATED
-> AI_QA
-> SME_REVIEW
-> REVISION
-> APPROVED
-> PUBLISHED

Requirements:
- only authorized SME can approve
- creator can edit before approval
- all versions remain auditable
- rejected versions remain visible in audit history
- server-side publish blocks unapproved content
- modifying an APPROVED artifact resets approval
- publish event stores actor and timestamp

Add unit/E2E tests.

---

# 15. AI Video

## PROMPT 12 — VIDEO PROVIDER ABSTRACTION

Create provider-agnostic video generation:

`lib/goodskill/ai/video/`

Use a contract similar to:

```ts
interface VideoProvider {
  generateVideo(input: VideoGenerationInput): Promise<VideoGenerationResult>
}
```

MVP:
- script
- scene list
- narration contract
- async job status

P1:
- avatar
- TTS
- subtitles
- rendered video URL

Do not tie GoodSkill database design directly to one provider.

---

# 16. AI Tutor

## PROMPT 13 — AI TUTOR

Extend the existing lms-front AI Tutor.

GoodSkill context:
- approved lesson content
- current stage
- competency gaps
- current course
- recommended learning path

Tutor capabilities:
- answer questions
- cite source lesson where available
- explain weak areas
- recommend remediation
- recommend next course

Rules:
- tenant-scoped retrieval
- no private cross-tenant context
- no secret keys in client
- only approved content enters learner knowledge context

---

# 17. Creator Revenue 20%

## PROMPT 14 — CREATOR REVENUE

Reuse lms-front's commerce/revenue infrastructure.

GoodSkill business rule:
- target creator share = 20%

Implement:
- creator/course association
- immutable revenue snapshot
- creator amount
- platform amount
- refund adjustment
- payout status
- creator dashboard

Calculate revenue server-side.

Document the settlement basis explicitly:
- gross revenue OR
- net revenue after specified fees/refunds/tax/chargebacks

Do not leave this ambiguous in production.

Tests:
- successful purchase
- duplicate webhook
- refund
- payout calculation

---

# 18. Indonesian Payment Provider Adapter

## PROMPT 15 — PAYMENT ADAPTER

Inspect existing lms-front payment abstraction first.

Add one Indonesian provider adapter selected by the business:
- Xendit
- DOKU
- Finnet

Do not hard-code provider-specific logic in course domain.

Architecture:

Payment Service
-> Provider Adapter
-> Provider API

Requirements:
- create payment
- verify webhook
- idempotency
- transaction status
- refund/cancel when supported
- logging without exposing secrets

---

# 19. Skill Passport

## PROMPT 16 — SKILL PASSPORT

Implement:
- private Skill Passport
- public Skill Passport
- competency scores
- stage statuses
- certificates
- verification
- shareable slug

Public view must expose only safe verification fields.

Add:
- QR link
- certificate validity state
- revocation state

Security test:
private data must never be returned by public endpoint.

---

# 20. Program / Cohort

## PROMPT 17 — PROGRAM MANAGEMENT

Implement sponsor/program management.

Program:
- sponsor
- dates
- seats
- target stage
- required learning
- required certification

Dashboard:
- enrolled
- active
- completed
- certified
- competency improvement

Tenant isolation required.

---

# 21. Business Impact

## PROMPT 18 — BUSINESS IMPACT

Implement:
- baseline metrics
- post-learning metrics
- source type
- verification status
- change/delta

Example metrics:
- revenue
- digital sales
- customer count
- employee count
- productivity

Rules:
- self-reported values are visibly labeled
- verified values show source
- no unsupported causal claim
- analytics distinguishes self-reported and verified data

---

# 22. UX Rebrand

## PROMPT 19 — GOODSKILL UX

Rebrand the experience for Indonesian UMKM.

Learner navigation:
- Beranda
- Learning Journey
- Belajar
- Diagnostic
- Sertifikasi
- Skill Passport
- AI Tutor

Creator:
- Dashboard
- Content Studio
- Draft
- Review
- Published
- Revenue

Admin:
- UMKM
- Competency
- Courses
- Content Review
- Certification
- Creators
- Programs
- Revenue
- Analytics

Use existing shadcn/ui patterns.
Mobile-first.
Do not rewrite unrelated upstream UI.

---

# 23. Testing and Verification

After each feature:

```bash
npm run typecheck
npm run lint
npm run test:unit
npm run build
```

Browser:

```bash
npx playwright test
```

Critical E2E journeys:
1. register/profile
2. diagnostic
3. learning journey
4. payment
5. learning
6. certification
7. public verification
8. creator AI generation
9. SME approval
10. creator revenue

## PROMPT 20 — SECURITY/QUALITY REVIEW

Review the implemented GoodSkill feature.

Check:
- TypeScript
- authorization
- RLS
- tenant isolation
- data leakage
- secret handling
- payment idempotency
- migration safety
- AI auditability
- accessibility
- mobile UX
- loading states
- error states
- empty states
- unit tests
- E2E tests

Read actual changed files.

Return:
- finding
- severity
- exact file
- fix
- pre-merge requirement

Fix P0/P1 findings.
Do not refactor unrelated code.

---

# 24. Git Workflow

Feature development:

```bash
git checkout develop
git pull origin develop
git checkout -b feat/goodskill-competency
```

Inspect changes:

```bash
git status
git diff --stat
git diff
```

Validate:

```bash
npm run typecheck
npm run lint
npm run test:unit
```

Commit:

```bash
git add .
git commit -m "feat(goodskill): add competency framework"
git push -u origin feat/goodskill-competency
```

Recommended PR sequence:

1. bootstrap
2. competency
3. diagnostic
4. learning journey
5. certification
6. creator studio
7. AI content factory
8. SME approval
9. creator revenue
10. payment
11. skill passport
12. AI tutor
13. programs
14. business impact

---

# 25. Release Order

## Release 0 — Foundation
- fork
- baseline
- docs
- CI/CD

## Release 1 — GoodSkill Core
- UMKM profile
- competency
- diagnostic
- learning journey
- certification

## Release 2 — Creator AI
- creator studio
- AI content factory
- SME approval

## Release 3 — Commercial
- course purchase
- certification purchase
- creator 20%
- payout
- Indonesia payment

## Release 4 — AI Learning
- AI Tutor
- remediation
- Skill Passport

## Release 5 — Ecosystem
- programs
- HUBUNK
- PCD
- business impact

---

# 26. Upstream Sync

Keep upstream as a remote:

```bash
git fetch upstream
```

Inspect divergence:

```bash
git log --oneline upstream/master..main
```

Sync carefully:

```bash
git checkout develop
git fetch upstream
git merge upstream/master
```

Pay special attention to:
- Supabase migrations
- auth/RLS
- payment code
- AI Tutor/MCP
- Next.js upgrades

Do not routinely rebase shared `develop`/`main` branches.

---

# 27. Minimum GoodSkill Demo

The first end-to-end demo should work as:

```text
UMKM registers
  ↓
creates business profile
  ↓
takes diagnostic
  ↓
gets competency profile
  ↓
gets learning journey
  ↓
buys course
  ↓
learns
  ↓
takes quiz
  ↓
passes
  ↓
gets START certification
  ↓
Skill Passport updates
```

Creator demo:

```text
Creator logs in
  ↓
submits topic
  ↓
AI generates objectives + narrative + quiz
  ↓
creator edits
  ↓
SME approves
  ↓
course publishes
  ↓
UMKM purchases
  ↓
20% creator share is recorded
```

This is the core GoodSkill product loop.
