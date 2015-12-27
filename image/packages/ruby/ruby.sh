#!/bin/bash
set -e
source /build/buildconfig
set -x

echo "==> Installing Ruby (${RUBY_VERSION})"
rvm install ${RUBY_VERSION}

echo "==> Configuring Ruby"
rvm use --default ${RUBY_VERSION}
