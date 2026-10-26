# Handbook

A governed Knowledge System of Record (KSoR) that keeps policies and operating knowledge in one source of truth and publishes them to both humans and agents with consistent governance.

## Overview

- **Record vs system**: Knowledge lives in [`knowledge/`](knowledge/) as governed Markdown. Code lives in [`system/`](system/) and serves the record (Next.js site + MCP door). The record remains readable even if the system is removed.
- **Current scope**: Starts with the returns and refunds policy ([`knowledge/refund-policy.md`](knowledge/refund-policy.md), stable and approved). The corpus also includes short guides on how this record works.
- **Single source of truth**: One build produces the human site, machine artifacts (`llms.txt`/`llms-full.txt`), and the MCP surface. Approval/status/lifecycle rules are enforced at build and serve time.

## Architecture

| Path | Purpose |
|---|---|
| [`knowledge/`](knowledge/) | Authoritative Markdown documents (CommonMark only). |
| [`system/site/`](system/site/) | Next.js app that renders the record into a static site. |
| [`system/gateways/`](system/gateways/) | MCP door registration and content gateway. |
| [`instance.md`](instance.md) | Project identity, database wiring, and MCP instructions. |
| [`.ksor/`](.ksor/) | Governance (`governance.yaml`, `people.yaml`, `takedowns.yaml` ledger). |
| [`.agents/skills/`](.agents/skills/) | Format checker and intake/add-sources skills. |

## Prerequisites

- Node.js ≥ 24
- npm (workspace-aware)
- A Postgres database with [pgvector](https://github.com/pgvector/pgvector) (e.g. [Neon](https://neon.tech/))
- An embedding provider key (`GEMINI_API_KEY` by default; `OPENAI_API_KEY` also supported)

## Quick Start

### 1) Install
```bash
npm install
```

### 2) Configure environment
Copy `.env.example` to `.env` and fill in values. `.env` is gitignored.
```bash
cp .env.example .env
```
Required:
- `KSOR_DB_URL` — Postgres DSN (needs `CREATE EXTENSION vector;`)
- `GEMINI_API_KEY` — for embeddings (free tier is enough)
- `KSOR_AUTH=disabled-local` — required for local MCP serve (loopback only)

### 3) Provision, publish, and serve
```bash
npm run provision  # apply schema + grant ingest permissions (once)
npm run refresh    # build + ingest corpus into a generation and flip it
npm run serve      # start MCP door at http://127.0.0.1:8080/mcp
```

### 4) Run the site
```bash
npm run dev   # http://localhost:3000
npm run build # static site to system/site/out/
npm run check # format/lint check on knowledge/
```

## Agent Surface (MCP)

1. Start the door: `npm run serve` (binds loopback by default; will refuse public bind without auth configured).
2. Connect your agent to `http://127.0.0.1:8080/mcp`. Example for opencode:
   ```bash
   opencode mcp add handbook --url http://127.0.0.1:8080/mcp
   ```
3. The door serves cited retrieval with governance metadata. After calibrating, the abstention gate is active (see below).
4. For public deployment, configure SSO (`KSOR_SSO_URL`, `KSOR_MCP_RESOURCE_URL`, `KSOR_JWT_ALLOWED_AUDIENCES`) and remove `KSOR_AUTH=disabled-local`. See [`docs/deploying.md`](node_modules/@panaversity/ksor/docs/deploying.md) if present.

### Calibrating the abstention floor
The record ships with a calibrated retrieval floor in `instance.md` (measured on this corpus). Re-calibrate after material changes to the corpus:
```bash
npx ksor calibrate --instance instance.md
```
Paste the printed `retrieval:` block into `instance.md` and restart the serve. Monitor drift with `npx ksor calibrate --instance instance.md --check`.

## Writing & Governing Knowledge

- **Location**: Add one Markdown file per document under `knowledge/`. Path = document identity/URL.
- **Frontmatter**: Required `type`, `title`, `description`, `status` (`draft|stable|deprecated`), `ksor.audience`. `stable` requires `generated` and `ksor.approval` by an authorized actor; `deprecated` requires `ksor.deprecated` and usually `ksor.superseded_by`.
- **Sources**: Cite sources in `sources` and reference with GFM footnotes `[^id]`.
- **Structure for retrieval**: one topic per `##` section, and name the searchable subject in the heading — chunks and embeddings follow the heading path.
- **Trust**: `verified` entries affect trust tier; policy does not restrict who may appear in `verified`.
- **Pre-publish**: All drafts are hidden from published surfaces. Use `npm run dev` to preview.
- **Checks**: Run `npm run check` before committing knowledge changes.
- **Takedowns**: Use `npx ksor takedown` (writes to `.ksor/takedowns.yaml`, enforced by build and door).

See [`AGENTS.md`](AGENTS.md) and [`.agents/skills/`](.agents/skills/) for full rules.

## Commands

| Command | Description |
|---|---|
| `npm run dev` | Run human site in dev mode (hot reload). |
| `npm run build` | Check record, generate artifacts, write `build.lock.json`, build static site. |
| `npm run preview` | Preview the built site. |
| `npm run check` | Run format checker on the record. |
| `npm run provision` | Apply schema and grant ingest permissions. |
| `npm run refresh` | `build` + `ingest` + `gc` (publish changes). |
| `npm run serve` | Start MCP door. |
| `npm run schema` | Apply DB schema only. |
| `npm run grant` | Grant ingest permissions only. |
| `npm run ingest` | Ingest corpus into a generation and flip it. |
| `npm run gc` | Remove superseded generations. |

## Build & Deployment

- **Static site**: `npm run build` outputs to `system/site/out/`. Deploy to any static host.
- **Vercel**: [`vercel.json`](vercel.json) defines `site` (static output) and `door` (container) services with rewrites routing `/mcp`, `/.well-known/*`, `/health`, `/ready` to the door.
- **Docker**: [`Dockerfile`](Dockerfile) builds the MCP door. It installs the audited tree from `package-lock.json` (`npm ci`, no lifecycle scripts) and runs as the unprivileged `node` user. Bind to `$PORT` (0.0.0.0). Set `KSOR_SNAPSHOT_KEYS` for multi-replica/scale-to-zero. Note: `KSOR_AUTH=disabled-local` is refused on public binds, so a container run needs `-e KSOR_AUTH=disabled-public` (or the SSO variables).
- **Important**: Serving (`npm run serve`) does not publish. Run `npm run refresh` / `npm run ingest` as a deploy step before starting the door in containers.

## Security

- **Secrets**: Never commit `.env`. Only `.env.example` is tracked. Real env vars always override `.env`.
- **Auth**: Local default is loopback-only auth disabled; a public bind refuses to boot unauthenticated. For public access, configure the SSO OAuth Resource Server.
- **Token signing**: On multi-replica or scale-to-zero deployments, set `KSOR_SNAPSHOT_KEYS` (shared) or snapshot tokens won't verify across instances.
- **Dependencies**: `@panaversity/ksor` pinned at 0.0.60, `@modelcontextprotocol/server` 2.3.0, `next` 16.4.3. Root `overrides` lift `hono` to 4.13.11 and `zod` to 4.6.6; `sharp` and `source-map-js` are pinned too. `npm audit` reports **0 vulnerabilities** (production and dev), and `npm ci` reproduces the tested tree.
- **Install scripts**: `.npmrc` sets `ignore-scripts=true`, so no dependency executes a lifecycle script during install. This is deliberate package-manager hardening, not a missing step.
- **Checks**: CI runs the format checker ([`.github/workflows/validate.yml`](.github/workflows/validate.yml)); secrets are never committed (`.env` is ignored, only `.env.example` is tracked).

## Known Limitations

- **Abstention gate**: calibrated 2026-10-26 on generation 9 with 10 in-corpus and 12 out-of-corpus probes: floor **0.681**, out-of-corpus max 0.653, in-corpus min 0.709 (margin 0.056). With a small corpus the margin is tight; re-calibrate after material changes and monitor with `npx ksor calibrate --instance instance.md --check`.
- **Retrieval shape**: the chunker is heading-aware (one chunk per section, title + heading path embedded). Keep documents sectioned with `##` headings that name the subject, or a long mixed document dilutes narrow queries — the proof-of-purchase section in `knowledge/refund-policy.md` is the worked example.
- **Synthesis calibration**: Gemini text model `gemini-3.7-flash` may be temporarily unavailable (high demand) — use `--queries-file` as a fallback.
- **Starter content**: The record includes KSoR explanation documents alongside the handbook policy; they can be replaced/removed as your handbook grows.

## Contributing

Changes to `knowledge/` must pass `npm run check`. Stable documents require proper `generated`/`ksor.approval` entries by authorized actors (see [`.ksor/governance.yaml`](.ksor/governance.yaml)). Display names live in [`.ksor/people.yaml`](.ksor/people.yaml).

## License

MIT — see [LICENSE](LICENSE).

## References

- [`AGENTS.md`](AGENTS.md) — full working contract and detailed rules
- [`instance.md`](instance.md) — project identity and MCP instructions
- [`package.json`](package.json) — available scripts
- KSoR docs — `node_modules/@panaversity/ksor/docs/` after `npm install` (building, deploying, ingesting, and tool surface)
