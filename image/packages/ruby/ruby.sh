#!/bin/bash
set -e
source /build/buildconfig
set -x

echo "==> Installing Ruby (${RUBY_VERSION})"
/bin/bash -l -c "rvm install ${RUBY_VERSION}"

echo "==> Configuring Ruby"
/bin/bash -l -c "rvm use --default ${RUBY_VERSION}"

## Instll Jekyll
if [ "$DISABLE_JEKYLL" -eq 0 ]; then
  echo "==> Installing Jekylrb..."
  /bin/bash -l -c "gem install jekyll -v ${JEKYLL_VERSION}"
fi
