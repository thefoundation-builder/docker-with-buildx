#!/bin/bash

##
GITHUB_RUNNER_TOKEN=$1
RUNNER_REPO=$2
CI_PIPELINE_ID=$3
JOB_ID=$4
curl -H "Authorization: token ${GITHUB_RUNNER_TOKEN}" -H 'Accept: application/vnd.github.everest-preview+json' \
     "https://api.github.com/repos/${RUNNER_REPO}/dispatches" -d '{"event_type": "gitlab_trigger_'${JOB_ID}.${CI_PIPELINE_ID}'", "client_payload": {"job_id": "'$JOB_ID'"}}'
