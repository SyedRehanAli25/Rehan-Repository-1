#!/bin/bash
for meta in $(find "$(dirname "$0")/../tasks" -name meta.json); do
  jq -r .name "$meta"
done
