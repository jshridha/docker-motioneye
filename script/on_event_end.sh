#!/bin/bash

SUBJECT="[ALARM] Motion detected at $(date)"
BODY="This is the alarm body."
ATTACHMENT="*.avi"

echo "${BODY}" | \
    mutt ${MAILTO} \
    -s "${SUBJECT}" \
    -a ${ATTACHMENT} && \
echo "Mail has been sent!"
