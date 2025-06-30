#!/bin/bash

num=$1

if ! [[ "$num" =~ ^[0-9]+$ ]]; then
  echo "Please enter a valid number."
  exit 1
fi

if ((num % 15 == 0)); then
  echo "tomcat"
elif ((num % 3 == 0)); then
  echo "tom"
elif ((num % 5 == 0)); then
  echo "cat"
else
  echo "$num"
fi
