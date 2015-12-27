#!/bin/bash
set -e
source /build/buildconfig
set -x

cd /root

echo "==> Importing rvm gpg keys..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3

echo "==> Downloading RVM..."
curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer

echo "==> Downloading RVM release signature..."
curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc

echo "==> Verifying RVM release signature..."
gpg --verify rvm-installer.asc

echo "==> Installing RVM..."
bash rvm-installer stable

echo "==> Configuring RVM..."
echo "gem: --no-ri --no-rdoc" | tee -a ~/.gemrc
echo "source /etc/profile.d/rvm.sh" | tee -a /etc/profile
rvm requirements

echo "==> Cleaning up RVM..."
rvm cleanup all
rm -rf rvm-installer rvm-installer.asc
