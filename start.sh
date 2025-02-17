#!/usr/bin/env bash

if [[ -n ${GRACEFUL_START_WAIT_LIST} ]]; then
  dockerize -wait-list "${GRACEFUL_START_WAIT_LIST}" \
            -timeout 99999999s
fi


if [[ -n ${GRACEFUL_START_TASK} ]]; then
  ${GRACEFUL_START_TASK} "$@"
fi

exit 0