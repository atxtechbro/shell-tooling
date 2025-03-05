#!/bin/bash

# Get the latest workflow run ID
run_id=$(gh run list -L 1 | awk '{print $1}')

# Get the run conclusion (e.g., "success", "failure")
conclusion=$(gh run view $run_id --json conclusion | jq -r '.conclusion')

# Check if the run failed
if [[ "$conclusion" == "failure" ]]; then
  # View the failed logs
  gh run view $run_id --log-failed
else
  echo "The latest workflow run was successful."
fi