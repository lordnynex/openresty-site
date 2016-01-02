#!/bin/bash
set -o pipefail

export TERM=xterm

bats --pretty /test/spec/
