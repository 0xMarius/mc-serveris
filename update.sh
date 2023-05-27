#!/bin/bash

# Define the GitHub repository details
REPO_OWNER="0xMarius"
REPO_NAME="mc-serveris"
BRANCH="main"

# Define the local directory path for the repository
LOCAL_DIR="/root/mc-serveris"

# Define the name of the Minecraft server JAR file
SERVER_JAR="purpur1976.jar"

# Define the sleep interval between each check (in seconds)
SLEEP_INTERVAL=10

# Change directory to the local repository
cd "$LOCAL_DIR"

while true; do
  # Check if the repository exists, and if not, clone it
  if [ ! -d "$LOCAL_DIR" ]; then
    git clone "https://github.com/$REPO_OWNER/$REPO_NAME.git" "$LOCAL_DIR"
  fi

  # Fetch the latest changes from the remote repository
  git fetch origin "$BRANCH"

  # Check if there are any changes to be pulled
  LOCAL_HEAD=$(git rev-parse HEAD)
  REMOTE_HEAD=$(git rev-parse "origin/$BRANCH")

  if [ "$LOCAL_HEAD" != "$REMOTE_HEAD" ]; then
    # Pull changes from the remote repository
    git pull origin "$BRANCH"

  else
    echo "No changes to pull."
  fi

  # Sleep for the specified interval before the next check
  sleep "$SLEEP_INTERVAL"
done
