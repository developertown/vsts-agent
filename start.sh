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
  (>&2 echo "The VSTS_AGENT_NAME environment variable must be set to a unique name for the agent.  Existing agents with the same name will be replaced")
  exit 1
fi

cd $HOME
T=$VSTS_PAT_TOKEN
unset VSTS_PAT_TOKEN
bin/Agent.Listener configure --unattended --replace --nostart --url ${VSTS_URL} --agent ${VSTS_AGENT_NAME} --pool ${VSTS_POOL:-Default} --auth PAT --token ${T}

exec bin/Agent.Listener run
