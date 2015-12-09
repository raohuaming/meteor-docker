#!/bin/bash

set -e
APP_DIR=/app

if [ -e /meteor_build_cache/meteor ]; then
  rm -rf ~/.meteor
  ln -s /meteor_build_cache ~/.meteor
fi

meteor --test

if [ ! -e /meteor_build_cache/meteor ]; then
  mv -f /root/.meteor/* /meteor_build_cache/
fi


