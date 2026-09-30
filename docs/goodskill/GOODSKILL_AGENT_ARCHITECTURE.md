# GoodSkill AI Development Agent Architecture

## 1. Purpose

The GoodSkill Development Agent automates repetitive engineering work while keeping high-risk decisions under human control.

## 2. Agent loop

```text
Backlog
   |
   v
DISCOVER
   |
   v
PLAN
   |
   v
IMPLEMENT
   |
   v
TEST
   |
   v
SECURITY REVIEW
   |
   v
DOCUMENT
   |
   v
COMMIT
   |
   v
PULL REQUEST
   |
   v
HUMAN REVIEW
   |
   +---- reject ----> agent fixes
   |
   +---- approve ---> develop
                       |
                       v
                    staging
                       |
                       v
                  human release
                       |
                       v
                    main
                       |
                       v
                  production
```

## 3. Agent roles

### Lead
Owns implementation.

### QA
Owns automated validation.

### Reviewer
Owns architectural/security review.

### Human
Owns:
- production
- destructive migrations
- payments
- revenue policy
- certification policy
- legal/compliance
- merge to main

## 4. Recommended autonomy levels

### Level 1 — Assist
Agent proposes code and waits.

### Level 2 — Feature
Agent implements feature branch and tests.

### Level 3 — PR
Agent implements, commits and opens PR.

### Level 4 — Staging
Agent can deploy to staging/preview.

### Level 5 — Production
Human approval required.

GoodSkill should operate at Level 3 initially.

## 5. Core product loop

```text
UMKM
 |
Diagnostic
 |
Competency Gap
 |
Learning Journey
 |
Course
 |
Assessment
 |
Certification
 |
Skill Passport
```

Creator loop:

```text
Topic
 |
AI Content Factory
 |
Narrative + Slides + Quiz + Video
 |
SME Approval
 |
Course
 |
Marketplace
 |
Revenue
 |
Creator 20%
```

## 6. Agent safety boundaries

The agent must never:
- expose secrets
- bypass RLS
- directly mutate production
- issue certificates outside rules
- mark payment successful from client state
- modify creator revenue policy silently
- publish unapproved AI content
- fabricate sources or repository facts
