#!/bin/bash
set -e
source /build/buildconfig
set -x

## Install OpenResty
[ "$DISABLE_OPENRESTY" -eq 0 ] && /build/packages/openresty/openresty.sh || true

## Install Node.js
[ "$DISABLE_NODEJS" -eq 0 ] && /build/packages/nodejs/nodejs.sh || true

## Install rvm
[ "$DISABLE_RVM" -eq 0 ] && /build/packages/rvm/rvm.sh || true

## Install ruby
[ "$DISABLE_RUBY" -eq 0 ] && /build/packages/ruby/ruby.sh || true
