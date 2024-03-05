#!/bin/bash

dockerize -wait-list "$GRACEFUL_HEALTH_CHECK_WAIT_LIST" \
          -timeout 5s

if [[ "$?" == "0" ]]; then
  exit 0
else
  exit 1
fi

