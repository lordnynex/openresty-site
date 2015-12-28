#!/usr/bin/env bats

load /etc/buildconfig

@test "Checking Bundler installation..." {
  run bundle --version
  [ "$status" -eq 0 ]
}
