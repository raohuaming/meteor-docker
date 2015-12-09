#!/bin/bash

# extracted from https://github.com/CyCoreSystems/docker-meteor/blob/master/entrypoint.sh
set -e
APP_DIR=/app

if [ ! -d ${APP_DIR}/bundle ]; then
  /bin/bash /build.sh
fi

APP_DIR=${APP_DIR}/bundle
# Run meteor
cd ${APP_DIR}
echo "Starting Meteor..."
forever start --uid image-transcription --append --minUptime 1000 --spinSleepTime 1000 main.js && forever logs -f 0
