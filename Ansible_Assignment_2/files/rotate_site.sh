#!/bin/bash
SITES=("Rehan" "Harsh" "Prakash")
COUNTER_FILE="/tmp/site_counter"
[[ -f $COUNTER_FILE ]] || echo 0 > $COUNTER_FILE
COUNT=$(cat $COUNTER_FILE)
NEXT=$(( (COUNT + 1) % ${#SITES[@]} ))
echo $NEXT > $COUNTER_FILE
ln -sfn /var/www/${SITES[$NEXT]} /var/www/html
systemctl reload nginx
