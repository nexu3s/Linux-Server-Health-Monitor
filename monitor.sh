#!/bin/bash

# ==============================================================================
# Script Name: Linux Server Health Monitor
# Description: Monitors CPU, RAM, Disk, and Services. Alerts via Telegram.
# Author: Nexus (t.me/nexu3s)
# ==============================================================================

# --- Configuration ---
TELEGRAM_BOT_TOKEN="YOUR_BOT_TOKEN_HERE"
TELEGRAM_CHAT_ID="YOUR_CHAT_ID_HERE"

# Thresholds (Percentage)
CPU_THRESHOLD=85
RAM_THRESHOLD=85
DISK_THRESHOLD=90

# Services to monitor
SERVICES=("nginx" "mysql")

# --- Functions ---

# Function to send message to Telegram
send_telegram_alert() {
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TELEGRAM_CHAT_ID}" \
        -d text="🚨 SERVER ALERT: ${message}" > /dev/null
}

# 1. Check CPU Usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
cpu_usage=${cpu_usage%.*} # Convert to integer
if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
    send_telegram_alert "High CPU Usage detected: ${cpu_usage}%"
fi

# 2. Check RAM Usage
ram_usage=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
if [ "$ram_usage" -gt "$RAM_THRESHOLD" ]; then
    send_telegram_alert "High RAM Usage detected: ${ram_usage}%"
fi

# 3. Check Disk Usage
disk_usage=$(df -h / | awk '/\//{print $(NF-1)}' | sed 's/%//')
if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
    send_telegram_alert "High Disk Usage detected: ${disk_usage}% on root partition"
fi

# 4. Check Critical Services
for service in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet "$service"; then
        send_telegram_alert "Service DOWN: ${service} is not running!"
        # Optional: Attempt to restart the service automatically
        # systemctl restart "$service"
    fi
done

echo "Health check completed successfully."
