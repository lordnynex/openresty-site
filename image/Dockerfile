FROM ubuntu:14.04
MAINTAINER Brandon Beveridge <lordnynex@gmail.com>

# Hopefully fix stdin: is not a tty
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/openresty/bin:$PATH

ADD . /build

RUN /build/prepare.sh \
 && /build/utilities.sh \
 && /build/system_services.sh \
 && /build/system_packages.sh \
 && /build/cleanup.sh

CMD ["/sbin/my_init"]
