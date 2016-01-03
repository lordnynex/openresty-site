#!/usr/bin/env bats

load /etc/buildconfig

##########
# Node.js
##########
@test "Checking Node.js installation..." {
  run node --help
  [ "$status" -eq 0 ]
}

@test "Check installed Node.js version..." {
  run node -v
  [ "$status" -eq 0 ]
  [ ! -z "$NODEJS_VERSION" ]
  [ "$output" = "v${NODEJS_VERSION}" ]
}

@test "Check npm installation..." {
  run npm config get
  [ "$status" -eq 0 ]
}

@test "Check that Bower was installed..." {
  run bower
  [ "$status" -eq 0 ]
}

@test "Check that NPM cache is empty..." {
  skip
  # result=$("npm cache ls")
  run "npm cache ls"
  echo "$output"
  [ "$status" -eq 0 ]
  [ "$result" -eq 1 ]
}

##########
# Ruby
##########
@test "Checking Ruby installation..." {
  run ruby --version
  [ "$status" -eq 0 ]
  [ ! -z "$RUBY_VERSION" ]
  [ `echo "$output" |grep "ruby ${RUBY_VERSION}" |wc -l` -eq 1 ]
}

##########
# Bundler
##########
@test "Checking Bundler installation..." {
  run bundle --version
  [ "$status" -eq 0 ]
}

##########
# Jekyll
##########
@test "Checking Jekyll installation..." {
  skip
  run jekyll --version

  [ "$status" -eq 0 ]
  [ "$output" = "jekyll ${JEKYLL_VERSION}" ]
}

#########
# Openresty
#########
@test "Check openresty installation..." {
  run /sbin/nginx -V

  [ "$status" -eq 0 ]
}
