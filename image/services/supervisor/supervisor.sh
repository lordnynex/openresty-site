#!/bin/bash
set -e
source /build/buildconfig
set -x

SUPERVISOR_BUILD_PATH=/build/services/supervisor

## Install the supervisor
$minimal_apt_get_install supervisor python-setuptools python-pip

# Install supervisor-stdout
# pip install supervisor-stdout

## Configure supervisor
cp $SUPERVISOR_BUILD_PATH/supervisord.conf /etc/supervisor/supervisord.conf

mkdir -p /etc/service/supervisor
cp $SUPERVISOR_BUILD_PATH/supervisor.runit /etc/service/supervisor/run
