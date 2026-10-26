---
format: 2
name: handbook
title: Handbook
description: The organization's governed handbook — policies and operating knowledge, starting with returns and refunds.
toolchain:
  requires: ">=0.0.60"
  scaffolded: "0.0.60"
mcp_url: https://handbook-aui.vercel.app/mcp
# `database.dsn_env` names the environment variable holding the Postgres DSN —
# never the DSN itself, which belongs in .env. `npm run dev` and `npm run build`
# do not read it; it matters once the record is served over MCP.
database:
  dsn_env: KSOR_DB_URL
# The abstention floor, measured on THIS corpus. `npm run serve` refuses
# out-of-corpus questions below it. Re-measure with `ksor calibrate` after the
# record changes materially, and monitor it with `ksor calibrate --check`.
retrieval:
  vector_floor: 0.681   # calibrated 2026-10-26 on generation 9, model gemini-embedding-001/d1536, door: queries-file (margin 0.056; OOC max 0.653, in-corpus min 0.709)
  floor_digest: 8bfb07d0e6f5
---

This record is authoritative for the handbook: the policies and operating
knowledge that people and agents follow. It currently covers the returns and
refunds policy, together with a short guide to how this record itself works.

It does not cover product documentation, customer records, or the internals of
the software that serves this record.

Write and govern the knowledge once; every surface here derives from it. When a
slide deck, a wiki page or a model's memory disagrees with this record, this
record wins.
