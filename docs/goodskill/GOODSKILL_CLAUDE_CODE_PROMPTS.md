# GOODSKILL_CLAUDE_CODE_PROMPTS.md

Copy these prompts one session at a time. Do not ask Claude Code to implement the entire PRD in one shot.

## 01 — Recon

You are the lead engineer for GoodSkill.

We are building an AI-powered competency, learning and certification platform for Indonesian UMKM.

The current repository is based on:
https://github.com/guillermoscript/lms-front

Before modifying code, perform a read-only architecture audit.

Inspect:
- CLAUDE.md
- README.md
- docs/GETTING_STARTED.md
- docs/DATABASE_SCHEMA.md
- docs/AUTH.md
- docs/MONETIZATION.md
- Supabase migrations
- auth
- tenants/RLS
- courses/lessons
- exams/progress
- certificates
- payments/revenue
- gamification
- AI Tutor/MCP

Produce:
A. architecture map
B. reuse/extend/build-new matrix
C. database dependency map
D. migration risks
E. recommended implementation order
F. files likely to change

Do not modify files and do not invent repository facts.

---

## 02 — UMKM + Competency

Implement GoodSkill foundations for:
- UMKM profile
- competency domains
- competencies
- stages
- stage competency requirements
- course-to-competency mapping

Inspect existing tenant/profile/course schemas first.

Do not duplicate generic LMS tables.

Create deterministic services for:
- competency score
- competency gap
- stage progress
- next-stage logic

Add migrations, RLS and tests.

---

## 03 — Diagnostic

Implement AI Diagnostic.

Flow:
Intro -> questionnaire -> progress -> submit -> result.

Deterministic scoring is authoritative.
AI can summarize and recommend only.

Result:
- domain scores
- competency scores
- gaps
- recommended stage
- top learning priorities

Add unit and E2E tests.

---

## 04 — Learning Journey

Implement personalized Learning Journey using:
- competency gaps
- completed learning
- current stage
- existing courses

Return:
- required
- recommended
- optional

Preserve completed courses when regenerated.

Tenant-safe.

---

## 05 — Certification

Build stage certification above existing certificate infrastructure.

Eligibility:
- required courses
- score threshold
- assignments
- practical assessment
- competency requirements

Server-side only.
Add public verification and revocation.

---

## 06 — Creator Studio

Creator workflow:

Topic -> Generate -> Edit -> SME Review -> Approve -> Publish

Persist the job and all generated artifacts.

---

## 07 — AI Content Factory

Implement async pipeline:

Research -> Curriculum -> Narrative -> Slides -> Quiz -> Assignment -> Video Script -> QA

MVP:
- objectives
- outline
- narrative
- quiz
- assignment

Version every artifact and store:
- model
- prompt version
- sources
- reviewer
- status

No direct publish.

---

## 08 — SME Approval

State machine:

DRAFT -> AI_GENERATED -> AI_QA -> SME_REVIEW -> REVISION -> APPROVED -> PUBLISHED

Only authorized SME can approve.
Server-side publishing must reject unapproved content.

If approved content changes, approval resets.

---

## 09 — Creator Revenue

Reuse existing payment/revenue architecture.

GoodSkill creator share:
20%.

Calculate on server.
Snapshot the rule into each transaction.
Handle refunds and payout states.
Add creator dashboard.

Document gross vs net basis.

---

## 10 — Indonesia Payment

Inspect payment abstraction first.

Add one provider adapter:
Xendit / DOKU / Finnet.

Requirements:
- payment creation
- webhook validation
- idempotency
- status mapping
- refund if supported

No provider-specific code in the core course domain.

---

## 11 — Skill Passport

Build:
- private passport
- public passport
- competency scores
- certificates
- stage statuses
- verification

Public endpoint must not expose private data.

---

## 12 — AI Tutor

Extend existing AI Tutor.

Context:
- approved GoodSkill content
- learner stage
- competency gaps
- current course

Provide citations and remediation recommendations.

Tenant isolation mandatory.

---

## 13 — Production Review

Review all GoodSkill changes for:
- authorization
- RLS
- tenant isolation
- data leakage
- payment idempotency
- AI auditability
- migration safety
- performance
- accessibility
- tests
- secret handling

Fix P0/P1 findings and report residual risks.
