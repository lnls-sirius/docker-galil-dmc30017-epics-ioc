#!/usr/bin/env bash

set -u

if [ -z "$DMC30017_INSTANCE" ]; then
    echo "DMC30017_INSTANCE environment variable is not set." >&2
    exit 1
fi

export DMC30017_CURRENT_PV_AREA_PREFIX=DMC30017_${DMC30017_INSTANCE}_PV_AREA_PREFIX
export DMC30017_CURRENT_PV_DEVICE_PREFIX=DMC30017_${DMC30017_INSTANCE}_PV_DEVICE_PREFIX
export DMC30017_CURRENT_DEVICE_IP=DMC30017_${DMC30017_INSTANCE}_DEVICE_IP
export DMC30017_CURRENT_DEVICE_PORT=DMC30017_${DMC30017_INSTANCE}_DEVICE_PORT
# Only works with bash
export DMC30017_PV_AREA_PREFIX=${!DMC30017_CURRENT_PV_AREA_PREFIX}
export DMC30017_PV_DEVICE_PREFIX=${!DMC30017_CURRENT_PV_DEVICE_PREFIX}
export DMC30017_DEVICE_IP=${!DMC30017_CURRENT_DEVICE_IP}
export DMC30017_DEVICE_PORT=${!DMC30017_CURRENT_DEVICE_PORT}

# Create volume for autosave and ignore errors
/usr/bin/docker create \
    -v /opt/epics/startup/ioc/galil-dmc30017-epics-ioc/iocBoot/iocGalilDmc30017/autosave \
    --name galil-dmc30017-epics-ioc-${DMC30017_INSTANCE}-volume \
    lnlsdig/galil-dmc30017-epics-ioc:${IMAGE_VERSION} \
    2>/dev/null || true

# Remove a possible old and stopped container with
# the same name
/usr/bin/docker rm \
    galil-dmc30017-epics-ioc-${DMC30017_INSTANCE} || true

/usr/bin/docker run \
    --net host \
    -t \
    --rm \
    --volumes-from galil-dmc30017-epics-ioc-${DMC30017_INSTANCE}-volume \
    --name galil-dmc30017-epics-ioc-${DMC30017_INSTANCE} \
    lnlsdig/galil-dmc30017-epics-ioc:${IMAGE_VERSION} \
    -i "${DMC30017_DEVICE_IP}" \
    -p "${DMC30017_DEVICE_PORT}" \
    -P "${DMC30017_PV_AREA_PREFIX}" \
    -R "${DMC30017_PV_DEVICE_PREFIX}" \
