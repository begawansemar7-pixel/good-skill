# GOODSKILL_BACKLOG.md

## Delivery model

Use Epics → Features → Stories → Tasks.

Priority:
- P0 = MVP critical
- P1 = MVP enhancement
- P2 = post-MVP

---

# EPIC E01 — Foundation & Fork

**Goal:** establish GoodSkill from lms-front without rebuilding LMS primitives.

### Stories
- E01-S01 Fork lms-front into GoodSkill repository
- E01-S02 Configure Supabase project
- E01-S03 Configure environment and secrets
- E01-S04 Configure Vercel deployment
- E01-S05 Replace school terminology with GoodSkill terminology
- E01-S06 Add Bahasa Indonesia i18n
- E01-S07 Add GoodSkill branding
- E01-S08 Establish CI/CD and migration workflow

Priority: P0

---

# EPIC E02 — UMKM Identity

### Features
- UMKM registration
- UMKM profile
- business profile
- profile completion

Stories:
- E02-S01 User creates UMKM profile
- E02-S02 User edits business profile
- E02-S03 User sees profile completeness
- E02-S04 Admin can inspect UMKM profile

Priority: P0

---

# EPIC E03 — Competency Framework

### Features
- competency domains
- competencies
- stages
- stage competency requirements

Stories:
- E03-S01 Admin creates competency domain
- E03-S02 Admin creates competency
- E03-S03 Admin configures stage
- E03-S04 Admin maps competencies to stage
- E03-S05 System calculates competency level

Priority: P0

---

# EPIC E04 — AI Diagnostic

### Features
- diagnostic questionnaire
- scoring
- competency profile
- gap analysis

Stories:
- E04-S01 UMKM starts diagnostic
- E04-S02 UMKM answers diagnostic
- E04-S03 System calculates domain score
- E04-S04 AI generates gap analysis
- E04-S05 AI recommends learning path

Priority: P0

---

# EPIC E05 — Learning Journey

### Features
- personalized learning path
- required/recommended courses
- stage progress
- next-best-learning recommendation

Stories:
- E05-S01 User sees personalized path
- E05-S02 User sees stage progress
- E05-S03 User starts recommended course
- E05-S04 System updates competency progress
- E05-S05 User sees next recommended course

Priority: P0

---

# EPIC E06 — AI Content Factory

### Features
- topic submission
- research
- learning objectives
- curriculum
- narrative
- slides
- quiz
- assignment
- video script
- AI QA

Stories:
- E06-S01 Creator submits topic
- E06-S02 AI generates learning objectives
- E06-S03 AI generates curriculum
- E06-S04 AI generates narrative
- E06-S05 AI generates slide outline
- E06-S06 AI generates quiz
- E06-S07 AI generates assignment
- E06-S08 AI generates video script
- E06-S09 AI runs content QA
- E06-S10 Creator regenerates artifact

Priority: P0 for narrative/quiz; P1 for video.

---

# EPIC E07 — SME Approval

Stories:
- E07-S01 SME sees review queue
- E07-S02 SME reviews source references
- E07-S03 SME edits content
- E07-S04 SME requests revision
- E07-S05 SME approves content
- E07-S06 System records audit trail

Priority: P0

---

# EPIC E08 — Learning & Assessment

Reuse lms-front:
- courses
- lessons
- exercises
- exams
- progress

Extend:
- practical assignment
- competency mapping
- rubric
- AI-assisted evaluation

Stories:
- E08-S01 Learner completes lesson
- E08-S02 Learner takes quiz
- E08-S03 Learner submits assignment
- E08-S04 AI evaluates draft
- E08-S05 Human evaluator confirms score
- E08-S06 System updates competency

Priority: P0/P1

---

# EPIC E09 — Certification

Stories:
- E09-S01 Configure certification rules
- E09-S02 Check eligibility
- E09-S03 Issue stage certificate
- E09-S04 Generate QR verification
- E09-S05 Public verification
- E09-S06 Revoke certificate
- E09-S07 Certificate appears in Skill Passport

Priority: P0

---

# EPIC E10 — Skill Passport

Stories:
- E10-S01 Generate passport
- E10-S02 Display competency scores
- E10-S03 Display certificates
- E10-S04 Configure visibility
- E10-S05 Share public URL
- E10-S06 Verify passport

Priority: P1

---

# EPIC E11 — Creator Economy

Reuse lms-front revenue infrastructure.

Stories:
- E11-S01 Map course to creator
- E11-S02 Freeze revenue split at transaction time
- E11-S03 Calculate 20% creator share
- E11-S04 Show creator ledger
- E11-S05 Generate payout
- E11-S06 Creator sees earnings

Priority: P0

---

# EPIC E12 — Commerce

Reuse existing product/transaction/entitlement model.

Stories:
- E12-S01 Buy course
- E12-S02 Buy certification
- E12-S03 Buy bundle
- E12-S04 Payment webhook
- E12-S05 Refund
- E12-S06 Restore entitlement

For Indonesia add provider adapter for Xendit/DOKU/Finnet or selected gateway.

Priority: P0

---

# EPIC E13 — Organization Programs

Stories:
- E13-S01 Create program
- E13-S02 Allocate seats
- E13-S03 Enroll UMKM
- E13-S04 Configure learning requirement
- E13-S05 Monitor cohort
- E13-S06 Export program report

Priority: P1

---

# EPIC E14 — AI Tutor

Reuse lms-front MCP/AI Tutor foundation.

Extend:
- Indonesian language
- competency-aware context
- UMKM business context
- citations

Stories:
- E14-S01 Ask course question
- E14-S02 Tutor cites source lesson
- E14-S03 Tutor recommends remediation
- E14-S04 Tutor recommends next learning

Priority: P1

---

# EPIC E15 — Business Impact

Stories:
- E15-S01 Capture baseline metrics
- E15-S02 Capture post-learning metrics
- E15-S03 Display change
- E15-S04 Mark source as self-reported/verified
- E15-S05 Program manager sees aggregate impact

Priority: P2

---

# EPIC E16 — HUBUNK / PCD

Stories:
- E16-S01 HUBUNK SSO/integration
- E16-S02 Sync UMKM identity
- E16-S03 Deep-link GoodSkill learning
- E16-S04 PCD Academy program
- E16-S05 Return certification status to ecosystem

Priority: P2

---

# Release plan

## Release 0 — Technical Foundation
E01

## Release 1 — Commercial LMS MVP
E02 + existing lms-front course/progress/commerce/certificate + E11

## Release 2 — Competency MVP
E03 + E04 + E05 + E09

## Release 3 — AI Creator
E06 + E07

## Release 4 — AI Learning
E08 + E10 + E14

## Release 5 — Ecosystem
E13 + E15 + E16
