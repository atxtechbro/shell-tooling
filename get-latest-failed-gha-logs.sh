#!/bin/bash

# Get the repository owner and name from the origin remote
remote_url=$(git remote get-url origin)
repo_owner=$(echo "$remote_url" | sed -E 's#.*github.com[:/]([^/]+)/.*#\1#')
repo_name=$(echo "$remote_url" | sed -E 's#.*github.com[:/].*/([^/]+).*#\1#')

# Get the latest workflow run ID (using jq)
run_id=$(gh run list -L 1 --json databaseId -R "$repo_owner/$repo_name" | jq -r '.[0].databaseId')

# Get the run conclusion (e.g., "success", "failure")
conclusion=$(gh run view $run_id --json conclusion -R "$repo_owner/$repo_name" | jq -r '.conclusion')

# Check if the run failed
if [[ "$conclusion" == "failure" ]]; then
  # View the failed logs
  gh run view $run_id --log-failed -R "$repo_owner/$repo_name"
else
  echo "The latest workflow run was successful."
fi