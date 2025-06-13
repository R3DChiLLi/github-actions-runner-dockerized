#!/bin/bash

REPO=$REPO
ACCESS_TOKEN=$TOKEN

# Generate a unique label for the runner based on the hostname or container ID
LABEL="custom-$(hostname)"

REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)

cd /home/docker/actions-runner

# Add the --labels option to assign the custom label
./config.sh --url https://github.com/${REPO} --token ${REG_TOKEN} --disableupdate --unattended --replace --labels ${LABEL}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
