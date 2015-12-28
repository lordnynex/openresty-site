#!/bin/bash
set -e
source /build/buildconfig
set -x

cd /root
echo "==> Downloading BATS..."
curl -sSL https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz | tar -xz

echo "==> Installing BATS..."
cd bats-0.4.0/
bash -l -c "./install.sh /usr/local"
cd ..

echo "==> Cleaning BATS..."
rm -rf bats-0.4.0/
