#!/bin/bash
set -e
source /build/buildconfig
set -x

cd /root

$minimal_apt_get_install perl make build-essential libreadline-dev libncurses5-dev libpcre3-dev libssl-dev

echo "==> Importing OpenResty gpg signing keys..."
gpg --keyserver pgpkeys.mit.edu --recv-key A0E98066

echo "==> Downloading OpenResty..."
curl -SLO http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz

echo "==> Downloading OpenResty release signature..."
curl -SLO https://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz.asc

echo "==> Verifying OpenResty release signature..."
gpg --verify ngx_openresty-${OPENRESTY_VERSION}.tar.gz.asc

tar -zxvf ngx_openresty-${OPENRESTY_VERSION}.tar.gz

echo "==> Configuring OpenResty..."
cd ngx_openresty-*
readonly NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)
echo "using upto $NPROC threads"
./configure \
  --sbin-path=/usr/sbin/nginx \
  --pid-path=/var/run/nginx.pid \
  --lock-path=/var/lock/nginx.lock \
  --conf-path=/etc/nginx/nginx.conf \
  --http-client-body-temp-path=$VAR_PREFIX/client_body_temp \
  --http-proxy-temp-path=$VAR_PREFIX/proxy_temp \
  --http-log-path=$VAR_PREFIX/access.log \
  --error-log-path=$VAR_PREFIX/error.log \
  --pid-path=$VAR_PREFIX/nginx.pid \
  --lock-path=$VAR_PREFIX/nginx.lock \
  --with-luajit \
  --with-pcre-jit \
  --with-ipv6 \
  --with-http_ssl_module \
  -j${NPROC}

echo "==> Building OpenResty..."
make -j${NPROC}

echo "==> Installing OpenResty..."
make install

echo "==> Cleaning up OpenResty"
ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* $OPENRESTY_PREFIX/luajit/bin/lua
ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* /usr/local/bin/lua
rm -rf /root/ngx_openresty*
apt-get purge -y g++-4.8
