#!/usr/bin/env bash

export GRACEFUL_HOME=${GRACEFUL_HOME:-'/app'}

if [[ -f /app/build-env ]]; then
  cat /app/build-env
fi
if [[ -f /app/build-time ]]; then
  cat /app/build-time
fi

function graceful() {
  echo Doing graceful shutdown ...
  "${GRACEFUL_HOME}/${GRACEFUL_STOP_SCRIPT}"
  echo Done graceful shutdown!
  exit 0
}
echo 'Registering trap'
trap 'graceful' SIGTERM
trap -p SIGTERM

GRACEFUL_START_SCRIPT=${GRACEFUL_START_SCRIPT:-'start.sh'}
GRACEFUL_STOP_SCRIPT=${GRACEFUL_STOP_SCRIPT:-'stop.sh'}

"${GRACEFUL_HOME}/${GRACEFUL_START_SCRIPT}" &

ping localhost > /dev/null 2>&1 &
wait