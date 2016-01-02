#!/usr/bin/env bats

source /etc/buildconfig

##########
# runit
##########
@test "Checking that all services are running..." {
  run sv status /etc/service/*

  [ "$status" -eq 0 ]
  [ `echo "$output" | grep down |wc -l` -eq 0 ]
}

#############
# supervisor
#############
@test "Checking supervisor..." {
  run supervisorctl status
  [ "$status" -eq 0 ]
}
