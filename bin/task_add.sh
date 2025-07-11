#!/bin/bash

meta_file="$1"

# Validate file
if [ ! -f "$meta_file" ]; then
  echo " Metadata file not found!"
  exit 1
fi

# Extract fields
task_name=$(jq -r '.task_name' "$meta_file")
script_path=$(jq -r '.script_path' "$meta_file")

# Check if values are not null
if [[ "$task_name" == "null" || "$script_path" == "null" ]]; then
  echo " Invalid metadata. Please check required fields (task_name, script_path)."
  exit 1
fi

# Copy metadata to global meta/ dir
cp "$meta_file" "meta/${task_name}.json"

# Create per-task directory in tasks/
task_dir="tasks/$task_name"
mkdir -p "$task_dir/logs"
cp "$meta_file" "$task_dir/meta.json"
touch "$task_dir/history.log"

echo " Task '$task_name' added successfully."

