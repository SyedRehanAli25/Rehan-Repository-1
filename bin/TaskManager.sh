#!/bin/bash

case "$1" in
  -a)
    ./bin/task_add.sh "$2"
    ;;
  -e)
    ./bin/task_exec.sh "$2"
    ;;
  -l)
    ./bin/task_list.sh
    ;;
  -h)
    ./bin/task_history.sh "$2"
    ;;
  -d)
    ./bin/task_delete.sh "$2"
    ;;
  *)
    echo "Usage: $0 -a <meta.json> | -e <task_name> | -l | -h <task_name> | -d <task_name>"
    ;;
esac

