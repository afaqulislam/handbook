# The MCP door, as an ordinary container.
#
# Nothing here names a host. It installs the pinned `@panaversity/ksor` from
# the committed lockfile, listens on $PORT, and runs `ksor serve` — which is all Cloud Run,
# Fly, Render, ECS, Kubernetes or a plain VPS asks for. `vercel.json` points AT
# this file rather than replacing it, so the artifact stays portable and the host
# stays a choice.
#
# Build and run it anywhere:
#   docker build -t my-record .
#   docker run --rm -p 8080:80 --env-file .env -e KSOR_AUTH=disabled-public my-record
#
# The -e is not optional. ENV PORT below makes this a PUBLIC bind (0.0.0.0), and
# the KSOR_AUTH=disabled-local a local .env carries refuses there on purpose —
# see the CMD comment. Keep the deliberate value on the command, not in .env.
#
# This image serves; it does not publish. `ksor ingest` is a write plane that
# runs from CI or your machine against the same database — see the deployment
# guide in node_modules/@panaversity/ksor/docs/deploying.md.

FROM node:24-alpine

WORKDIR /app

# The manifest AND the lockfile, so the image installs the tree that was
# audited and tested rather than whatever the ranges resolve to that day.
# `.npmrc` carries `ignore-scripts=true`: no dependency runs a postinstall
# script in here. `--workspaces=false` keeps the site's dependencies out: this
# image is the door, and the site is built and hosted separately.
COPY package.json package-lock.json .npmrc ./
RUN npm ci --omit=dev --workspaces=false --no-audit --no-fund

# The record's identity and configuration, and this door's own MCP registration.
#
# NAMED, not `COPY . ./`. A .dockerignore is not honoured by every builder —
# Vercel's is not, and `COPY . ./` there swept in node_modules and the built
# site, producing a registry push rejected as PAYLOAD_TOO_LARGE (found live).
# Naming what enters the image is the only form that is portable across build
# hosts. The risk of naming things is forgetting one; that is covered by a test
# which boots the built image and asserts it serves the tools this file names.
COPY --chown=node:node instance.md ./
COPY --chown=node:node system/gateways/ ./system/gateways/

# Most container hosts inject PORT; 80 is a sane default when nothing does.
ENV PORT=80
EXPOSE 80

# `ksor serve` refuses to boot unauthenticated on a public bind. That posture
# belongs to the record, not to the host, so it travels inside the image.
# Run as the unprivileged `node` user; nothing the door writes belongs to root.
USER node
CMD ["node_modules/.bin/ksor", "serve", "--instance", "instance.md"]
