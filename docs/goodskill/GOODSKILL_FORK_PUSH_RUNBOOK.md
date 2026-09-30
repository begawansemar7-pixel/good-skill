# GOODSKILL_FORK_PUSH_RUNBOOK.md

## 1. Clone upstream and set remotes

```bash
mkdir -p ~/Projects
cd ~/Projects

git clone https://github.com/guillermoscript/lms-front.git good-skill
cd good-skill

git remote rename origin upstream
git remote add origin https://github.com/begawansemar7-pixel/good-skill.git

git remote -v
```

## 2. Push to target repository

```bash
git push -u origin master:main
git branch -M main
git fetch origin
git branch --set-upstream-to=origin/main main
```

## 3. Create develop

```bash
git checkout -b develop
git push -u origin develop
```

## 4. Install/run

```bash
npm install
cp .env.example .env.local

supabase start
supabase status
npm run db:reset
npm run db:types
npm run dev
```

Open:

`http://lvh.me:3000`

## 5. Baseline validation

```bash
npm run typecheck
npm run lint
npm run test:unit
npm run build
```

## 6. Feature branch

```bash
git checkout develop
git pull origin develop
git checkout -b feat/goodskill-<feature>
```

## 7. Validate

```bash
git status
git diff --stat

npm run typecheck
npm run lint
npm run test:unit
```

## 8. Commit + push

```bash
git add .
git commit -m "feat(goodskill): <description>"
git push -u origin feat/goodskill-<feature>
```

Then open a PR from feature -> develop.

## 9. Upstream sync

```bash
git fetch upstream
git checkout develop
git merge upstream/master
```

Review migration/auth/payment conflicts before merge.

## 10. Production safety

Never commit:
- .env.local
- Supabase service role keys
- Stripe keys
- Xendit/DOKU/Finnet secrets
- LLM API keys
- video provider secrets

Check:

```bash
git status --ignored
git ls-files | grep -E '(^|/)\.env'
```

## 11. Branch policy

Recommended:
- protect `main`
- no direct production pushes
- PR review required
- CI required
- squash feature PRs
- release from tested `develop`
