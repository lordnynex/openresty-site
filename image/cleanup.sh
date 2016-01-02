#!/bin/bash
set -e
source /build/buildconfig
set -x

PRE_USAGE=$(du -hcs / 2>&- |tail -n1 | awk '{print $1}')

echo "==> Cleaning up the system to reduce image size ($PRE_USAGE)..."

echo "==> Cleaning RVM repos..."
# /bin/bash -l -c "rvm cleanup all"
rvm cleanup all

echo "==> Cleaning NPM cache"
npm cache clean

echo "==> Purging unneeded packages..."
# Unfortunately ruby gems needs a compiler. I need to write a wrapper around the gem install to cleanup. For now, take these parts out

# apt-get purge -y \
#   gcc gcc-4.8 libtool libstdc++-4.8-dev g++-4.8 \
#   libpcre3-dev cpp cpp-4.8 libasan0 libatomic1 \
#   libcloog-isl4 libgcc-4.8-dev libgmp10 libgomp1 \
#   libitm1 libpcrecpp0 libquadmath0 libtsan0 \
#   iso-codes python3-software-properties software-properties-common \
#   gir1.2-glib-2.0 python3-gi libdbus-glib-1-2 python3-dbus  libgirepository-1.0-1 python3-pycurl unattended-upgrades \
#   libc6-dev libgdbm-dev libncurses5-dev libsqlite3-dev libssl-dev zlib1g-dev \
#   gawk libc-dev-bin linux-libc-dev python-apt-common python3-apt \
#   autoconf automake autotools-dev dpkg-dev libarchive-extract-perl liblog-message-simple-perl libterm-ui-perl \
#   libdpkg-perl libtimedate-perl patch

# RVM installs gawk, libyaml-dev, libsqlite3-dev, sqlite3, autoconf, libgdbm-dev, automake, libtool, bison, pkg-config, libffi-dev

# Openresty installs
# The following extra packages will be installed:
#   binutils cpp cpp-4.8 dpkg-dev g++ g++-4.8 gcc gcc-4.8 libasan0 libatomic1
#   libc-dev-bin libc6-dev libcloog-isl4 libdpkg-perl libgcc-4.8-dev libgmp10
#   libgomp1 libisl10 libitm1 libmpc3 libmpfr4 libpcrecpp0 libquadmath0
#   libreadline6-dev libstdc++-4.8-dev libtimedate-perl libtinfo-dev libtsan0
#   linux-libc-dev patch zlib1g-dev
# Suggested packages:
#   binutils-doc cpp-doc gcc-4.8-locales debian-keyring g++-multilib
#   g++-4.8-multilib gcc-4.8-doc libstdc++6-4.8-dbg gcc-multilib manpages-dev
#   autoconf automake1.9 libtool flex bison gdb gcc-doc gcc-4.8-multilib
#   libgcc1-dbg libgomp1-dbg libitm1-dbg libatomic1-dbg libasan0-dbg
#   libtsan0-dbg libquadmath0-dbg glibc-doc ncurses-doc libstdc++-4.8-doc
#   make-doc ed diffutils-doc
# Recommended packages:
#   fakeroot libalgorithm-merge-perl libfile-fcntllock-perl libssl-doc
# The following NEW packages will be installed:
#   binutils build-essential cpp cpp-4.8 dpkg-dev g++ g++-4.8 gcc gcc-4.8
#   libasan0 libatomic1 libc-dev-bin libc6-dev libcloog-isl4 libdpkg-perl
#   libgcc-4.8-dev libgmp10 libgomp1 libisl10 libitm1 libmpc3 libmpfr4
#   libncurses5-dev libpcre3-dev libpcrecpp0 libquadmath0 libreadline-dev
#   libreadline6-dev libssl-dev libstdc++-4.8-dev libtimedate-perl libtinfo-dev
#   libtsan0 linux-libc-dev make patch zlib1g-dev

# shell-init: error retrieving current directory: getcwd: cannot access parent directories: No such file or directory

echo "==> Cleaning apt cache..."
apt-get clean
rm -rf /build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

rm -f /etc/ssh/ssh_host_*

echo "==> Package sizes..."
dpkg-query --show --showformat='${Package;-30}\t${Installed-Size}\n' | sort -k 2 -n

POST_USAGE=$(du -hsh / 2>&- | awk '{print $1}')
echo "==> Finished Cleanup"
echo -e "\t Before: ${PRE_USAGE}"
echo -e "\t  After: ${POST_USAGE}"
