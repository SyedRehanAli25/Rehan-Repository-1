#!/bin/bash

case "$1" in
  topProcess)
    n="$2"; metric="$3"
    if [[ "$metric" == "memory" ]]; then
      ps aux --sort=-%mem | head -n $((n + 1))
    else
      ps aux --sort=-%cpu | head -n $((n + 1))
    fi
    ;;

  killLeastPriorityProcess)
    pid=$(ps -eo pid,ni --sort=ni | head -n 2 | tail -n 1 | awk '{print $1}')
    kill "$pid" && echo "Killed PID $pid"
    ;;

  RunningDurationProcess)
    target="$2"
    if [[ "$target" =~ ^[0-9]+$ ]]; then
      ps -p "$target" -o etime=
    else
      ps -C "$target" -o pid,etime=
    fi
    ;;

  listOrphanProcess)
    ps -eo pid,ppid,stat,cmd | awk '$2==1 {print}'
    ;;

  listZoombieProcess)
    ps -eo pid,stat,cmd | awk '$2 ~ /Z/ {print}'
    ;;

  killProcess)
    target="$2"
    if [[ "$target" =~ ^[0-9]+$ ]]; then
      kill "$target"
    else
      pkill -f "$target"
    fi
    echo "Killed $target"
    ;;

  ListWaitingProcess)
    ps -eo pid,stat,cmd | awk '$2 ~ /D/ {print}'
    ;;

  *)
    echo "Usage: otProcessManager.sh <command> [args]"
    ;;
esac
