#!/bin/bash
set -e
source /build/buildconfig
set -x

echo "==> Installing Ruby (${RUBY_VERSION})"
/bin/bash -l -c "rvm install ${RUBY_VERSION}"

echo "==> Configuring Ruby"
/bin/bash -l -c "rvm use --default ${RUBY_VERSION}"
