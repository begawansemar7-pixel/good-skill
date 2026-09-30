-- SUPABASE_SCHEMA.sql
-- GoodSkill extension schema for lms-front
-- Principle: reuse existing lms-front tables where possible.
-- New tables use UUID PKs and reference existing profiles/tenants/courses where applicable.

create extension if not exists pgcrypto;

-- ============================================================
-- 1. UMKM
-- ============================================================

create table if not exists public.umkm_profiles (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id) on delete cascade,
  owner_user_id uuid not null references public.profiles(id) on delete cascade,
  business_name text not null,
  legal_name text,
  industry text,
  sub_industry text,
  province text,
  city text,
  district text,
  business_age_years numeric,
  revenue_range text,
  employee_range text,
  product_description text,
  sales_channels jsonb not null default '[]'::jsonb,
  digital_maturity smallint check (digital_maturity between 0 and 5),
  ai_maturity smallint check (ai_maturity between 0 and 5),
  export_readiness smallint check (export_readiness between 0 and 5),
  profile_status text not null default 'active',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists idx_umkm_owner on public.umkm_profiles(owner_user_id);
create index if not exists idx_umkm_tenant on public.umkm_profiles(tenant_id);

-- ============================================================
-- 2. COMPETENCY FRAMEWORK
-- ============================================================

create table if not exists public.gs_competency_domains (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,
  name text not null,
  description text,
  sort_order int not null default 0,
  active boolean not null default true
);

create table if not exists public.gs_competencies (
  id uuid primary key default gen_random_uuid(),
  domain_id uuid not null references public.gs_competency_domains(id) on delete cascade,
  code text unique not null,
  name text not null,
  description text,
  level_definitions jsonb not null default '{}'::jsonb,
  active boolean not null default true
);

create table if not exists public.gs_stages (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,
  name text not null,
  description text,
  sort_order int not null,
  certificate_name text,
  minimum_score numeric(5,2),
  active boolean not null default true
);

create table if not exists public.gs_stage_competencies (
  stage_id uuid not null references public.gs_stages(id) on delete cascade,
  competency_id uuid not null references public.gs_competencies(id) on delete cascade,
  required_level smallint not null default 1,
  required boolean not null default true,
  primary key(stage_id, competency_id)
);

-- ============================================================
-- 3. DIAGNOSTIC
-- ============================================================

create table if not exists public.gs_diagnostic_assessments (
  id uuid primary key default gen_random_uuid(),
  umkm_id uuid not null references public.umkm_profiles(id) on delete cascade,
  status text not null default 'draft',
  started_at timestamptz,
  completed_at timestamptz,
  ai_summary text,
  ai_model text,
  created_at timestamptz not null default now()
);

create table if not exists public.gs_diagnostic_questions (
  id uuid primary key default gen_random_uuid(),
  competency_id uuid references public.gs_competencies(id) on delete set null,
  question text not null,
  question_type text not null default 'scale',
  options jsonb not null default '[]'::jsonb,
  scoring_rules jsonb not null default '{}'::jsonb,
  active boolean not null default true
);

create table if not exists public.gs_diagnostic_answers (
  id uuid primary key default gen_random_uuid(),
  assessment_id uuid not null references public.gs_diagnostic_assessments(id) on delete cascade,
  question_id uuid not null references public.gs_diagnostic_questions(id) on delete cascade,
  answer jsonb not null,
  score numeric(5,2),
  created_at timestamptz not null default now(),
  unique(assessment_id, question_id)
);

create table if not exists public.gs_competency_scores (
  id uuid primary key default gen_random_uuid(),
  umkm_id uuid not null references public.umkm_profiles(id) on delete cascade,
  competency_id uuid not null references public.gs_competencies(id) on delete cascade,
  score numeric(5,2) not null,
  level smallint,
  source text not null,
  source_ref uuid,
  measured_at timestamptz not null default now(),
  unique(umkm_id, competency_id, measured_at)
);

-- ============================================================
-- 4. LEARNING JOURNEY
-- ============================================================

create table if not exists public.gs_learning_paths (
  id uuid primary key default gen_random_uuid(),
  umkm_id uuid not null references public.umkm_profiles(id) on delete cascade,
  stage_id uuid references public.gs_stages(id) on delete set null,
  title text not null,
  generated_by text not null default 'ai',
  rationale text,
  status text not null default 'active',
  created_at timestamptz not null default now()
);

create table if not exists public.gs_learning_path_items (
  id uuid primary key default gen_random_uuid(),
  learning_path_id uuid not null references public.gs_learning_paths(id) on delete cascade,
  course_id bigint references public.courses(id) on delete set null,
  competency_id uuid references public.gs_competencies(id) on delete set null,
  item_type text not null default 'course',
  priority text not null default 'required',
  sort_order int not null default 0,
  rationale text,
  completed_at timestamptz
);

-- ============================================================
-- 5. CREATOR + CONTENT FACTORY
-- ============================================================

create table if not exists public.gs_creators (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  display_name text not null,
  bio text,
  expertise jsonb not null default '[]'::jsonb,
  payout_status text not null default 'pending',
  agreement_status text not null default 'pending',
  created_at timestamptz not null default now()
);

create table if not exists public.gs_content_jobs (
  id uuid primary key default gen_random_uuid(),
  creator_id uuid not null references public.gs_creators(id) on delete cascade,
  topic text not null,
  audience text,
  level text,
  duration_minutes int,
  competency_ids uuid[] not null default '{}',
  status text not null default 'draft',
  created_at timestamptz not null default now(),
  completed_at timestamptz
);

create table if not exists public.gs_content_artifacts (
  id uuid primary key default gen_random_uuid(),
  job_id uuid not null references public.gs_content_jobs(id) on delete cascade,
  artifact_type text not null,
  version int not null default 1,
  content jsonb not null default '{}'::jsonb,
  source_references jsonb not null default '[]'::jsonb,
  ai_model text,
  prompt_version text,
  qa_status text not null default 'pending',
  reviewer_user_id uuid references public.profiles(id) on delete set null,
  approval_status text not null default 'pending',
  approved_at timestamptz,
  created_at timestamptz not null default now()
);

create index if not exists idx_gs_content_artifacts_job on public.gs_content_artifacts(job_id);

-- ============================================================
-- 6. PRACTICAL ASSESSMENT
-- ============================================================

create table if not exists public.gs_assessment_templates (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  competency_id uuid references public.gs_competencies(id) on delete set null,
  stage_id uuid references public.gs_stages(id) on delete set null,
  assessment_type text not null,
  passing_score numeric(5,2) not null default 70,
  rubric jsonb not null default '{}'::jsonb,
  active boolean not null default true
);

create table if not exists public.gs_assessment_attempts (
  id uuid primary key default gen_random_uuid(),
  template_id uuid not null references public.gs_assessment_templates(id) on delete cascade,
  umkm_id uuid not null references public.umkm_profiles(id) on delete cascade,
  course_id bigint references public.courses(id) on delete set null,
  submission jsonb not null default '{}'::jsonb,
  score numeric(5,2),
  feedback text,
  evaluator_user_id uuid references public.profiles(id) on delete set null,
  ai_score numeric(5,2),
  ai_feedback text,
  status text not null default 'submitted',
  submitted_at timestamptz not null default now(),
  evaluated_at timestamptz
);

-- ============================================================
-- 7. STAGE CERTIFICATION
-- ============================================================

create table if not exists public.gs_certification_rules (
  id uuid primary key default gen_random_uuid(),
  stage_id uuid not null references public.gs_stages(id) on delete cascade,
  minimum_score numeric(5,2) not null,
  required_course_count int not null default 0,
  required_assignment_count int not null default 0,
  rules jsonb not null default '{}'::jsonb,
  active boolean not null default true
);

create table if not exists public.gs_stage_certifications (
  id uuid primary key default gen_random_uuid(),
  umkm_id uuid not null references public.umkm_profiles(id) on delete cascade,
  stage_id uuid not null references public.gs_stages(id) on delete cascade,
  status text not null default 'in_progress',
  score numeric(5,2),
  started_at timestamptz not null default now(),
  certified_at timestamptz,
  unique(umkm_id, stage_id)
);

create table if not exists public.gs_skill_passports (
  id uuid primary key default gen_random_uuid(),
  umkm_id uuid unique not null references public.umkm_profiles(id) on delete cascade,
  public_slug text unique not null,
  visibility text not null default 'private',
  summary jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- ============================================================
-- 8. BUSINESS IMPACT
-- ============================================================

create table if not exists public.gs_business_metrics (
  id uuid primary key default gen_random_uuid(),
  umkm_id uuid not null references public.umkm_profiles(id) on delete cascade,
  metric_code text not null,
  metric_name text not null,
  metric_value numeric,
  unit text,
  period_start date,
  period_end date,
  source_type text not null default 'self_reported',
  source_reference text,
  verified boolean not null default false,
  created_at timestamptz not null default now()
);

-- ============================================================
-- 9. PROGRAM / COHORT
-- ============================================================

create table if not exists public.gs_programs (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references public.tenants(id) on delete cascade,
  name text not null,
  description text,
  sponsor_name text,
  stage_id uuid references public.gs_stages(id) on delete set null,
  start_date date,
  end_date date,
  seat_limit int,
  status text not null default 'draft',
  created_at timestamptz not null default now()
);

create table if not exists public.gs_program_enrollments (
  id uuid primary key default gen_random_uuid(),
  program_id uuid not null references public.gs_programs(id) on delete cascade,
  umkm_id uuid not null references public.umkm_profiles(id) on delete cascade,
  status text not null default 'active',
  enrolled_at timestamptz not null default now(),
  completed_at timestamptz,
  unique(program_id, umkm_id)
);

-- ============================================================
-- 10. CREATOR REVENUE
-- ============================================================

create table if not exists public.gs_creator_revenue_ledger (
  id uuid primary key default gen_random_uuid(),
  creator_id uuid not null references public.gs_creators(id) on delete cascade,
  transaction_id bigint references public.transactions(transaction_id) on delete set null,
  course_id bigint references public.courses(id) on delete set null,
  gross_amount numeric(14,2) not null default 0,
  creator_percentage numeric(5,2) not null default 20,
  creator_amount numeric(14,2) not null default 0,
  platform_amount numeric(14,2) not null default 0,
  currency text not null default 'IDR',
  status text not null default 'pending',
  created_at timestamptz not null default now()
);

create table if not exists public.gs_creator_payouts (
  id uuid primary key default gen_random_uuid(),
  creator_id uuid not null references public.gs_creators(id) on delete cascade,
  amount numeric(14,2) not null,
  currency text not null default 'IDR',
  period_start date,
  period_end date,
  payout_method text,
  status text not null default 'pending',
  provider_reference text,
  paid_at timestamptz,
  created_at timestamptz not null default now()
);

-- ============================================================
-- 11. AI AUDIT
-- ============================================================

create table if not exists public.gs_ai_runs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete set null,
  job_type text not null,
  model text,
  prompt_version text,
  input_hash text,
  output jsonb,
  source_references jsonb not null default '[]'::jsonb,
  status text not null default 'running',
  error_message text,
  created_at timestamptz not null default now(),
  completed_at timestamptz
);

-- ============================================================
-- 12. RLS BASELINE
-- ============================================================
-- Enable RLS on all GoodSkill tables.
-- Production policies must be added according to lms-front's tenant/RLS model.
-- Do not bypass RLS from browser clients.

alter table public.umkm_profiles enable row level security;
alter table public.gs_learning_paths enable row level security;
alter table public.gs_learning_path_items enable row level security;
alter table public.gs_creators enable row level security;
alter table public.gs_content_jobs enable row level security;
alter table public.gs_content_artifacts enable row level security;
alter table public.gs_assessment_attempts enable row level security;
alter table public.gs_stage_certifications enable row level security;
alter table public.gs_skill_passports enable row level security;
alter table public.gs_business_metrics enable row level security;
alter table public.gs_programs enable row level security;
alter table public.gs_program_enrollments enable row level security;
alter table public.gs_creator_revenue_ledger enable row level security;
alter table public.gs_creator_payouts enable row level security;
alter table public.gs_ai_runs enable row level security;

-- ============================================================
-- 13. SEED STAGES
-- ============================================================

insert into public.gs_stages(code,name,description,sort_order,certificate_name,minimum_score)
values
('START','START','Business fundamentals',1,'GoodSkill START Certified',70),
('GROW','GROW','Business growth',2,'GoodSkill GROW Certified',75),
('SCALE','SCALE','Digitalization and productivity',3,'GoodSkill SCALE Certified',80),
('EXPORT','EXPORT','Market expansion and export readiness',4,'GoodSkill EXPORT READY Certified',80),
('CHAMPION','CHAMPION','Advanced business leadership',5,'GoodSkill UMKM CHAMPION',80)
on conflict(code) do update set
name=excluded.name,
description=excluded.description,
sort_order=excluded.sort_order,
certificate_name=excluded.certificate_name,
minimum_score=excluded.minimum_score;
