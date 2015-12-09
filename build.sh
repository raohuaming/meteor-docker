#!/bin/bash

set -e
APP_DIR=/app

echo "Building the app..."
cd /src

if [ -e /meteor_build_cache/meteor ]; then
  rm -rf /root/.meteor
  ln -s /meteor_build_cache /root/.meteor /root/.meteor
fi

set +e # Allow the next command to fail
meteor build --directory ${APP_DIR}
if [ $? -ne 0  ]; then
  echo "Building the bundle (old version)..."
  set -e
  # Old versions used 'bundle' and didn't support the --directory option
  meteor bundle bundle.tar.gz
  tar xf bundle.tar.gz -C ${APP_DIR}
fi
set -e
if [ ! -e /meteor_build_cache/meteor ]; then
  mv -f /root/.meteor/* /meteor_build_cache/
fi
# Install NPM modules
echo "Install NPM modules"
APP_DIR=${APP_DIR}/bundle
#if [ -d ${APP_DIR}/programs/server/node_modules ]; then
  #rm -rf ${APP_DIR}/programs/server/node_modules
#fi
#ln -s /node_modules_cache ${APP_DIR}/programs/server/node_modules
cd ${APP_DIR}/programs/server && cnpm install
#rm ${APP_DIR}/programs/server/node_modules
#mkdir ${APP_DIR}/programs/server/node_modules
#cp -r /node_modules_cache/* ${APP_DIR}/programs/server/node_modules/
