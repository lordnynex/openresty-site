FROM ubuntu:14.04
MAINTAINER Brandon Beveridge <lordnynex@gmail.com>

ADD . /build

RUN /build/prepare.sh \
 && /build/utilities.sh \
 && /build/system_services.sh \
 && /build/system_packages.sh \
 && /build/cleanup.sh

CMD ["/sbin/my_init"]

# RUN rm /bin/sh && ln -s /bin/bash /bin/sh && sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
#
# ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/openresty/bin:$PATH
# ENV DEBIAN_FRONTEND=noninteractive
# ENV OPENRESTY_VERSION 1.9.7.1
# ENV NODE_VERSION 5.3.0
# ENV RUBY_VERSION 2.1.1
# ENV OPENRESTY_PREFIX /usr/local/openresty
# ENV NGINX_PREFIX /opt/openresty/nginx
# ENV VAR_PREFIX /var/nginx
#
# RUN apt-get update \
#  && apt-get install -y --no-install-recommends \
#     curl perl make build-essential procps vim \
#     libreadline-dev libncurses5-dev libpcre3-dev libssl-dev \
#     openssh-server supervisor \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/dpkg/dpkg.cfg.d/02apt-speedup
#
# COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#
# RUN set -ex \
#  && mkdir -p /var/run/sshd /var/log/supervisor \
#  && cd /root \
#  && echo "==> Importing maintainer gpg keys..." \
#  && for key in \
#     9554F04D7259F04124DE6B476D5A82AC7E37093B \
#     94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
#     0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
#     FD3A5288F042B6850C66B31F09FE44734EB7990E \
#     71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
#     DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
#   ; do gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; done \
#  && gpg --keyserver pgpkeys.mit.edu --recv-key A0E98066 \
#  && gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 \
#  && echo "==> Downloading OpenResty..." \
#  && curl -sSL http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz | tar -xvz \
#  && echo "==> Downloading OpenResty release signature..." \
#  && curl -sSL https://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz.asc \
#  && echo "==> Verifying OpenResty release signature..." \
#  && gpg --verify ngx_openresty-${OPENRESTY_VERSION}.tar.gz.asc \
#  && echo "==> Configuring OpenResty..." \
#  && cd ngx_openresty-* \
#  && readonly NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
#  && echo "using upto $NPROC threads" \
#  && ./configure \
#     --http-client-body-temp-path=$VAR_PREFIX/client_body_temp \
#     --http-proxy-temp-path=$VAR_PREFIX/proxy_temp \
#     --http-log-path=$VAR_PREFIX/access.log \
#     --error-log-path=$VAR_PREFIX/error.log \
#     --pid-path=$VAR_PREFIX/nginx.pid \
#     --lock-path=$VAR_PREFIX/nginx.lock \
#     --with-luajit \
#     --with-pcre-jit \
#     --with-ipv6 \
#     --with-http_ssl_module \
#     -j${NPROC} \
#  && echo "==> Building OpenResty..." \
#  && make -j${NPROC} \
#  && echo "==> Installing OpenResty..." \
#  && make install \
#  && echo "==> Cleaning up OpenResty" \
#  && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* $OPENRESTY_PREFIX/luajit/bin/lua \
#  && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* /usr/local/bin/lua \
#  && rm -rf /root/ngx_openresty* \
#  && cd /root \
#  && echo "==> Downloading Node.js..." \
#  && curl -SLO "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" \
#  && echo "==> Downloading Node.js release signature..." \
#  && curl -SLO "https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt.asc" \
#  && echo "==> Verifying Node.js release signature..." \
#  && gpg --verify SHASUMS256.txt.asc \
#  && grep " node-v${NODE_VERSION}-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
#  && echo "==> Installing Node.js..." \
#  && tar -xzf "node-v${NODE_VERSION}-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
#  && echo "==> Cleaning up Node.js" \
#  && rm "node-v${NODE_VERSION}-linux-x64.tar.gz" SHASUMS256.txt.asc \
#  && cd /root \
#  && echo "==> Downloading RVM..." \
#  && curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer \
#  && echo "==> Downloading RVM release signature..." \
#  && curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc \
#  && echo "==> Verifying RVM release signature..." \
#  && gpg --verify rvm-installer.asc \
#  && echo "==> Installing RVM..." \
#  && bash rvm-installer stable \
#  && echo "==> Configuring RVM..." \
#  && echo "gem: --no-ri --no-rdoc" | tee -a ~/.gemrc
#  && echo "source /etc/profile.d/rvm.sh" | tee -a /etc/profile \
#  && rvm requirements \
#  && echo "==> Cleaning up RVM..." \
#  && rm -rf rvm-installer rvm-installer.asc \
#  && echo "==> Installing Ruby (${RUBY_VERSION})" \
#  && rvm install ${RUBY_VERSION} \
#  && rvm use --default ${RUBY_VERSION} \
#  && echo "==> Finishing..." \
#  && echo ""
#
# WORKDIR $NGINX_PREFIX/
#
# ONBUILD RUN rm -rf conf/* html/*
# ONBUILD COPY nginx $NGINX_PREFIX/

# CMD ["nginx", "-g", "daemon off; error_log /dev/stderr info;"]
