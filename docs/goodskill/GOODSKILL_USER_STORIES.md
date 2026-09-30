# GOODSKILL_USER_STORIES.md

## Format

Each story contains:
- Actor
- Goal
- Acceptance criteria
- Notes

---

## US-001 — Create UMKM Profile

**Actor:** UMKM

**Goal:** create a business profile so GoodSkill can personalize learning.

### Acceptance Criteria
- [ ] User can enter business name
- [ ] User can select industry
- [ ] User can select province/city
- [ ] User can enter revenue range
- [ ] User can enter employee range
- [ ] User can save profile
- [ ] Profile completeness is calculated
- [ ] Only authorized user can edit the profile

---

## US-002 — Complete AI Diagnostic

**Actor:** UMKM

**Goal:** understand current competency.

### Acceptance Criteria
- [ ] Diagnostic has questions mapped to competencies
- [ ] User can save progress
- [ ] User can resume incomplete diagnostic
- [ ] Score is calculated after completion
- [ ] Each domain receives a score
- [ ] Diagnostic result is stored
- [ ] AI summary identifies capability gaps
- [ ] AI output does not replace underlying deterministic scores

---

## US-003 — Generate Learning Path

**Actor:** UMKM

**Goal:** receive personalized learning recommendations.

### Acceptance Criteria
- [ ] System uses competency gaps
- [ ] System maps gaps to courses
- [ ] Required items are distinguished from optional items
- [ ] Path is ordered
- [ ] User sees rationale
- [ ] Path can be regenerated
- [ ] Existing completion is preserved

---

## US-004 — Learn a Course

**Actor:** UMKM

### Acceptance Criteria
- [ ] User can enroll
- [ ] User can access entitled content
- [ ] Lesson completion is persisted
- [ ] Course progress is visible
- [ ] User can resume from previous location
- [ ] Course completion is calculated consistently

---

## US-005 — Ask AI Tutor

**Actor:** UMKM

### Acceptance Criteria
- [ ] User can ask questions
- [ ] Tutor uses approved course knowledge
- [ ] Tutor provides source references where available
- [ ] Tutor can recommend remediation
- [ ] Tutor does not expose unauthorized tenant data

---

## US-006 — Submit Creator Topic

**Actor:** Creator

### Acceptance Criteria
- [ ] Creator must have approved creator profile
- [ ] Topic, audience and level are required
- [ ] Topic is saved as a content job
- [ ] Status starts at DRAFT
- [ ] Creator can reopen and edit the brief

---

## US-007 — Generate AI Learning Content

**Actor:** Creator

### Acceptance Criteria
- [ ] AI creates learning objectives
- [ ] AI creates outline
- [ ] AI creates narrative
- [ ] AI creates quiz
- [ ] AI creates assignment
- [ ] Each artifact has a version
- [ ] AI model and prompt version are stored
- [ ] Sources are stored
- [ ] Failure can be retried

---

## US-008 — Review AI Content

**Actor:** SME

### Acceptance Criteria
- [ ] SME sees review queue
- [ ] SME can inspect source references
- [ ] SME can edit content
- [ ] SME can request revision
- [ ] SME can approve
- [ ] Approval records reviewer and timestamp
- [ ] Unapproved content cannot be published

---

## US-009 — Publish Course

**Actor:** Creator/Admin

### Acceptance Criteria
- [ ] All mandatory artifacts approved
- [ ] Course metadata complete
- [ ] Pricing configured if paid
- [ ] Creator association exists
- [ ] Competency mapping exists
- [ ] Course becomes visible after publish

---

## US-010 — Complete Assessment

**Actor:** UMKM

### Acceptance Criteria
- [ ] Assessment is mapped to stage/competency
- [ ] Attempt is recorded
- [ ] Score is calculated
- [ ] Passing threshold is configurable
- [ ] Practical assessment supports rubric
- [ ] Human evaluator can override AI draft score
- [ ] Final evaluator is recorded

---

## US-011 — Earn Certification

**Actor:** UMKM

### Acceptance Criteria
- [ ] Eligibility rules are evaluated
- [ ] Required courses are complete
- [ ] Required assessments pass
- [ ] Certificate is issued once
- [ ] Certificate has unique ID
- [ ] QR verification resolves publicly
- [ ] Revoked certificates cannot show as valid

---

## US-012 — Skill Passport

**Actor:** UMKM

### Acceptance Criteria
- [ ] Passport shows stage status
- [ ] Passport shows competency scores
- [ ] Passport shows certificates
- [ ] User can set public/private visibility
- [ ] Public URL exposes only allowed fields
- [ ] Verification works without exposing private data

---

## US-013 — Purchase Course

**Actor:** UMKM

### Acceptance Criteria
- [ ] User sees price
- [ ] User creates order
- [ ] Payment status is tracked
- [ ] Successful payment grants entitlement
- [ ] Duplicate webhook does not duplicate entitlement
- [ ] Refund revokes or adjusts entitlement according to policy

---

## US-014 — Creator Revenue

**Actor:** Creator

### Acceptance Criteria
- [ ] Transaction creates immutable revenue snapshot
- [ ] Creator percentage defaults to 20%
- [ ] Creator amount is calculated server-side
- [ ] Platform amount is calculated server-side
- [ ] Refund adjusts ledger
- [ ] Creator can view pending/available/paid balances

---

## US-015 — Organization Program

**Actor:** Program Manager

### Acceptance Criteria
- [ ] Manager creates program
- [ ] Manager sets dates and seat limit
- [ ] Manager enrolls UMKM
- [ ] Manager defines required stage/course
- [ ] Manager sees progress
- [ ] Manager sees certification status
- [ ] Manager can export report

---

## US-016 — Business Impact

**Actor:** UMKM

### Acceptance Criteria
- [ ] User can enter baseline metric
- [ ] User can enter post-learning metric
- [ ] Metric source is recorded
- [ ] Self-reported and verified values are distinguished
- [ ] System calculates change
- [ ] System never presents self-reported data as externally verified

---

# Definition of Done

A feature is Done when:
- acceptance criteria pass
- unit tests exist where applicable
- RLS/security policy is tested
- mobile layout is verified
- error/loading/empty states exist
- analytics event is defined
- documentation is updated
- no secrets are committed
- migration is reversible or safely forward-compatible
