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
SLEEP_INTERVAL=30

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
	
    # Check if the Minecraft server is already running
    if pgrep -f "$SERVER_JAR" >/dev/null; then
	
      # Restart the Minecraft server
      screen -S minecraft -p 0 -X stuff "stop^M"  # Send "stop" command to the running server
      sleep 10  # Allow time for the server to shut down gracefully
	fi
  else
    echo "No changes to pull."
  fi

  # Sleep for the specified interval before the next check
  sleep "$SLEEP_INTERVAL"
done
