#!/bin/bash
set -e
source /build/buildconfig
set -x

cd /root

echo "==> Installing Bundler..."
/bin/bash -l -c "gem install bundler"
