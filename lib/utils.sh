#!/bin/bash

send_email() {
  local to="$1"
  local subject="$2"
  local body="$3"
  echo -e "$body" | mail -s "$subject" "$to"
}
