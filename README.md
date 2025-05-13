# github-actions-runner-dockerized

## run the below commands

git clone repo

### Go to the folder
cd /github-actions-runner-dockerized

### Build the docker image
docker build -t gh-runner:latest .

### Run the container
docker run -d --name my-runner \
  -e GITHUB_URL="https://github.com/OWNER/REPO" \
  -e RUNNER_TOKEN="YOUR_REPO_REG_TOKEN" \
  gh-runner:latest
