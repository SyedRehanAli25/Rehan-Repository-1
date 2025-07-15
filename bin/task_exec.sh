#!/bin/bash

task_name="$1"
base_dir="$(dirname "$0")/.."
task_dir="$base_dir/tasks/$task_name"
meta_file="$task_dir/meta.json"
source "$base_dir/lib/utils.sh"

# Check if task exists
if [ ! -f "$meta_file" ]; then
  echo " Task '$task_name' not found!"
  exit 1
fi

# Load metadata
script_path=$(jq -r '.script_path' "$meta_file")
email=$(jq -r '.notification_email' "$meta_file")

# Check script path
if [ ! -x "$script_path" ]; then
  echo " Task script '$script_path' not found or not executable!"
  exit 1
fi

# Generate execution ID and log file
exec_id=$(date +%s)
log_file="$task_dir/logs/$exec_id.log"
history_file="$task_dir/history.log"

# Start execution
start_time=$(date '+%Y-%m-%d %H:%M:%S')
echo " Running task '$task_name'..."
echo "Execution started at $start_time" > "$log_file"
start_ts=$(date +%s)

# Execute task
bash "$script_path" >> "$log_file" 2>&1
status=$?

end_time=$(date '+%Y-%m-%d %H:%M:%S')
end_ts=$(date +%s)
duration=$((end_ts - start_ts))

# Status message
if [ "$status" -eq 0 ]; then
  echo " Task succeeded" >> "$log_file"
  status_str="Success"
else
  echo " Task failed" >> "$log_file"
  status_str="Failure"
fi

# Save history
echo "$exec_id | $start_time | $end_time | ${duration}s | $status_str" >> "$history_file"

# Send email
"$base_dir/lib/utils.sh"
send_email "$email" "Task '$task_name' Execution - $status_str" "Execution ID: $exec_id
Start: $start_time
End: $end_time
Duration: ${duration}s
Status: $status_str"

echo " Notification sent to $email"

