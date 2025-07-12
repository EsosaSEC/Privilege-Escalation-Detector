#!/bin/bash

# Privilege escalation detector
source ./config.sh

# Check if log file exists
if [ ! -f "$AUTH_LOG" ]; then
    echo "Error: Log file $AUTH_LOG not found"
    exit 1
fi

# Look for suspicious sudo or su activity
suspicious_activity=$(grep -E "sudo:.*COMMAND=|su:.*to root" "$AUTH_LOG" | \
    tail -n 50 | grep -v "cron" | grep -E "rm |passwd|useradd|usermod|groupadd|chmod|chown")

# Generate alerts
if [ -n "$suspicious_activity" ]; then
    while IFS= read -r line; do
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: Suspicious privilege escalation: $line" >> "$ALERTS_LOG"
    done <<< "$suspicious_activity"
fi
