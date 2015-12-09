#!/bin/bash

set -e
SRC_DIR=/src
BUILD_DIR=/dest

echo "Building the app..."
cd ${SRC_DIR}
meteor build --directory ${BUILD_DIR}
# Install NPM modules
echo "Install NPM modules"
BUILD_DIR=${BUILD_DIR}/bundle
cd ${BUILD_DIR}/programs/server && cnpm install
# uninstall meteor
rm -rf ~/.meteor
rm /usr/local/bin/meteor
