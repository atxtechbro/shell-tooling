#!/bin/bash

# Log the start of the script
echo "Starting script to get latest failed workflow logs..."

# Get the repository owner and name from the origin remote
remote_url=$(git remote get-url origin)
repo_owner=$(echo "$remote_url" | sed -E 's#.*github.com[:/]([^/]+)/.*#\1#')
repo_name=$(echo "$remote_url" | sed -E 's#.*github.com[:/].*/([^/]+).*#\1#')

# Log the repository information
echo "Repository owner: $repo_owner"
echo "Repository name: $repo_name"

# Get the latest workflow run ID (using jq)
run_id=$(gh run list -L 1 --json databaseId -R "$repo_owner/$repo_name" | jq -r '.[0].databaseId')

# Log the run ID
echo "Latest workflow run ID: $run_id"

# Get the run conclusion (e.g., "success", "failure")
conclusion=$(gh run view $run_id --json conclusion -R "$repo_owner/$repo_name" | jq -r '.conclusion')

# Log the run conclusion
echo "Workflow run conclusion: $conclusion"

# Check if the run failed
if [[ "$conclusion" == "failure" ]]; then
  # Log the failure and view the failed logs
  echo "Workflow run failed. Viewing failed logs..."
  gh run view $run_id --log-failed -R "$repo_owner/$repo_name"
else
  echo "The latest workflow run was successful."
fi

# Log the end of the script
echo "Script finished."