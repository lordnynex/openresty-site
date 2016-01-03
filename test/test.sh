#!/bin/bash
set -o pipefail

export TERM=xterm

bats ${CI:+--tap} /test/spec/
