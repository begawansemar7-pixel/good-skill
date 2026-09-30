# LMS_FRONT_MAPPING.md

## Source repositories

- Base LMS: `https://github.com/guillermoscript/lms-front`
- Authoring framework: `https://github.com/course-code-framework/coursecode`

`lms-front` currently provides a mature base including multi-tenancy, courses/lessons, exercises/exams, progress, commerce, entitlements, revenue splits, certificates, gamification, community and AI Tutor/MCP. Its documented schema contains 116 public tables. 

---

# 1. Reuse Matrix

| GoodSkill requirement | lms-front asset | Action |
|---|---|---|
| Auth | Supabase Auth / profiles | REUSE |
| Multi-tenancy | tenants / tenant_users / RLS | REUSE |
| Roles | roles / permissions / user_roles | REUSE + extend |
| Courses | courses | REUSE |
| Lessons | lessons | REUSE |
| Exercises | exercises | REUSE |
| Exams | exams / exam_questions | REUSE |
| Progress | enrollments / lesson_completions | REUSE |
| Course access | entitlements | REUSE |
| Commerce | products / transactions | REUSE + Indonesia provider |
| Revenue | revenue_splits / payouts | REUSE + creator ledger |
| Certificates | certificates / certificate_templates | REUSE + stage certification |
| Gamification | gamification_* | REUSE |
| Community | community_* | REUSE |
| AI Tutor | course_ai_tutors / MCP | REUSE + GoodSkill context |
| AI Content Factory | lessons_ai_tasks / prompt_templates + new GoodSkill layer | EXTEND |
| Creator profile | creators / teacher role + new gs_creators | EXTEND |
| UMKM profile | none equivalent | BUILD |
| Competency framework | none | BUILD |
| Diagnostic | none | BUILD |
| Learning Journey | none | BUILD |
| Stage Certification | course certificate exists; stage layer absent | BUILD |
| Skill Passport | none | BUILD |
| Business Impact | none | BUILD |
| Creator royalty 20% | revenue infrastructure exists | EXTEND |
| SME approval | content workflow absent | BUILD |
| Program/cohort | partial tenant capability | BUILD |
| PCD Academy | none | BUILD |
| HUBUNK integration | none | BUILD |

---

# 2. Suggested repository structure

```text
goodskill/
├── app/
│   └── [locale]/
│       ├── dashboard/
│       │   ├── learner/
│       │   ├── creator/
│       │   ├── sme/
│       │   └── admin/
│       ├── diagnostic/
│       ├── journey/
│       ├── skill-passport/
│       ├── creator-studio/
│       ├── certification/
│       └── programs/
│
├── components/
│   └── goodskill/
│       ├── diagnostic/
│       ├── journey/
│       ├── competency/
│       ├── creator/
│       ├── certification/
│       └── skill-passport/
│
├── lib/
│   └── goodskill/
│       ├── competency/
│       ├── diagnostic/
│       ├── learning-path/
│       ├── certification/
│       ├── creator/
│       ├── commerce/
│       ├── ai/
│       └── impact/
│
├── supabase/
│   └── migrations/
│       ├── 001_goodskill_umkm.sql
│       ├── 002_goodskill_competency.sql
│       ├── 003_goodskill_diagnostic.sql
│       ├── 004_goodskill_learning_path.sql
│       ├── 005_goodskill_content_factory.sql
│       ├── 006_goodskill_assessment.sql
│       ├── 007_goodskill_certification.sql
│       ├── 008_goodskill_creator_revenue.sql
│       └── 009_goodskill_programs.sql
│
└── docs/
    ├── GOODSKILL_PRD.md
    ├── GOODSKILL_BACKLOG.md
    ├── GOODSKILL_USER_STORIES.md
    └── LMS_FRONT_MAPPING.md
```

---

# 3. Existing lms-front areas to inspect first

Before coding, team should read:

1. `CLAUDE.md`
2. `docs/DATABASE_SCHEMA.md`
3. `docs/AUTH.md`
4. `docs/MONETIZATION.md`
5. `docs/MCP_SETUP.md`
6. existing `supabase/migrations`
7. existing dashboard routes
8. existing certificate implementation
9. existing revenue implementation

Do not duplicate an existing capability before verifying its current implementation.

---

# 4. Critical integration rules

## Courses
Use existing `courses`, `lessons`, `exercises`, `exams`.

Add GoodSkill metadata through extension tables rather than rewriting core LMS tables.

## Competency mapping
Map course → competency using a GoodSkill relation table.

Recommended additional table:

```sql
gs_course_competencies (
  course_id bigint references courses(id),
  competency_id uuid references gs_competencies(id),
  contribution_weight numeric
)
```

## Creator
Use existing teacher/creator mechanisms where possible, but maintain `gs_creators` as the business identity layer.

## Revenue
Do not calculate creator revenue in the browser.

Revenue percentage and amount must be calculated server-side and snapshotted on transaction.

## Certificates
Reuse existing certificate generation and verification, but add stage eligibility through `gs_certification_rules` and `gs_stage_certifications`.

## AI
Existing lms-front AI Tutor is a foundation, not the GoodSkill Content Factory.

GoodSkill should create an orchestration layer:

```text
AI Orchestrator
 ├── Research
 ├── Curriculum
 ├── Narrative
 ├── Slides
 ├── Quiz
 ├── Assignment
 ├── Video
 └── QA
```

---

# 5. CourseCode integration strategy

Do not fork CourseCode into the LMS core initially.

Use it as an authoring/export subsystem.

Possible flow:

```text
GoodSkill Creator Studio
        ↓
AI Content Factory
        ↓
Approved Outline
        ↓
CourseCode project/package
        ↓
Preview / QA
        ↓
GoodSkill LMS course
```

CourseCode supports SCORM 1.2, SCORM 2004, cmi5 and LTI 1.3, plus AI-assisted authoring, interactions and TTS. This makes it useful for portable authoring and future interoperability.

---

# 6. Recommended API boundaries

### Learner
- `GET /api/goodskill/profile`
- `POST /api/goodskill/diagnostic/start`
- `POST /api/goodskill/diagnostic/answer`
- `POST /api/goodskill/diagnostic/complete`
- `GET /api/goodskill/journey`
- `GET /api/goodskill/competencies`
- `GET /api/goodskill/passport`

### Creator
- `POST /api/goodskill/content/jobs`
- `POST /api/goodskill/content/jobs/:id/generate`
- `POST /api/goodskill/content/jobs/:id/regenerate`
- `GET /api/goodskill/content/jobs/:id`
- `POST /api/goodskill/content/artifacts/:id/approve`
- `POST /api/goodskill/content/artifacts/:id/reject`

### Assessment
- `POST /api/goodskill/assessments/:id/submit`
- `POST /api/goodskill/assessments/:id/evaluate`

### Certification
- `POST /api/goodskill/certifications/:stage/check`
- `GET /api/goodskill/certificates/:id`
- `GET /api/goodskill/verify/:certificateId`

### Creator revenue
- `GET /api/goodskill/creator/revenue`
- `GET /api/goodskill/creator/payouts`

---

# 7. Security model

Use lms-front's Supabase RLS model as baseline.

Rules:
- UMKM sees only its own profile, scores, path and private metrics.
- Creator sees only own content/revenue.
- SME sees assigned review queue.
- Program Manager sees only its organization/program.
- Public certificate verification exposes only verification-safe fields.
- Admin has controlled elevated access.
- AI service credentials are server-side only.

---

# 8. First development sequence

### Sprint 0
Fork + local Supabase + CI/CD + baseline tests.

### Sprint 1
UMKM profile + competency schema.

### Sprint 2
Diagnostic + scoring.

### Sprint 3
Learning path + course competency mapping.

### Sprint 4
Stage certification.

### Sprint 5
Creator Studio + topic submission.

### Sprint 6
AI Content Factory: narrative + quiz.

### Sprint 7
SME approval + publishing.

### Sprint 8
Creator revenue + Indonesia payment adapter.

### Sprint 9
Skill Passport.

### Sprint 10
AI Tutor + remediation.

---

# 9. First PR sequence

Recommended GitHub PRs:

1. `feat(goodskill): bootstrap branding and Indonesian i18n`
2. `feat(goodskill): add umkm profile and competency schema`
3. `feat(goodskill): add diagnostic engine`
4. `feat(goodskill): add personalized learning journey`
5. `feat(goodskill): add stage certification`
6. `feat(goodskill): add creator studio`
7. `feat(goodskill): add ai content factory`
8. `feat(goodskill): add sme approval workflow`
9. `feat(goodskill): add creator revenue ledger`
10. `feat(goodskill): add skill passport`
11. `feat(goodskill): add ai tutor competency context`
12. `feat(goodskill): add organization programs`

---

# 10. Definition of architecture success

GoodSkill is correctly implemented when:

- Generic LMS capabilities remain inherited from lms-front.
- GoodSkill-specific domain logic is isolated under `goodskill`.
- Database migrations are additive and RLS-safe.
- AI generation is asynchronous and auditable.
- Human approval gates publication.
- Creator revenue is server-calculated.
- Certification is rule-driven.
- Competency scores are traceable to assessments.
- Skill Passport is verifiable.
- HUBUNK can consume GoodSkill APIs without coupling to internal UI.
