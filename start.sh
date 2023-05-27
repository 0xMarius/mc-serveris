# Path to Minecraft server directory
SERVER_DIR="/root/mc-serveris"

# Path to Minecraft server JAR file
SERVER_JAR="$SERVER_DIR/purpur1976.jar"

# Define the Minecraft server screen session name
SESSION_NAME="minecraft-server"

# Check if the Minecraft server is already running
if screen -ls | grep -q "$SESSION_NAME"; then
    echo "Minecraft server is already running. Restarting..."
    screen -r "$SESSION_NAME" -p 0 -X stuff "/stop$(printf '\r')"

    sleep 10  # Wait for the server to stop gracefully
fi

echo "Starting Minecraft server..."
screen -dmS "$SESSION_NAME"
cd "$SERVER_DIR" 
/usr/bin/java -Xms4G -Xmx4G -jar "$SERVER_JAR" --nogui
