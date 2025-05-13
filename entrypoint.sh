#!/bin/bash
set -e

# Expect these env vars to be passed in at runtime:
#   GITHUB_URL     e.g. https://github.com/OWNER/REPO or https://github.com/ORG
#   RUNNER_TOKEN   PAT or registration token with repo/org scope
# Optional:
#   RUNNER_NAME    defaults to container hostname
#   RUNNER_WORKDIR defaults to /_work inside the container

if [ -z "$GITHUB_URL" ] || [ -z "$RUNNER_TOKEN" ]; then
  echo "ERROR: You must define GITHUB_URL and RUNNER_TOKEN"
  exit 1
fi

# Configure runner (unattended)
./config.sh \
  --unattended \
  --url "$GITHUB_URL" \
  --token "$RUNNER_TOKEN" \
  --name "${RUNNER_NAME:-$(hostname)}" \
  --work "${RUNNER_WORKDIR}" \
  --replace

# Graceful shutdown: remove runner registration on SIGINT/SIGTERM
cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token "$RUNNER_TOKEN"
}
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

# Finally, launch the runner service
exec ./run.sh

