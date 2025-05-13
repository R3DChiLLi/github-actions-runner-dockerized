FROM ubuntu:20.04

ENV RUNNER_VERSION=2.323.0 \
    RUNNER_NAME=self-hosted-runner \
    RUNNER_WORKDIR=/_work

# install deps…
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      ca-certificates curl git iputils-ping jq libcurl4 libicu66 \
      libkrb5-3 libssl1.1 liblttng-ust0 unzip && \
    rm -rf /var/lib/apt/lists/*

# create runner user & workdir
RUN useradd --create-home runner && \
    mkdir -p /actions-runner /_work && \
    chown -R runner:runner /actions-runner /_work

WORKDIR /actions-runner

# download & unpack the runner as before
RUN curl -fsSL \
      -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
      https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
 && tar zxvf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
 && rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# drop to non-root
USER runner

ENTRYPOINT ["/entrypoint.sh"]

