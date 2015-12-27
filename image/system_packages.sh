#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install OpenResty
[ "$DISABLE_OPENRESTY" -eq 0 ] && /build/services/openresty/openresty.sh || true
