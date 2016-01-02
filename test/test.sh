#!/bin/bash
set -o pipefail

export TERM=xterm

bats /test/spec/
