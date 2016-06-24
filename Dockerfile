FROM ubuntu:16.04

ENV VSTS_VERSION "2.102.0"

RUN apt-get update

# install vsts pre-reqs and basic build environment items
RUN \
     apt-get install -y \
       apt-transport-https \
       ca-certificates \
       libunwind8 \
       libcurl3 \
       curl \
       build-essential \
       git \
  && curl -LOs http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu52_52.1-8ubuntu0.2_amd64.deb \
  && dpkg -i libicu52_52.1-8ubuntu0.2_amd64.deb \
  && rm -f libicu52_52.1-8ubuntu0.2_amd64.deb

# Setup the docker apt repository
RUN \
     apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
  && echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list \
  && apt-get update \
  && apt-get install -y docker-engine

# install vsts agent
RUN \
  adduser \
    --disabled-password \
    --home /usr/local/vsts-agent \
    --shell /bin/bash \
    --gecos "VSTS Agent" \
    vsts

WORKDIR /usr/local/vsts-agent
USER vsts

RUN \
     curl -Ls https://github.com/Microsoft/vsts-agent/releases/download/v${VSTS_VERSION}/vsts-agent-ubuntu.14.04-x64-${VSTS_VERSION}.tar.gz \
   | tar xvzf - \
  && mkdir /usr/local/vsts-agent/_work

VOLUME ["/var/run/docker.sock"]

# Copy in and run custom start wrapper
COPY start.sh ./
CMD ["./start.sh"]
