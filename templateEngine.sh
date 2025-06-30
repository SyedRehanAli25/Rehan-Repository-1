#!/bin/bash

template_file=$1
shift

if [ ! -f "$template_file" ]; then
  echo "Template file not found!"
  exit 1
fi

content=$(<"$template_file")

for arg in "$@"; do
  key=${arg%%=*}
  value=${arg#*=}
  content=${content//\{\{$key\}\}/$value}
done

echo "$content"
