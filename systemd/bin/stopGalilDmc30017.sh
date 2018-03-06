#!/usr/bin/env bash

set -u

if [ -z "$DMC30017_INSTANCE" ]; then
    echo "DMC30017_INSTANCE environment variable is not set." >&2
    exit 1
fi

/usr/bin/docker stop \
    galil-dmc30017-epics-ioc-${DMC30017_INSTANCE}
