#!/bin/bash

# Script: server_stats.sh
# Description: Collects and displays basic server performance statistics

echo "=========================================="
echo "     SERVER PERFORMANCE STATS"
echo "=========================================="

# Uptime
echo -e "\n🕒 UPTIME:"
uptime

# CPU Load
echo -e "\n🧠 CPU LOAD (1, 5, 15 min averages):"
cat /proc/loadavg | awk '{print "1min: "$1", 5min: "$2", 15min: "$3}'

# Memory Usage
echo -e "\n🧮 MEMORY USAGE:"
free -h

# Disk Usage
echo -e "\n💾 DISK USAGE:"
df -h | grep -E "^/dev"

# Top 5 processes by memory usage
echo -e "\n📈 TOP 5 PROCESSES BY MEMORY USAGE:"
ps aux --sort=-%mem | head -n 6

# Network I/O
echo -e "\n🌐 NETWORK INTERFACES (I/O):"
ip -brief address
echo -e "\nNetwork Stats:"
if command -v ifstat &> /dev/null; then
    ifstat 1 1
else
    echo "ifstat not installed. Install it with: sudo apt install ifstat"
fi

# CPU Info
echo -e "\n🔧 CPU INFO:"
lscpu | grep 'Model name\|CPU(s):\|Thread'

# Disk I/O Stats
echo -e "\n📊 DISK I/O STATS:"
iostat -dx 1 1 | head -n 20 2>/dev/null || echo "iostat not available. Install with: sudo apt install sysstat"

# End
echo -e "\n✅ Done."

