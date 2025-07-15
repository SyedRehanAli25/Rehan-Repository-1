#!/bin/bash
# bin/task_history.sh

task_name="$1"
echo "Execution history for: $task_name"
echo "-------------------------------"

for log in tasks/execution_history/${task_name}_*.log; do
  echo -e "\n== $(basename "$log") =="
  grep -E "Start|End|Duration|Status" "$log"
done
