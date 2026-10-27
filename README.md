# 📘 Handbook — Knowledge System of Record

[![Node.js](https://img.shields.io/badge/Node.js-%3E%3D24-339933?logo=nodedotjs&logoColor=white&style=for-the-badge)](https://nodejs.org/)
[![Next.js](https://img.shields.io/badge/Next.js-16.4.3-000000?logo=nextdotjs&logoColor=white&style=for-the-badge)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React-19.2.8-61DAFB?logo=react&logoColor=black&style=for-the-badge)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-6.0.3-3178C6?logo=typescript&logoColor=white&style=for-the-badge)](https://www.typescriptlang.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-4.3.3-06B6D4?logo=tailwindcss&logoColor=white&style=for-the-badge)](https://tailwindcss.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-pgvector-4169E1?logo=postgresql&logoColor=white&style=for-the-badge)](https://www.postgresql.org/)
[![MCP](https://img.shields.io/badge/MCP-Streamable_HTTP-1F2937?style=for-the-badge)](https://modelcontextprotocol.io/)
[![Docker](https://img.shields.io/badge/Docker-Container-2496ED?logo=docker&logoColor=white&style=for-the-badge)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

A governed Knowledge System of Record (KSoR) for policies and operating
knowledge. One Markdown corpus in `knowledge/` produces a static human site, a
set of machine artifacts, and an MCP retrieval service with citations and
honest abstention.

---

## 📚 Project Background & Learning Context

- **Built with KSoR:** This project is built using Panaversity’s KSoR (`@panaversity/ksor`) framework/package as the foundation for a governed, MCP-powered knowledge system.
- **GIAIC Learning Journey:** This project is part of my GIAIC learning journey. I applied the concepts and practical skills learned through GIAIC to design and implement this practical MCP-powered knowledge system.
- **Clear Distinction:** Panaversity provided the KSoR framework/package used here, while GIAIC is the learning program through which I developed and applied the relevant skills. No official endorsement, sponsorship, or ownership by either organization is implied.

---

## 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Project Background & Learning Context](#-project-background--learning-context)
- [Tech Stack](#-tech-stack)
- [Architecture Overview](#-architecture-overview)
- [Project Structure](#-project-structure)
- [Environment Configuration](#-environment-configuration)
- [Installation & Setup](#-installation--setup)
- [Runtime Behavior](#-runtime-behavior)
- [Error Handling & Common Failures](#-error-handling--common-failures)
- [Build & Deployment Notes](#-build--deployment-notes)
- [Security & Constraints](#-security--constraints)
- [API Endpoints](#-api-endpoints)
- [Health Check](#-health-check)
- [API Documentation](#-api-documentation)
- [Testing](#-testing)
- [Contributing Guidelines](#-contributing-guidelines)
- [Maintainer / Author Information](#-maintainer--author-information)
- [Support & Maintenance](#-support--maintenance)
- [Live URLs](#-live-urls)
- [Connect the MCP Server](#-connect-the-mcp-server)
- [License](#-license)
- [Social / Contact](#-social--contact)

---

## 🔗 Live URLs

- **Website:** [https://handbook-aui.vercel.app](https://handbook-aui.vercel.app) – Human-readable handbook site
- **MCP Endpoint (Streamable HTTP):** [https://handbook-aui.vercel.app/mcp](https://handbook-aui.vercel.app/mcp) – Connect this to Claude, Cursor, Cline, Windsurf, Copilot, and other MCP clients
- **MCP Discovery:** [https://handbook-aui.vercel.app/.well-known/mcp/server.json](https://handbook-aui.vercel.app/.well-known/mcp/server.json) – Auto-discovery for MCP clients
- **Health Check:** [https://handbook-aui.vercel.app/health](https://handbook-aui.vercel.app/health) – Service health status
- **Readiness Check:** [https://handbook-aui.vercel.app/ready](https://handbook-aui.vercel.app/ready) – Readiness probe

## 🔌 Connect the MCP Server

You can connect this handbook as a remote MCP server to any MCP-compatible client using the Streamable HTTP endpoint below.

**MCP Endpoint:** `https://handbook-aui.vercel.app/mcp`

### Quick Setup by Client

**MCP Endpoint:** `https://handbook-aui.vercel.app/mcp`

<details>
<summary><b>Claude Desktop</b> – <code>claude_desktop_config.json</code></summary>

Go to `Settings > Developer > Edit Config` and add:

```json
{
  "mcpServers": {
    "handbook": {
      "type": "http",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>Claude Code</b> – CLI</summary>

Run this in your terminal:

```bash
claude mcp add --transport http handbook https://handbook-aui.vercel.app/mcp
```

Or add to `~/.claude.json` / `.mcp.json` in your project:

```json
{
  "mcpServers": {
    "handbook": {
      "type": "http",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>Claude.ai (claude.ai)</b> – Web/App</summary>

- **Recommended:** Use **Claude Desktop** or **Claude Code** (most reliable way to connect custom remote MCPs).
- **If available:** Some Claude.ai plans show `Settings > Integrations > MCP` / `MCP Connectors`. If visible, add a custom **HTTP/Streamable HTTP** connector with URL: `https://handbook-aui.vercel.app/mcp`. Availability depends on your plan, org, and region.
- **If missing:** Use Claude Desktop/Claude Code instead.

</details>

<details>
<summary><b>ChatGPT (chatgpt.com / OpenAI)</b> – Web/App</summary>

ChatGPT currently does **not** have a universal option to add arbitrary remote Streamable HTTP MCP servers for most users.

- **Check first:** Look for `Settings > Connectors > Add MCP` or `Apps > MCP` on your account/org. If present, add `https://handbook-aui.vercel.app/mcp` as a remote HTTP/Streamable HTTP server.
- **If missing:** Use **Claude Desktop**, **Claude Code**, **Cursor**, **Cline**, **Windsurf**, or **OpenCode** instead.

</details>

<details>
<summary><b>Cursor</b> – <code>.cursor/mcp.json</code> or Global MCP</summary>

Add to `Settings > MCP > Add new global MCP server` or `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "handbook": {
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>Cline</b> – <code>cline_mcp_settings.json</code></summary>

Go to `MCP Servers > Remote Servers > Add Server` or edit `cline_mcp_settings.json`:

```json
{
  "mcpServers": {
    "handbook": {
      "type": "streamableHttp",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>Windsurf</b> – <code>mcp_config.json</code></summary>

Go to `Settings > Cascade > MCP Servers > Add Server` or edit your `mcp_config.json`:

```json
{
  "mcpServers": {
    "handbook": {
      "serverUrl": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>Continue.dev</b> – <code>~/.continue/config.json</code></summary>

```json
{
  "mcpServers": {
    "handbook": {
      "type": "streamable-http",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>GitHub Copilot (VS Code)</b> – <code>.vscode/mcp.json</code> or <code>settings.json</code></summary>

```json
{
  "servers": {
    "handbook": {
      "type": "http",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>Gemini CLI / Gemini Code Assist</b> – <code>~/.gemini/settings.json</code></summary>

```json
{
  "mcpServers": {
    "handbook": {
      "httpUrl": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>Aider</b> – <code>~/.aider.conf.yml</code></summary>

```yaml
mcp_servers:
  - name: handbook
    type: http
    url: https://handbook-aui.vercel.app/mcp
```

</details>

<details>
<summary><b>RooCode</b> – <code>roo-cline_mcp_settings.json</code></summary>

Go to `MCP Servers > Add Remote Server` or edit the config file:

```json
{
  "mcpServers": {
    "handbook": {
      "type": "streamableHttp",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>LangGraph / LangSmith MCP</b> – Client Config</summary>

Use Streamable HTTP transport:

```json
{
  "mcpServers": {
    "handbook": {
      "transport": "streamable_http",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

<details>
<summary><b>OpenCode</b> – <code>opencode.json</code> / <code>.opencode.json</code></summary>

```json
{
  "mcp": {
    "handbook": {
      "type": "remote",
      "url": "https://handbook-aui.vercel.app/mcp"
    }
  }
}
```

</details>

> **Note:** This MCP is public and unauthenticated in its current deployment (`auth: disabled`). No API key is required. After connecting, try asking: *"Use the handbook MCP to search for the refund policy"* to verify it's working.

---

## 🎯 Project Overview

### What this project is

**Handbook** is a Knowledge System of Record. Its authoritative content lives in
`knowledge/` as CommonMark `.md` files with governed frontmatter. Everything
else derives from that corpus:

- a statically exported Next.js documentation site for people;
- per-page Markdown twins, `llms.txt`, and `llms-full.txt` for agents;
- an MCP server (`/mcp`) that serves cited retrieval over PostgreSQL/pgvector.

`instance.md` declares the record's identity, scope, database wiring, and
retrieval calibration; its body is the MCP server's instruction text.

### What problem it solves

It keeps one governed source of truth and enforces publication rules at build
time and at serve time, instead of relying on a wiki, slide deck, or model
memory:

- only `stable`, effective, unexpired, undenied documents reach machine
  surfaces;
- approval and deprecation are recorded in frontmatter and checked against
  `.ksor/governance.yaml`;
- agents get cited passages plus a calibrated abstention floor rather than
  uncited prose;
- human pages, Markdown twins, and the MCP door are generated from the same
  corpus, so they cannot disagree about content.

### System type

Full-stack record system composed of:

- **Static site (SSG)** — Next.js App Router with `output: "export"`.
- **Backend service** — `@panaversity/ksor` CLI / MCP server over TCP Postgres.
- **Knowledge base** — governed Markdown, a policy, a takedown ledger, a format
  checker, and CI validation.

It is not a CMS, a CRUD API, or a runtime editing interface. Content is authored
as files and published by a build.

---

## 🧰 Tech Stack

### Frontend

| Technology | Version | Use |
| --- | --- | --- |
| Next.js | 16.4.3 | App Router, static export, route handlers |
| React | 19.2.8 | UI runtime |
| TypeScript | 6.0.3 | Application code |
| Fumadocs (`fumadocs-core`, `fumadocs-ui`, `fumadocs-mdx`) | 16.15.4 / 16.15.4 / 15.4.0 | Docs shell, MDX pipeline, static search |
| Tailwind CSS | 4.3.3 | Styling (`@tailwindcss/postcss`) |
| Radix UI | 1.6.7 | Accessible primitives |
| `class-variance-authority`, `clsx`, `tailwind-merge` | 0.7.1 / 2.1.1 / 3.6.0 | Component composition |
| `lucide-react` | 1.31.0 | Icons |
| `tw-animate-css` | 1.4.0 | Motion utilities |
| `yaml` | 2.9.0 | Attachment/deck/quiz/slides parsing |

The component system is shadcn/ui-compatible (`system/site/components.json`,
style `new-york`, CSS variables in `app/global.css`).

### Backend / service

| Technology | Version | Use |
| --- | --- | --- |
| `@panaversity/ksor` | 0.0.60 (pinned) | Build, validation, staging, ingest, MCP server, calibrate |
| `@modelcontextprotocol/server` | ^2.3.0 | MCP transport/server runtime |
| Hono | 4.13.11 (root override) | HTTP layer inside the ksor server |
| Zod | 4.6.6 (root override) | Input/output schemas |
| `source-map-js` | 1.2.2 (pinned) | Dependency pin |
| PostgreSQL + pgvector | External | Store, vector index, denylist, generations |

### Data / retrieval

| Component | Configuration |
| --- | --- |
| Database DSN | `KSOR_DB_URL` (named by `instance.md` → `database.dsn_env`) |
| Embedding provider | Gemini by default (`gemini-embedding-001`, 1536 dimensions); OpenAI is supported by ksor when configured |
| Abstention floor | `0.681` (`instance.md` → `retrieval.vector_floor`, digest `8bfb07d0e6f5`) |
| Corpus | 6 admitted documents, 1 summary attachment, 2 generated folder indexes |

### Tooling / CI

| Tool | Use |
| --- | --- |
| Node.js ≥ 24, npm workspaces | Runtime and workspace linking (`system/site`, `system/gateways/*`, `system/packages/*`) |
| Format checker (`node .agents/skills/format-checker/check.mjs`) | Record validation (`npm run check`) |
| GitHub Actions | `.github/workflows/validate.yml` runs the format checker on push/PR |
| `npm audit` | Dependency audit (currently 0 vulnerabilities) |
| `ignore-scripts=true` (`.npmrc`) | No dependency lifecycle scripts execute on install |

### Infrastructure

| Artifact | Purpose |
| --- | --- |
| `system/site/out/` | Static site export |
| `Dockerfile` | MCP door container (`node:24-alpine`, non-root `node`, installs from `package-lock.json`) |
| `vercel.json` | Two services: static `site` and container `door`, with route rewrites |
| `.dockerignore` | Allow-list build context for the door image |

---

## 🏗 Architecture Overview

### High-level design

```text
knowledge/  (CommonMark + KSoR frontmatter)
    │
    │  ksor build
    │    validate → stage per audience → regenerate folder indexes
    │    → write build.lock.json
    │
    ├──────────────► system/site  (Next.js, output: "export")
    │                   /docs/…            human pages
    │                   /md/…              Markdown twins
    │                   /llms.txt          agent index
    │                   /llms-full.txt     full machine corpus
    │                   /api/search        static search index
    │                   /.well-known/mcp/server.json
    │
    └──────────────► ksor ingest (embeddings)
                        │
                        ▼
                PostgreSQL + pgvector
                (generation-based corpus, denylist, ledger)
                        │
                        ▼
                ksor serve  →  /mcp
                tools: search, outline, read
```

### Interaction between major parts

1. **Record → build.** `ksor build` reads `knowledge/`, validates frontmatter,
   governance, links, attachments, and lifecycle rules. It stages a
   per-audience copy under `system/site/.staged-knowledge/`, regenerates every
   folder `index.md`, and records provenance in `build.lock.json`.
2. **Build → site.** The Next.js app reads the staged corpus, prerenders all
   pages, Markdown twins, `llms.txt`, `llms-full.txt`, the search index, and the
   MCP discovery document into `system/site/out/`.
3. **Record → store.** `ksor ingest` embeds the corpus into a new generation in
   Postgres and flips the active pointer (guarded by a shrink check).
4. **Store → agents.** `ksor serve` exposes the active generation over MCP.
   Search returns passages with provenance and trust metadata; retrieval below
   the calibrated floor abstains.

### Responsibility boundaries

| Boundary | Rule enforced by the project |
| --- | --- |
| `knowledge/` vs `system/` | The record survives deletion of `system/`; the site never authors content. |
| Authored content vs code | Markdown/MDX content belongs only in `knowledge/`; content files inside the site are rejected. |
| Governance vs configuration | `.ksor/governance.yaml` authorizes approval/takedown; `instance.md` declares identity and retrieval; `.ksor/people.yaml` only controls display names. |
| Build vs serve | A build decides admission for static artifacts; the door re-evaluates admission per request. |
| Serve vs publish | `ksor serve` opens the port on the active generation; it never ingests. Publishing is `ksor ingest` / `npm run refresh`. |

---

## 📂 Project Structure

```text
handbook/
├── knowledge/                     # The record (CommonMark .md only)
│   ├── index.md                   # Generated OKF folder index (committed)
│   ├── refund-policy.md           # Stable policy document
│   ├── governance-ladder.md       # Stable document
│   ├── what-is-a-ksor.md          # Stable document
│   ├── what-is-a-ksor.summary.md  # Attachment (Type: Summary)
│   └── surfaces/
│       ├── index.md               # Generated folder index
│       ├── overview.md
│       ├── for-agents.md
│       └── for-people.md
├── system/
│   ├── gateways/
│   │   └── content.ts             # MCP tool registration (search, outline, read)
│   └── site/
│       ├── app/                   # Next.js App Router
│       │   ├── (home)/            # Landing page
│       │   ├── docs/[[...slug]]/  # Document and folder pages
│       │   ├── md/[[...slug]]/    # Markdown twin route handler
│       │   ├── llms.txt/          # Agent index route
│       │   ├── llms-full.txt/     # Full corpus route
│       │   ├── api/search/        # Static search index
│       │   ├── auth/callback/     # OAuth PKCE callback page
│       │   └── .well-known/mcp/   # MCP discovery document
│       ├── components/            # Shell, governance, decks, quizzes, search
│       ├── lib/                   # Staging, governance, audience, auth, SRS…
│       ├── record/                # Frontmatter, citations, policy, checks
│       ├── source.config.ts       # MDX collections and remark/rehype rules
│       ├── next.config.mjs        # Static export, basePath, env loading
│       ├── next-no-telemetry.mjs  # Runs Next with telemetry disabled
│       └── preview.mjs            # Static-export preview server
├── .ksor/
│   ├── governance.yaml            # Approval and takedown authorities
│   ├── people.yaml                # Actor → display name map
│   └── takedowns.yaml             # Append-only takedown ledger
├── .agents/skills/                # intake-interview, add-sources, format-checker
├── .claude/skills/                # Byte-identical skill copies for Claude Code
├── .github/workflows/
│   └── validate.yml               # Format checker on push/PR
├── instance.md                    # Identity, scope, DB, retrieval calibration
├── build.lock.json                # Build provenance (commit this)
├── package.json                   # Root scripts, workspaces, overrides
├── package-lock.json              # Reproducible dependency tree
├── Dockerfile                     # MCP door image
├── .dockerignore                  # Door build-context allow-list
├── vercel.json                    # Site + door services and rewrites
├── .env.example                   # Environment template
├── .mcp.json                      # MCP clients/servers for local tooling
├── AGENTS.md / CLAUDE.md          # Agent working contract
├── .npmrc                         # ignore-scripts=true
├── .gitignore / .gitattributes     # Ignore and line-ending policy
└── LICENSE                        # MIT
```

Generated and ignored: `node_modules/`, `system/site/.next/`,
`system/site/.source/`, `system/site/.staged-knowledge/`,
`system/site/out/`, `system/site/public/sims/`, `*.tsbuildinfo`, `.env*`,
`*.log`, `/opencode.json`, `.vercel/`.

---

## 🔧 Environment Configuration

`ksor` reads `.env` from the repository root automatically; a real environment
variable always wins. The site build also loads `NEXT_PUBLIC_*` values from the
root `.env` (build-time inlining). Only `.env.example` is tracked — never commit
`.env`.

### Required for the MCP service (DSN and key also for ingestion)

| Variable | Purpose | Required |
| --- | --- | --- |
| `KSOR_DB_URL` | PostgreSQL DSN (must have `CREATE EXTENSION vector;`). The variable NAME comes from `instance.md` → `database.dsn_env`. | ✅ |
| `GEMINI_API_KEY` | Embedding key for the default provider (`gemini-embedding-001`, 1536 dims). | ✅ (unless `OPENAI_API_KEY`) |
| `OPENAI_API_KEY` | Alternative embedding provider key. | Optional alternative |
| `KSOR_AUTH` | Door auth posture: `disabled-local` (loopback only), `disabled-public` (explicit risk), or unset with SSO configured. One of this or the SSO trio is required. | ✅ (or SSO trio) |
| `KSOR_SSO_URL` | Authorization server base URL; enables the OAuth Resource Server door. | Required together for public auth |
| `KSOR_MCP_RESOURCE_URL` | This door's resource identifier, e.g. `https://host/mcp`. | Required together for public auth |
| `KSOR_JWT_ALLOWED_AUDIENCES` | Accepted token `aud` values (normally the resource URL). | Required together for public auth |

### Optional site sign-in (all three together, build-time)

| Variable | Purpose | Required |
| --- | --- | --- |
| `NEXT_PUBLIC_KSOR_SSO_URL` | Issuer used by the browser PKCE flow. | Optional |
| `NEXT_PUBLIC_KSOR_OAUTH_CLIENT_ID` | Public OAuth client ID (no secret; PKCE). | Optional |
| `NEXT_PUBLIC_KSOR_OAUTH_REDIRECT_URI` | Literal callback URL (`/auth/callback`). | Optional |

If any of the three is missing, the sign-in control does not render. Sign-in
names a reader; it does not restrict access to the static site.

### Optional hardening and runtime tuning

| Variable | Purpose |
| --- | --- |
| `KSOR_SSO_ISSUER` | Extra issuer check on tokens. |
| `KSOR_JWKS_URL` | Override SSO key discovery. |
| `KSOR_SNAPSHOT_KEYS` | Shared `kid=secret` keys for snapshot tokens; required for multi-replica and scale-to-zero deployments. |
| `KSOR_AUDIENCE` | Comma list of audience identifiers for the door/build; always includes `public`. |
| `KSOR_MIN_TRUST_TIER` | Lowest trust tier the door answers from (`unverified` default, `machine-confirmed`, `human-reviewed`). |
| `KSOR_DRAFTS` | `show` publishes drafts to human surfaces only, `noindex`; never for a deployed build. |
| `KSOR_MCP_HOST`, `KSOR_MCP_PORT` | Door bind host/port (default loopback `127.0.0.1:8080`; `PORT` honored for platforms). |
| `KSOR_ALLOWED_HOSTS`, `KSOR_ALLOWED_ORIGINS` | Host/Origin allow-lists for a public bind. |
| `KSOR_MAX_INFLIGHT`, `KSOR_MAX_BODY_BYTES` | Request caps. |
| `KSOR_CONTENT_POOL_MAX`, `KSOR_CONTENT_POOL_MIN`, `KSOR_CONTENT_POOL_IDLE_MS` | Pool sizing (default min 0, idle close 10s). |
| `KSOR_DRAIN_TIMEOUT_MS` | Shutdown deadline (default 8000 ms). |
| `KSOR_DB_CONNECT_PER_REQUEST`, `KSOR_DB_POOLED_ENDPOINT`, `KSOR_READ_RETRY_ATTEMPTS`, `KSOR_READ_RETRY_BACKOFF_S` | Connection behavior and read retries. |
| `KSOR_MAX_SHRINK`, `KSOR_ALLOW_SHRINK` | Ingest flip guard (default 15% shrink refusal). |
| `KSOR_EMBED_TIMEOUT_S`, `KSOR_QUERY_EMBED_TIMEOUT_S`, `KSOR_EMBED_CACHE_MAX` | Embedding timeouts and cache. |
| `KSOR_BASE_PATH` | Sub-path hosting prefix for the site build. |
| `PORT`, `KSOR_PREVIEW_HOST` | Preview server port (default 3000) and bind host (default loopback). |

Next.js telemetry is disabled unconditionally by
`system/site/next-no-telemetry.mjs` (`NEXT_TELEMETRY_DISABLED=1`).

---

## 🚀 Installation & Setup

### Prerequisites

- Node.js ≥ 24 and npm (workspaces)
- PostgreSQL with pgvector (Neon or any compatible instance)
- A Gemini API key (default embedding provider) or an OpenAI key

### 1. Install dependencies

```bash
npm install
```

`.npmrc` sets `ignore-scripts=true`; no dependency lifecycle script runs.

### 2. Configure the environment

```bash
cp .env.example .env
```

Fill in at minimum:

```dotenv
KSOR_DB_URL=postgresql://user:password@host:5432/dbname
GEMINI_API_KEY=...
KSOR_AUTH=disabled-local
```

### 3. Human site only (no database)

```bash
npm run dev       # http://localhost:3000, hot reload
npm run check     # record format/governance validation
npm run build     # ksor build + static export → system/site/out/
npm run preview   # serve the built export at http://127.0.0.1:3000
```

`npm run preview` serves only the static export; run it after `npm run build`
or it exits with "does not exist — run the build first".

### 4. MCP service (database required)

```bash
npm run provision   # apply schema (ksor schema --apply) + grant ingest
npm run refresh     # ksor build + ingest --flip + gc
npm run serve       # MCP door at http://127.0.0.1:8080/mcp
```

- `npm run refresh` builds the record, embeds it into a generation, flips the
  active pointer, and collects superseded generations.
- `npm run serve` serves; it does not publish. A container restart therefore
  cannot republish the corpus.
- Re-run `npm run refresh` after editing `knowledge/`. An unchanged corpus
  consumes no generation and writes no rows.

### 5. Verify the door

```bash
curl http://127.0.0.1:8080/health
curl http://127.0.0.1:8080/ready
```

### 6. Recalibrate after material corpus changes

```bash
npx ksor calibrate --instance instance.md
npx ksor calibrate --instance instance.md --check
```

Paste the printed `retrieval:` block into `instance.md` (merge keys; never add a
second block) and restart `ksor serve`.

---

## ⚙️ Runtime Behavior

### How the app starts

| Surface | Command | Behavior |
| --- | --- | --- |
| Human site (dev) | `npm run dev` | Next dev server on port 3000, drafts visible, hot reload |
| Human site (built) | `npm run build` → `npm run preview` | Static export in `system/site/out/` served by a dependency-free Node server |
| MCP door | `npm run serve` | Boots `ksor serve`, validates config/gateway, connects to Postgres, binds `KSOR_MCP_HOST:KSOR_MCP_PORT` (or `$PORT` on 0.0.0.0) |

### Data flow

1. **Authoring:** a `.md` file in `knowledge/` with required frontmatter
   (`type`, `title`, `description`, `status`, `ksor.audience`).
2. **Build:** `ksor build` validates the record, applies lifecycle/audience
   rules, stages the viewer's copy, regenerates `index.md` files, writes
   `build.lock.json`, then Next prerenders the site and artifacts.
3. **Publish (agents):** `ksor ingest --flip` embeds changed chunks into a new
   generation, carries unchanged embeddings forward by content hash, and flips
   the active pointer after a shrink guard.
4. **Query:** MCP clients call `search`; the door embeds the query, retrieves
   from the active generation, applies the trust floor and the calibrated
   abstention floor, and returns cited passages with provenance. `outline` and
   `read` navigate the corpus; `read` accepts a snapshot token so a pinned
   generation stays readable.

### Authentication

- **MCP door:** OAuth Resource Server when `KSOR_SSO_URL` +
  `KSOR_MCP_RESOURCE_URL` + `KSOR_JWT_ALLOWED_AUDIENCES` are set. Tokens must be
  RS256; audience is enforced; signing keys are discovered from the issuer's
  RFC 8414 / OpenID metadata (with `KSOR_JWKS_URL` as an override). Every 401
  carries `WWW-Authenticate` pointing at
  `/.well-known/oauth-protected-resource/mcp`.
- **Local posture:** `KSOR_AUTH=disabled-local` binds loopback and refuses a
  public bind. `disabled-public` explicitly serves unauthenticated on a public
  interface and is intended only behind another control.
- **Site:** optional browser OAuth authorization-code + PKCE flow
  (`openid profile email`, public client, no refresh token). It provides a
  verified reader name only; it protects nothing served statically.

### State management

- The site is statically rendered; there is no server-side session store.
  Sign-in state lives in `sessionStorage`.
- Study progress (flashcards and quiz answers) is stored per reader in the
  browser and is not part of the record.
- The door holds no idle database connections by default (pool min 0, 10s idle
  close) and drains on `SIGTERM` within the configured deadline.

---

## 🧯 Error Handling & Common Failures

### Build-time refusals

| Symptom / identifier | Meaning | Recovery |
| --- | --- | --- |
| `ksor-generated-stale` | A stable document's body changed after its `generated.at`, or the stamp was backdated. | Move `generated.at` past the edit and re-approve with a later timestamp. |
| `ksor-build-dirty` (`--strict`) | Uncommitted input during a strict build. | Commit first, or build without `--strict`. |
| `ksor-link-widens` | A link/summary/supersession points to a document not every reader of the source may read. | Restrict the target or widen the source audience. |
| `ksor-supersession-strands` | `ksor.superseded_by` names a missing, non-stable, or unreadable successor. | Fix the pointer or the successor. |
| `ksor-quiz-answer-bias`, `ksor-quiz-length-bias`, `ksor-quiz-answer-run`, `ksor-quiz-contradiction`, `ksor-quiz-duplicate-stem` | Quiz hygiene audit failed during the site build. | Rewrite the quiz: spread answers, balance option length, fix contradictions/duplicates. |
| `ksor-gateway-floor-missing`, `ksor-gateway-no-tools`, `ksor-gateway-unloadable` | The MCP registration dropped a required guarantee, registered no tools, or cannot load. | Restore `FLOOR.*`, at least one tool, and valid `content.ts`. |
| `ksor-file-type`, `ksor-site-holds-content` | Non-CommonMark file, or authored content inside `system/site`. | Move content to `knowledge/`; use `.md` only. |
| `ksor-ledger-unverifiable` | Shallow Git history cannot prove the takedown ledger is append-only. | Fetch full history (`fetch-depth: 0`). |

### Runtime failures

| Symptom | Cause | Recovery |
| --- | --- | --- |
| `ksor serve` refuses to boot | Missing/undeclared auth, or `disabled-local` on a public bind | Set `KSOR_AUTH` deliberately, or configure the SSO variables; for a container smoke test use `-e KSOR_AUTH=disabled-public`. |
| Missing DSN / key error at boot | `KSOR_DB_URL` or the embedding key is unset | Fill `.env`; the error names the variable wanted. |
| First request slow / connection error | Serverless Postgres waking up | Read retries handle connection-level failures; no action needed. |
| `read` reports `refreshed (invalid)` | Snapshot token signed by a different process | Set a shared `KSOR_SNAPSHOT_KEYS` on multi-replica or scale-to-zero hosts. |
| Ingest refuses to flip | Corpus shrank beyond `KSOR_MAX_SHRINK` (default 15%) | Confirm the deletion, then set `KSOR_ALLOW_SHRINK=1` for that ingest. |
| Query atypically answered/refused | Floor drift as the corpus grows | Run `npx ksor calibrate --instance instance.md --check`; recalibrate if WATCH. |
| Preview exits: "does not exist" | `system/site/out/` missing | Run `npm run build` first. |
| Preview `EADDRINUSE` | Port 3000 already used (often by `dev`) | Stop the other process or set `PORT=3001`. |
| `npm run check` failure | Frontmatter, filename, link, or governance rule violation | Read the named slug and fix location; the checker explains the fix. |

---

## 📦 Build & Deployment Notes

### Build pipeline

```bash
npm run build
```

1. `ksor build` validates the record, stages the public viewer's corpus,
   regenerates folder indexes, and writes `build.lock.json`.
2. `npm --prefix system/site run build` runs Next through
   `next-no-telemetry.mjs` and exports static HTML/JSON/text into
   `system/site/out/`.

`npm run build` fails before writing output if the record is invalid. Commit
`build.lock.json`: it is the provenance stamped into the build's artifacts.

### Hosting the site

- Any static host can serve `system/site/out/`. The export uses
  `trailingSlash: true` and unoptimized images.
- Sub-path hosting: `KSOR_BASE_PATH=/repo npm run build`.
- `vercel.json` declares a static `site` service and a container `door`
  service, rewriting `/mcp(.*)`, `/.well-known/oauth-protected-resource(.*)`,
  `/health`, and `/ready` to the door, with a catch-all last to the site.

### Deploying the door

```bash
docker build -t handbook-door .
docker run --rm -p 8080:80 --env-file .env \
  -e KSOR_AUTH=disabled-public handbook-door
```

- The image installs from `package-lock.json` (`npm ci --omit=dev
  --workspaces=false`), honours `ignore-scripts`, and runs as user `node`.
- `ENV PORT=80` makes it a public bind, so `disabled-local` correctly refuses;
  the explicit `-e` acknowledges that for a smoke test. A real deployment uses
  SSO variables or its gateway.
- The image excludes `.env`, `knowledge/`, and `system/site/`: the door reads
  Postgres, not the folder.

### Publish vs serve

- Deploy steps: `npm run provision` (once), then `npm run refresh`.
- Container runtime: `ksor serve` only.
- First deploy without ingest serves nothing; subsequent restarts keep serving
  the last flipped generation.
- Set `KSOR_SNAPSHOT_KEYS` on any multi-replica or scale-to-zero host.
- Collect superseded generations with `npm run gc`.

### Static snapshot semantics

`llms.txt`, `llms-full.txt`, and `/md/*` are snapshots written at build time.
A document whose `stale_after` passes after a build remains in those files until
the next build and redeploy, while `ksor serve` already refuses it per request.
No scheduled rebuild exists in the repository.

---

## 🔐 Security & Constraints

### Implemented controls

- **Secrets:** `.env` is gitignored; only `.env.example` is tracked; real
  environment variables take precedence.
- **Door auth:** fail-closed boot. A public bind requires explicit SSO
  configuration or a deliberate `disabled-public`. RS256 only; audience
  enforced; issuer optional; JWKS discovered.
- **Dependency posture:** pinned `ksor` and lockfile; root overrides for
  `hono`, `zod`, `sharp`, `source-map-js`; `.npmrc` disables lifecycle
  scripts; `npm audit` reports 0 vulnerabilities.
- **Container:** non-root user, lockfile install, allow-listed build context.
- **Governance:** approval and takedown authorities live in
  `.ksor/governance.yaml`; every takedown entry is validated against policy in
  `npm run check`, `ksor build`, ingest, and CI; the ledger is append-only.
- **Publication rules:** drafts, deprecated, not-yet-effective, expired, and
  denied documents are excluded from machine surfaces; audience staging filters
  the corpus before every surface is derived.
- **Agent safety:** the MCP floor text is mandatory (`ksor-gateway-floor-missing`
  otherwise) and corpus content is treated as untrusted by clients; abstention
  is explicit below the calibrated floor.
- **Site privacy:** no external font/CDN fetches at build or render; Next
  telemetry disabled; search runs client-side over a static index; embeds load
  only on click.

### Explicit limitations

- **Publication is not authorship.** Anyone who can clone the repository reads
  every document regardless of `ksor.audience`; a static site serves every
  emitted page. Audience controls which surface may publish a document, not
  who can access the bytes. Restricting readers requires a separate repository
  or host-level access control.
- **Sign-in does not authorize.** The site's optional OIDC flow identifies a
  reader; it does not gate content.
- **Static artifacts age.** `stale_after` and takedowns are re-evaluated at the
  next build for `llms.txt`/`llms-full.txt`/`/md/*`.
- **Calibration is corpus-specific and time-sensitive.** The floor `0.681` was
  measured on generation 9 with 10 in-corpus and 12 out-of-corpus probes
  (out-of-corpus max `0.653`, in-corpus min `0.709`). It must be re-measured as
  the corpus grows.
- **MCP requires PostgreSQL + pgvector** and an embedding provider; the site
  does not.
- **No repository test suite.** Validation gates are the format checker, the
  site build's audits, `npm audit`, and CI; there are no unit/E2E test files in
  the repository.
- **Single record per deployment.** `instance.md` defines one corpus identity;
  serving multiple records means multiple deployments.

---

## 🌐 API Endpoints

### Static site (prerendered)

| Method | Path | Description |
| --- | --- | --- |
| `GET` | `/` | Landing page for the record |
| `GET` | `/docs/` and `/docs/{path}/` | Document pages; folder routes render generated indexes |
| `GET` | `/md/index.md` | Markdown twin of the record index |
| `GET` | `/md/{path}.md` | Markdown twin of a machine-admitted document |
| `GET` | `/llms.txt` | Agent-facing index (admitted documents only) |
| `GET` | `/llms-full.txt` | Full machine corpus with frontmatter and build stamps |
| `GET` | `/api/search` | Static search index consumed by the browser dialog |
| `GET` | `/.well-known/mcp/server.json` | MCP server discovery document |
| `GET` | `/auth/callback` | OAuth PKCE callback page (client-side) |

### MCP door (`ksor serve`)

| Method | Path | Description |
| --- | --- | --- |
| `POST` | `/mcp` | MCP Streamable HTTP endpoint (JSON-RPC; tools below) |
| `GET` | `/health` | Liveness plus corpus, generation, gate, embedding, auth state |
| `GET` | `/ready` | Readiness probe (`{"ready":true}` when serving) |
| `GET` | `/.well-known/oauth-protected-resource/mcp` | OAuth resource metadata (present only when the SSO door is configured) |

---

## ❤️ Health Check

`GET /health` returns the record's live state. Example from this deployment:

```json
{
  "corpus_id": "handbook",
  "store": "reachable",
  "boot_checks": "passed",
  "generation": "9 — 7 nodes — source aab8db90aeef2833dc03ef410b7130785ab78039",
  "abstain_gate": "floor 0.681 — below it, this record abstains",
  "embedding_space": "gemini-embedding-001/d1536 ok",
  "auth": "disabled"
}
```

`GET /ready`:

```json
{ "ready": true }
```

---

## 📚 API Documentation

There is no OpenAPI/Swagger or ReDoc document in this repository. The machine
API is the MCP surface. Its tool definitions are authored in
`system/gateways/content.ts` and advertised over MCP; the discovery document is
served at `/.well-known/mcp/server.json`.

| Tool | Inputs | Behavior |
| --- | --- | --- |
| `search` | `query` (1–2000 chars), `k` (1–`MAX_SEARCH_K`, default 10), `min_trust_tier` (`unverified` / `machine-confirmed` / `human-reviewed`) | Returns cited passages with provenance, trust tier, and snapshot metadata; abstains below the calibrated floor. |
| `outline` | `node` (optional slug/path), `depth` (0–5), `limit` (default 200), `offset` | Browses the record tree with paging. |
| `read` | `slug`, `heading`, `from_heading`, `snapshot_token`, `token_budget` (100–70000, default 70000) | Reads a document or a heading subtree at a pinned generation. |

The server's instruction text is `instance.md`'s body composed beneath the
framework floor; the MCP server name is `ksor` in the current registration.

---

## 🧪 Testing

The repository does not contain a unit or end-to-end test suite. The available
validation gates are:

```bash
# Record format, frontmatter, links, filenames, governance
npm run check

# Full build: record validation, staging, site generation, quiz audits
npm run build

# Dependency audit (production and dev)
npm audit

# CI (GitHub Actions): format checker on push to main and on pull requests
node .agents/skills/format-checker/check.mjs
```

The build also runs record-level audits (for example quiz hygiene and link
widening), so a failing build is a content or governance failure, not merely a
compilation failure.

---

## 🤝 Contributing Guidelines

1. Read `AGENTS.md` before editing; it is the working contract.
2. Create a branch; do not commit directly to `main`.
3. Put content only in `knowledge/`; never add authored Markdown inside
   `system/site`.
4. Run `npm run check` before opening a pull request.
5. Stable documents require `generated` and `ksor.approval` entries naming an
   actor authorized in `.ksor/governance.yaml`; approvals are the owner's act.
6. Never commit secrets, build output, or generated directories.
7. Describe the change, the affected documents, and the verification commands
   in the pull request.
8. Report security issues privately to the maintainer contact listed below.

---

## 👤 Maintainer / Author Information

| Role | Name | Contact |
| --- | --- | --- |
| Maintainer / Author | Afaq Ul Islam | [afaqulislam707@gmail.com](mailto:afaqulislam707@gmail.com) |
| GitHub | [@afaqulislam](https://github.com/afaqulislam) | [github.com/afaqulislam](https://github.com/afaqulislam) |
| LinkedIn | Afaq Ul Islam | [linkedin.com/in/afaqulislam](https://www.linkedin.com/in/afaqulislam) |
| Website | [afaqulislam.vercel.app](https://afaqulislam.vercel.app) | [afaqulislam.vercel.app](https://afaqulislam.vercel.app) |

---

## 🛠 Support & Maintenance

- **Issue tracking:** [github.com/afaqulislam/handbook/issues](https://github.com/afaqulislam/handbook/issues)
- **Support email:** [afaqulislam707@gmail.com](mailto:afaqulislam707@gmail.com)
- **Maintainer:** Afaq Ul Islam

Operational checklist visible in the repository:

```bash
npm run check                 # before merging content changes
npm run refresh               # after editing knowledge/
npx ksor calibrate --instance instance.md --check   # monitor floor drift
npm run gc                    # collect superseded generations
npm audit                     # dependency review
```

---

## 📄 License

MIT License — see [`LICENSE`](LICENSE).

Copyright © 2026 Afaq Ul Islam.

---

## 🔗 Social / Contact

| Platform | Link |
| --- | --- |
| GitHub | [github.com/afaqulislam](https://github.com/afaqulislam) |
| LinkedIn | [linkedin.com/in/afaqulislam](https://www.linkedin.com/in/afaqulislam) |
| X / Twitter | [x.com/afaqulislam708](https://x.com/afaqulislam708) |
| Website | [afaqulislam.vercel.app](https://afaqulislam.vercel.app) |
| Email | [afaqulislam707@gmail.com](mailto:afaqulislam707@gmail.com) |

---

<p align="center">
  <sub>Handbook — a governed Knowledge System of Record. Content in <code>knowledge/</code>; everything else derives from it.</sub>
</p>
