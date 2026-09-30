# GOODSKILL_PRD.md

# GoodSkill — AI-Powered UMKM Competency & Certification Platform

**Version:** 1.0  
**Date:** 2026-09-30  
**Status:** Implementation Baseline  
**Primary stack:** Next.js 16 / React 19 / TypeScript / Supabase PostgreSQL / Tailwind / Vercel  
**Base repository:** `guillermoscript/lms-front`  
**Authoring reference:** `course-code-framework/coursecode`

---

## 1. Product Vision

GoodSkill is an AI-powered competency, learning and certification platform for Indonesian UMKM.

The product outcome is not merely course completion. The target outcome is:

> **UMKM memiliki kompetensi yang terukur, dapat dipraktikkan, tersertifikasi, dan dapat dibuktikan melalui Skill Passport.**

Core journey:

`Diagnose → Personalized Journey → Learn → Practice → Assess → Certify → Skill Passport → Business Impact`

---

## 2. Target Users

### Learner / UMKM
- Owner
- Manager
- Operator
- UMKM participant in KADIN/government/corporate programs

### Creator / Instructor
- Practitioner
- Lecturer
- Consultant
- Mentor
- Business expert
- Corporate/government trainer

### SME Reviewer
Approves AI-generated learning content.

### Organization / Program Manager
Runs sponsored UMKM learning programs.

### GoodSkill Admin
Platform, catalog, payment, certification, AI governance and analytics administration.

---

## 3. Product Pillars

1. Competency-first learning
2. Personalized learning journey
3. AI-assisted content creation
4. Human-in-the-loop approval
5. Practice-based assessment
6. Verifiable certification
7. Creator economy
8. Business-impact measurement

---

## 4. Competency Journey

### Stage 0 — DIAGNOSE
Output: UMKM Competency Profile and recommended journey.

### Stage 1 — START
Business fundamentals:
- Business model
- Customer
- Product
- Basic marketing
- Basic sales
- Basic finance
- Legal
- Digital literacy
- AI literacy

Certificate: `GoodSkill START Certified`

### Stage 2 — GROW
Business growth:
- Digital marketing
- Branding
- Social media
- Marketplace
- Sales
- CRM
- Customer experience
- Financial management

Certificate: `GoodSkill GROW Certified`

### Stage 3 — SCALE
Digitalization and productivity:
- Digital transformation
- Automation
- AI for business
- Data analytics
- E-commerce
- Supply chain
- HR
- Business intelligence

Certificate: `GoodSkill SCALE Certified`

### Stage 4 — EXPORT
Market expansion:
- Export readiness
- International marketing
- Export documentation
- International payment
- Standardization
- Packaging
- Certification
- Global marketplace

Certificate: `GoodSkill EXPORT READY Certified`

### Stage 5 — CHAMPION
Advanced business:
- Strategy
- Leadership
- Innovation
- AI transformation
- ESG
- Investment readiness
- International expansion

Certificate: `GoodSkill UMKM CHAMPION`

---

## 5. Learner Features

### GS-L01 Registration & UMKM Profile
User can register and create an UMKM profile.

Required:
- Business name
- Industry
- Region
- Business age
- Revenue range
- Employee range
- Product/service
- Sales channels
- Digital adoption

### GS-L02 AI Diagnostic
AI-guided assessment produces domain scores and competency gaps.

### GS-L03 Personalized Learning Path
System recommends required, recommended and optional learning items.

### GS-L04 Course/Lesson
Learner consumes video, slides, text, resources and exercises.

### GS-L05 AI Tutor
Learner asks questions against approved GoodSkill knowledge.

### GS-L06 Practice
Assignments must produce practical business artifacts.

### GS-L07 Assessment
Quiz + assignment + practical assessment.

### GS-L08 Certification
Certification is awarded only after configurable eligibility rules are satisfied.

### GS-L09 Skill Passport
Public/private competency profile with certificates and verified scores.

### GS-L10 Business Impact
Optional before/after business metrics with source labeling.

---

## 6. Creator Features

### GS-C01 Creator Onboarding
Profile, expertise, payout information and content agreement.

### GS-C02 Topic Submission
Creator submits:
- Topic
- Audience
- Level
- Duration
- Competency domain
- Intended outcome

### GS-C03 AI Content Factory
Pipeline:

`Topic → Research → Objectives → Curriculum → Narrative → Slides → Video Script → Quiz → Assignment → QA`

### GS-C04 Content Editor
Creator can edit every AI-generated artifact.

### GS-C05 SME Approval
Status:

`DRAFT → AI_GENERATED → AI_QA → SME_REVIEW → REVISION → APPROVED → PUBLISHED`

### GS-C06 AI Video
Generate script, narration and optional avatar/video using an external provider.

### GS-C07 Creator Analytics
- Enrollments
- Completion
- Rating
- Revenue
- Royalty
- Payout

---

## 7. AI Architecture

### Agents
- Research Agent
- Curriculum Agent
- Narrative Agent
- Slide Agent
- Quiz Agent
- Assignment Agent
- Video Agent
- Assessment Agent
- QA Agent
- Recommendation Agent
- Tutor Agent

### AI Governance
Every generated artifact stores:
- model
- prompt version
- generation timestamp
- source references
- generation status
- reviewer
- approval timestamp
- content version

AI may generate drafts; **SME approval is required before publication**.

---

## 8. Certification

Certification rules are configurable by stage.

Example:
- START: quiz >= 70 + required lessons + assignment
- GROW: quiz >= 75 + assignment + case
- SCALE: quiz >= 80 + practical project
- EXPORT: assessment + export readiness project
- CHAMPION: advanced project + assessment

Certificate:
- certificate ID
- learner
- UMKM
- stage
- competency
- score
- issuer
- issue date
- QR verification URL
- status

---

## 9. Monetization

### Course
Pay per course/material.

### Certification
Separate certification fee.

### Bundle
Multiple courses or stage bundle.

### B2B/B2G
Sponsored seats/programs.

### Revenue Share
Default target:

`Creator 20% / GoodSkill 80%`

The settlement base must be explicitly defined contractually (gross vs net after fees/refunds/tax/chargeback).

---

## 10. Skill Passport

Skill Passport contains:
- competency domains
- competency scores
- completed learning
- stage status
- certificates
- verification URLs
- business impact indicators

---

## 11. Organization Programs

Organizations can create:
- cohort/program
- seat allocation
- required learning path
- certification requirement
- regional segmentation
- program dashboard

Examples:
- KADIN UMKM Academy
- PCD Academy powered by GoodSkill
- Government UMKM Digitalization Program
- Corporate supplier academy

---

## 12. MVP

### P0
- Auth
- UMKM profile
- Course catalog
- Enrollment/payment
- Learning progress
- Quiz/exam
- Certificate
- Creator profile
- Topic submission
- AI narrative
- AI slide outline
- AI quiz
- SME approval
- Creator revenue ledger
- Admin dashboard

### P1
- Diagnostic
- Personalized learning path
- AI Tutor
- Assignment/practical assessment
- Skill Passport
- AI video generation
- Creator analytics

### P2
- Business impact
- Marketplace
- Mentor
- Community
- HUBUNK integration
- PCD Academy
- Organization program automation

---

## 13. Non-Functional Requirements

### Security
- Supabase Auth
- PostgreSQL RLS
- Role-based authorization
- Service-role keys only server-side
- Audit logs
- Secure payment webhooks
- Idempotency for payment events

### Performance
- Dashboard initial load target < 2.5 sec under normal conditions
- Async AI jobs
- Background processing for video generation

### Reliability
- AI job retries
- webhook idempotency
- content versioning
- certificate verification availability

### Accessibility
Target WCAG 2.1 AA for learner-facing critical journeys.

### Localization
Primary language: Bahasa Indonesia.
Architecture must remain i18n-ready.

---

## 14. North Star Metric

**Verified Competency Improvement**

An UMKM counts when:
1. diagnostic exists,
2. learning is completed,
3. assessment is passed,
4. competency score improves or certification is achieved.

---

## 15. Initial KPI Targets

These are validation targets, not market benchmarks:
- 10,000 registered UMKM
- >40% active learner rate
- >60% course completion
- >30% certification conversion
- 100 creators
- 500 published courses
- >70% AI-assisted content adoption
- >90% SME approval rate
- >30% AI Tutor adoption among active learners

---

## 16. Architecture Principle

Do not rebuild generic LMS capabilities.

Reuse `lms-front` for:
- authentication
- multi-tenancy
- course/lesson
- progress
- exam
- commerce
- revenue infrastructure
- certificates
- gamification
- community
- AI tutor foundation

Build GoodSkill-specific IP for:
- competency framework
- diagnostic
- learning journey
- AI content factory
- SME approval workflow
- practical assessment
- Skill Passport
- UMKM business impact
- Indonesian payment/settlement integration
- HUBUNK/PCD integration
