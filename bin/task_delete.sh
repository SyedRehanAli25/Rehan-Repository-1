#!/bin/bash
name="$1"
rm -rf "$(dirname "$0")/../tasks/$name"
crontab -l | grep -v "$name" | crontab -
rm -f "$(dirname "$0")/../cron/$name.cron"
echo "Deleted task $name"
