#!/bin/bash

# Parse command-line options
debug=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--debug)
      debug=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

# Check if a repository is provided as an argument
if [[ $# -eq 2 ]]; then
  repo_owner=$1
  repo_name=$2
  if $debug; then echo "Repository owner: $repo_owner"; fi
  if $debug; then echo "Repository name: $repo_name"; fi
elif [[ <span class="math-inline">\# \-eq 0 \]\]; then
\# Get the repository owner and name from the origin remote
remote\_url\=</span>(git remote get-url origin)
  repo_owner=$(echo "<span class="math-inline">remote\_url" \| sed \-E 's\#\.\*github\.com\[\:/\]\(\[^/\]\+\)/\.\*\#\\1\#'\)
repo\_name\=</span>(echo "<span class="math-inline">remote\_url" \| sed \-E 's\#\.\*github\.com\[\:/\]\.\*/\(\[^/\]\+\)\.\*\#\\1\#' \| sed 's/\\\.git</span>//') # Remove .git
  # Log the repository information
  if $debug; then echo "Repository owner: $repo_owner"; fi
  if $debug; then echo "Repository name: $repo_name"; fi
else
  echo "Usage: <span class="math-inline">0 \[\-d\|\-\-debug\] \[owner\] \[repo\]"
echo "Or run in a git repository to use the origin remote\."
exit 1
fi
\# Check if gh and jq are installed
if \! command \-v gh &\> /dev/null; then
echo "Error\: gh command not found\. Please install the GitHub CLI\."
exit 1
fi
if \! command \-v jq &\> /dev/null; then
echo "Error\: jq command not found\. Please install jq\."
exit 1
fi
\# Get the latest workflow run ID \(using jq\) and redirect stderr to stdout
run\_id\=</span>(gh run list -L 1 --json databaseId -R "$repo_owner/$repo_name" 2>/dev/null | jq -r '.[0].databaseId')

# Check if the gh command failed or if no runs were found
if [[ -z "$run_id" ]]; then
  echo "No workflow runs found or failed to get run list."
  exit 1
fi

# Log the run ID
if $debug; then echo "Latest workflow run ID: <span class="math-inline">run\_id"; fi
\# Get the run conclusion \(e\.g\., "success", "failure"\) and redirect stderr to stdout
conclusion\=</span>(gh run view $run_id --json conclusion -R "$repo_owner/$repo_name" 2>/dev/null | jq -r '.conclusion')

# Check if the gh command failed
if [[ -z "$conclusion" ]]; then
  echo "Error: Failed to get workflow run details."
  exit 1
fi

# Log the run conclusion
if $debug; then echo "Workflow run conclusion: $conclusion"; fi

# Check if the run failed
if [[ "$conclusion" == "failure" ]]; then
  # Construct and print the command
  command_to_run="gh run view \"$run_id\" --log-failed -R \"$repo_owner/$repo_name\""
  if $debug; then echo "Executing: <span class="math-inline">command\_to\_run"; fi
\# Capture the output of gh run view
failed\_logs\=</span>(eval "$command_to_run") # Use eval to execute the command

  # Print the captured logs
  echo "$failed_logs"

  if $debug; then echo "Failure status: $conclusion"; fi
  if $debug; then echo "Run ID: $run_id"; fi
else
  success_message="The latest workflow run was successful."
  if $debug; then echo "$success_message"; fi
  if $debug; then echo "Success status: $conclusion"; fi
  if $debug; then echo "