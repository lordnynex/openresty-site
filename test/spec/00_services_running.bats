#!/usr/bin/env bats

source /etc/buildconfig

@test "Checking that all services are running..." {
  run sv status /etc/service/*

  [ "$status" -eq 0 ]
  [ `echo "$output" | grep down |wc -l` -eq 0 ]
}
