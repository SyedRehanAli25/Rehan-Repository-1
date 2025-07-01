#!/bin/bash

SERVICE_DB=./services.db

mkdir -p "$(dirname "$SERVICE_DB")"
touch "$SERVICE_DB"

case "$1" in
  -o)
    op="$2"; shift 2
    case "$op" in
      register)
        while getopts "s:a:" opt; do 
          case $opt in
            s) script="$OPTARG" ;;
            a) alias="$OPTARG" ;;
          esac
        done
        echo "$alias:$script" >> "$SERVICE_DB"
        echo "Registered $alias"
        ;;
        start)
        while getopts "a:" opt; do alias="$OPTARG"; done
        entry=$(grep "^$alias:" "$SERVICE_DB")
        script=${entry#*:}

        if [ ! -f "$script" ]; then
            echo "[ERROR]: Script $script not found."
            exit 1
        fi

        nohup bash "$script" > /dev/null 2>&1 &
        echo $! > "./pids.$alias"
        echo "Started $alias"
        ;;

      status)
        while getopts "a:" opt; do alias="$OPTARG"; done
        [[ -f pids.$alias ]] && echo "$alias is running" || echo "$alias is stopped"
        ;;
      kill)
        while getopts "a:" opt; do alias="$OPTARG"; done
        [[ -f pids.$alias ]] && xargs kill < pids.$alias && rm pids.$alias
        echo "Killed $alias"
        ;;
      priority)
        while getopts "p:a:" opt; do 
          case $opt in
            p) pr="$OPTARG" ;;
            a) alias="$OPTARG" ;;
          esac
        done
        [[ "$pr" == "high" ]] && nice=-5
        [[ "$pr" == "med" ]] && nice=0
        [[ "$pr" == "low" ]] && nice=10
        [[ -f pids.$alias ]] && xargs renice "$nice" < pids.$alias
        ;;
      list)
        cut -d: -f1 "$SERVICE_DB"
        ;;
      top)
        if [[ -n "$4" ]]; then
          alias="$4"
          pidsFile="pids.$alias"
          [[ -f $pidsFile ]] && ps -p $(<"$pidsFile") -o pid,stat,ni,cmd
        else
          while read -r alias script; do
            pidsFile="pids.$alias"
            ps -p $(<"$pidsFile") -o pid,stat,ni,cmd
          done < "$SERVICE_DB"
        fi
        ;;
      *)
        echo "Unknown op"
        ;;
    esac
    ;;
  *)
    echo "Usage: ProcessManager.sh -o <register|start|status|kill|priority|list|top> ..."
    ;;
esac
