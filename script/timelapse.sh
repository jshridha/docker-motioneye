#!/bin/bash

# This script is the timer for stop Motion when time-lapse duration is reached

TIMESTAMP=$(cat $1)
INTERVAL=$2
DURATION=$3

while true; do
    _duration=$(($(date +"%s")-${TIMESTAMP}))
    [ "${_duration}" -gt "${DURATION}" ] && break
    sleep ${INTERVAL}
done

echo "Time-lapse recording completed, exit."

kill 1
