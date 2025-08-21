#!/bin/bash
# Specifies the shell interpreter to use for this script (bash).

# Privilege escalation detector
# Configuration

AUTH_LOG="/var/log/auth.log"  # Path to the authentication log file (update for testing, e.g., ./target_auth.log).
ALERTS_DIR="./alerts"  # Directory where alert logs will be stored.
ALERTS_LOG="$ALERTS_DIR/alerts.log"  # Full path to the alert log file.

# Create alerts directory

mkdir -p "$ALERTS_DIR"  # Creates the alerts directory if it doesn't exist, ensuring logs can be written.
chmod 755 "$ALERTS_DIR"  # Sets permissions to allow read/write/execute for owner and read/execute for others.

# Check if log file exists

if [ ! -f "$AUTH_LOG" ]; then  # Checks if the specified auth log file exists.
    echo "Error: Log file $AUTH_LOG not found" >> "$ALERTS_LOG"  # Logs an error to ALERTS_LOG if the file is missing.
    exit 1  # Exits the script with an error code if the log file is not found.
fi  # Ends the if condition for checking the log file.

# Look for suspicious sudo or su activity

suspicious_activity=$(grep -a -E "sudo:.*COMMAND=|su:.*to root" "$AUTH_LOG" | \
    tail -n 50 | grep -v "cron" | grep -E "rm |passwd|useradd|usermod|groupadd|chmod|chown")  # Searches for sudo or su commands in the last 50 lines of the auth log, excluding cron, and filters for suspicious commands.

# Generate alerts

if [ -n "$suspicious_activity" ]; then  # Checks if any suspicious activity was found.
    while IFS= read -r line; do  # Loops through each line of filtered suspicious activity.
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: Suspicious privilege escalation: $line" >> "$ALERTS_LOG"  # Logs an alert with the suspicious activity to ALERTS_LOG.
    done <<< "$suspicious_activity"  # Feeds the suspicious_activity variable into the while loop.
fi  # Ends the if condition for alert generation.
