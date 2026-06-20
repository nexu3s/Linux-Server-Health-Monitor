> 🇮🇷 **[برای مطالعه مستندات به زبان فارسی کلیک کنید](README-fa.md)**

# 🖥️ Linux Server Health Monitor

A lightweight and efficient Bash script designed for System Administrators and DevOps engineers to monitor essential Linux server metrics. It checks CPU, Memory, Disk usage, and critical services, automatically sending an alert to a Telegram bot if thresholds are exceeded.

### 🚀 Features
- **CPU & RAM Monitoring:** Alerts when usage goes above the defined threshold (e.g., 85%).
- **Disk Space Monitoring:** Prevents out-of-space issues by alerting before the disk is 100% full.
- **Service Monitoring:** Checks if critical services like `Nginx`, `Apache`, or `MySQL` are running.
- **Telegram Integration:** Instant push notifications to your phone/desktop via Telegram API.

### 🛠️ Prerequisites
- A Linux-based OS (Ubuntu, CentOS, Debian, etc.)
- `curl` installed (`sudo apt install curl`)
- A Telegram Bot Token (Create one via @BotFather)

### ⚙️ How to Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/[یوزرنیم-شما]/Linux-Server-Health-Monitor.git
   cd Linux-Server-Health-Monitor
