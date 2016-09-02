#!/bin/bash

. ./REVISIONS

NEXT_IMAGE_REV=$(($IMAGE_REV + 1))
NEW_TAG=$UPSTREAM_AGENT_REV-$NEXT_IMAGE_REV


echo ""
echo "WARNING:"
echo "  Building and pushing :latest and :$NEW_TAG in 5 seconds (or ctrl-c-nope your way out):"
echo ""
for i in $(seq 5 1); do
  sleep 1
  echo $i
done

docker build -t developertown/vsts-agent:latest . \
  && docker tag developertown/vsts-agent:latest developertown/vsts-agent:$NEW_TAG \
  && docker push developertown/vsts-agent:latest \
  && docker push developertown/vsts-agent:$NEW_TAG \
  && echo "export UPSTREAM_AGENT_REV=$UPSTREAM_AGENT_REV" > REVISIONS \
  && echo "export IMAGE_REV=$NEXT_IMAGE_REV" >> REVISIONS
