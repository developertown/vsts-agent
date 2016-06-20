FROM ubuntu:16.04

ENV VSTS_VERSION "2.102.0"

RUN \
     apt update \
  && apt upgrade -y

# install vsts pre-reqs and basic build environment items
RUN \
     apt-get install -y \
       libunwind8 \
       libcurl3 \
       curl \
       build-essential \
       git \
  && curl -LOs http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu52_52.1-8ubuntu0.2_amd64.deb \
  && dpkg -i libicu52_52.1-8ubuntu0.2_amd64.deb \
  && rm -f libicu52_52.1-8ubuntu0.2_amd64.deb


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


# Copy in and run custom start wrapper
COPY start.sh ./
CMD ["./start.sh"]
