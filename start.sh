#!/usr/bin/env bash

if [ "$VSTS_URL" = "" ]; then
  (>&2 echo "The VSTS_URL environment variable must be set (e.g., https://myco.visualstudio.com)")
  exit 1
fi

if [ "$VSTS_PAT_TOKEN" = "" ]; then
  (>&2 echo "The VSTS_PAT_TOKEN environment variable must be set to the PAT token for a user with the 'Agent Pool Service Accounts' Role")
  exit 1
fi

if [ "$VSTS_AGENT_NAME" = "" ]; then
  VSTS_AGENT_NAME="$HOSTNAME"
fi

cd $HOME
source ~/.bashrc

T=$VSTS_PAT_TOKEN
unset VSTS_PAT_TOKEN
./config.sh remove
./config.sh --unattended --replace --nostart --url ${VSTS_URL} --agent "$AGENT_FLAVOR-${VSTS_AGENT_NAME}" --pool ${VSTS_POOL:-Default} --auth PAT --token ${T}

#exec /usr/bin/monit -c /usr/local/vsts-agent/monit.conf
exec bin/Agent.Listener run
