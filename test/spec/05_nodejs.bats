#!/usr/bin/env bats

load /etc/buildconfig

@test "Checking Node.js installation..." {
  run node --help
  [ "$status" -eq 0 ]
}

@test "Checking installed Node.js version..." {
  run node -v
  [ "$status" -eq 0 ]
  [ ! -z "$NODEJS_VERSION" ]
  [ "$output" = "v${NODEJS_VERSION}" ]
}

@test "Checking npm installation..." {
  run npm config get
  [ "$status" -eq 0 ]
}
