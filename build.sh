#!/bin/bash

set +e # Allow the next command to fail
APP_DIR=/app

echo "Building the app..."
cd /src
ln -s /meteor_build_cache /src/.meteor/local
meteor build --directory ${APP_DIR}

if [ $? -ne 0  ]; then
  echo "Building the bundle (old version)..."
  set -e
  # Old versions used 'bundle' and didn't support the --directory option
  meteor bundle bundle.tar.gz
  tar xf bundle.tar.gz -C ${APP_DIR}
fi

set -e
# Install NPM modules
APP_DIR=${APP_DIR}/bundle
echo "Installing NPM prerequisites..."
ln -s /node_modules_cache ${APP_DIR}/programs/server/node_modules
pushd ${APP_DIR}/programs/server/
npm install
popd
