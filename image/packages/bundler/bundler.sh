#!/bin/bash
set -e
source /build/buildconfig
set -x

cd /root

echo "==> Installing Bundler..."
gem install bundler
