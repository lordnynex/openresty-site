#!/usr/bin/env bats

load /etc/buildconfig

@test "Checking Ruby installation..." {
  run ruby --version
  [ "$status" -eq 0 ]
  [ ! -z "$RUBY_VERSION" ]
  [ `echo "$output" |grep "ruby ${RUBY_VERSION}" |wc -l` -eq 1 ]
}
