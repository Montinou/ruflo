# Launch Commands

> **Note:** `claude -p` doesn't work on this WSL2 setup. Run `claude` interactively, then paste the prompt.

---

## Single Task Launchers

### Jardin (ElevenLabs Migration)

```
cd ~/.openclaw/workspaces/jardin/repo && claude --dangerously-skip-permissions
```

Paste:
```
FIRST: Create a new branch from the current branch (e.g. feat/elevenlabs-migration) before making ANY changes. You are working on Jardin Maternal — a bilingual (ES-AR / EN) Next.js app with Neon DB and shadcn/ui. Your PRIMARY task is to replace Vapi with ElevenLabs Conversational AI for the voice agent. Read the full ElevenLabs documentation at ~/ruflo/docs/elevenlabs/ (all folders: elevenlabs-agents, elevenlabs-api, elevenlabs-creative, and elevenlabs_spanish_agent_guide.md). Design and implement a fully configured ElevenLabs agent with Spanish (Argentine) as primary language and English as secondary. Use the ElevenLabs MCP tools available globally. Remove all Vapi dependencies and replace with ElevenLabs SDK. Use shadcnblocks premium components via CLI for any UI changes. Focus on innovative, premium UI design. Commit when done.
```

### Interviews

```
cd ~/.openclaw/workspaces/interviews/repo && claude --dangerously-skip-permissions
```

Paste:
```
FIRST: Create a new branch from the current branch (e.g. feat/ui-improvements) before making ANY changes. You are working on Interview Companion — a bilingual (ES-AR / EN) Next.js app with Clerk auth and Radix UI. Read the existing codebase and CLAUDE.md first. Analyze the current state, identify the top 3 improvements needed (UI/UX, features, or code quality), and implement the highest-impact one. Use shadcnblocks premium components via CLI whenever possible. Focus on innovative, premium UI design. All user-facing text must support ES-AR and EN. Commit when done.
```

### Sales

```
cd ~/.openclaw/workspaces/sales/repo && claude --dangerously-skip-permissions
```

Paste:
```
FIRST: Create a new branch from the current branch (e.g. feat/ui-improvements) before making ANY changes. You are working on Sales Companion (Hermes) — a bilingual (ES-AR / EN) sales platform. Read the existing codebase and any docs first. Analyze the current state, identify the top 3 improvements needed (UI/UX, features, or conversion optimization), and implement the highest-impact one. Use shadcnblocks premium components via CLI whenever possible. Focus on innovative, premium UI design. All user-facing text must support ES-AR and EN. Commit when done.
```

---

## Continuous Backlog Executor (Overnight / Autonomous)

These prompts make the agent work through the BACKLOG.md task queue continuously. Each task gets its own branch, commit, and the agent moves to the next.

### Jardin — Continuous

```
cd ~/.openclaw/workspaces/jardin/repo && claude --dangerously-skip-permissions
```

Paste:
```
You are working on Jardin Maternal (JugArte) — a bilingual (ES-AR / EN) Next.js 16 app with Neon DB, Drizzle ORM, ElevenLabs voice, and shadcn/ui.

WORKFLOW:
1. Read BACKLOG.md — find the first PENDING task (unchecked [ ])
2. Mark it IN PROGRESS: change [ ] to [~]
3. Create a new branch from main for this task (e.g. feat/P1-01-i18n-setup)
4. Implement the task fully. Use shadcnblocks premium via CLI. All UI must be innovative and premium. Bilingual ES-AR / EN.
5. For ElevenLabs features, read ~/ruflo/docs/elevenlabs/ and use the ElevenLabs MCP tools.
6. Commit with a descriptive message referencing the task ID
7. Mark the task DONE: change [~] to [x]
8. Go back to step 1 and pick the next task

RULES:
- One branch per task, one commit minimum per task
- Use shadcnblocks premium via CLI (`npx shadcn@latest add <block>`) — NEVER build custom equivalents
- All user-facing text bilingual ES-AR / EN (use next-intl)
- Read files before editing them
- If you hit a blocker, skip to the next task and leave a comment in BACKLOG.md
- Keep going until all tasks are done or you run out of context
```

### Interviews — Continuous

```
cd ~/.openclaw/workspaces/interviews/repo && claude --dangerously-skip-permissions
```

Paste:
```
You are working on Interview Companion (Iris) — a bilingual (ES-AR / EN) Next.js 16 app with Clerk auth, Drizzle + Supabase, next-intl, Radix UI, and Recharts.

WORKFLOW:
1. Read BACKLOG.md — find the first PENDING task (unchecked [ ])
2. Mark it IN PROGRESS: change [ ] to [~]
3. Create a new branch from main for this task (e.g. feat/P1-01-shadcn-migration)
4. Implement the task fully. Use shadcnblocks premium via CLI. All UI must be innovative and premium. Bilingual ES-AR / EN.
5. Commit with a descriptive message referencing the task ID
6. Mark the task DONE: change [~] to [x]
7. Go back to step 1 and pick the next task

RULES:
- One branch per task, one commit minimum per task
- Use shadcnblocks premium via CLI (`npx shadcn@latest add <block>`) — NEVER build custom equivalents
- All user-facing text bilingual ES-AR / EN (next-intl already set up)
- Clerk for auth, Supabase realtime for collaboration features
- Read files before editing them
- If you hit a blocker, skip to the next task and leave a comment in BACKLOG.md
- Keep going until all tasks are done or you run out of context
```

### Sales — Continuous

```
cd ~/.openclaw/workspaces/sales/repo && claude --dangerously-skip-permissions
```

Paste:
```
You are working on Sales Companion (Hermes) — a bilingual (ES-AR / EN) Next.js sales platform with Deepgram speech-to-text, Tauri desktop, and Cloudflare workers.

WORKFLOW:
1. Read BACKLOG.md — find the first PENDING task (unchecked [ ])
2. Mark it IN PROGRESS: change [ ] to [~]
3. Create a new branch from main for this task (e.g. feat/P1-01-nextjs-upgrade)
4. Implement the task fully. Use shadcnblocks premium via CLI. All UI must be innovative and premium. Bilingual ES-AR / EN.
5. Commit with a descriptive message referencing the task ID
6. Mark the task DONE: change [~] to [x]
7. Go back to step 1 and pick the next task

RULES:
- One branch per task, one commit minimum per task
- Use shadcnblocks premium via CLI (`npx shadcn@latest add <block>`) — NEVER build custom equivalents
- All user-facing text bilingual ES-AR / EN (set up next-intl first)
- Deepgram for real-time audio features
- Read files before editing them
- If you hit a blocker, skip to the next task and leave a comment in BACKLOG.md
- Keep going until all tasks are done or you run out of context
```

---

## Launch All 3 (Open 3 terminals)

Terminal 1:
```
cd ~/.openclaw/workspaces/jardin/repo && claude --dangerously-skip-permissions
```

Terminal 2:
```
cd ~/.openclaw/workspaces/interviews/repo && claude --dangerously-skip-permissions
```

Terminal 3:
```
cd ~/.openclaw/workspaces/sales/repo && claude --dangerously-skip-permissions
```

Then paste the corresponding "Continuous" prompt into each terminal.

---

## ElevenLabs Docs Embedding

Run once to embed all 189 ElevenLabs docs into shared memory:

```bash
~/ruflo/scripts/embed-elevenlabs.sh
```

Or per-project:
```bash
~/ruflo/scripts/embed-elevenlabs.sh ~/.openclaw/workspaces/jardin/repo
~/ruflo/scripts/embed-elevenlabs.sh ~/.openclaw/workspaces/interviews/repo
~/ruflo/scripts/embed-elevenlabs.sh ~/.openclaw/workspaces/sales/repo
```
