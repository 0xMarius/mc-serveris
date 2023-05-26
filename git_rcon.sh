#!/bin/bash

# Define the path to your Git repository
REPO_PATH="/path/to/your/git/repo"

# Define your RCON server details
RCON_HOST="localhost"
RCON_PORT="27015"
RCON_PASSWORD="your_rcon_password"

# Change directory to the repository path
cd "$REPO_PATH"

# Run git status to check for changes
GIT_STATUS=$(git status --porcelain)

# If changes are detected, execute the desired RCON command
if [[ -n "$GIT_STATUS" ]]; then
    # Replace the following command with your RCON command
    RCON_COMMAND="git pull"

    # Execute the RCON command
    echo "$RCON_COMMAND" | rcon --host <RCON_HOST> --port <RCON_PORT> --password <RCON_PASSWORD>
fi
