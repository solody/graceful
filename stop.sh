#!/usr/bin/env bash

if [[ -z ${GRACEFUL_STOP_TASK} ]]; then
  "${GRACEFUL_STOP_TASK}"
fi

exit 0