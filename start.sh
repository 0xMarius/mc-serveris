#!/bin/bash

# Path to Minecraft server directory
SERVER_DIR="/root/mc-serveris"

# Path to Minecraft server JAR file
SERVER_JAR="$SERVER_DIR/purpur1976.jar"

# Minecraft server is running, restart it
lsof -ti :25565 | xargs kill
sleep 10
cd "$SERVER_DIR" && /usr/bin/java -Xms4G -Xmx4G -jar "$SERVER_JAR" --nogui
