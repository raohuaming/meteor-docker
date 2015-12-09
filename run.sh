#!/bin/bash

# extracted from https://github.com/CyCoreSystems/docker-meteor/blob/master/entrypoint.sh
set -e
BUILD_DIR=/tmp

if [ ! -d ${BUILD_DIR}/bundle ]; then
  /bin/bash /build.sh
fi

BUILD_DIR=${BUILD_DIR}/bundle
# Run meteor
cd ${BUILD_DIR}
echo "Starting Meteor..."
forever start --uid image-transcription --append --minUptime 1000 --spinSleepTime 1000 main.js && sleep 3; forever logs -f 0
