#!/bin/bash
set -e

function abort() {
	echo -e "$@"
	exit 1
}

function cleanup() {
	echo "==> Stopping container..."
	docker stop $ID >/dev/null
	echo "==> Removing container..."
	docker rm $ID >/dev/null
	exit $TEST_RET
}

PWD=`pwd`

echo "==> Starting insecure container..."
ID=`docker run -d -v $PWD/test:/test $NAME:$VERSION /sbin/my_init --enable-insecure-key`
echo -e "\t==> $ID"
sleep 1

echo "==> Obtaining IP..."
IP=`docker inspect -f "{{ .NetworkSettings.IPAddress }}" "$ID"`
if [[ "$IP" = "" ]]; then
	abort "\t==> Unable to obtain container IP!"
fi
echo -e "\t==> $IP"

trap cleanup EXIT

echo "==> Enabling SSH in the container..."
(
	docker exec -t -i $ID /etc/my_init.d/00_regen_ssh_host_keys.sh -f
	docker exec -t -i $ID rm /etc/service/sshd/down
	docker exec -t -i $ID sv start /etc/service/sshd
) >/dev/null

sleep 1

echo -e "==> Logging into container and running tests...\n"

chmod 600 image/services/sshd/keys/insecure_key
sleep 1 # Give container some more time to start up.

# Request a pseudo TTY for nicer test output
ssh \
	-o UserKnownHostsFile=/dev/null \
	-o StrictHostKeyChecking=no \
	-o LogLevel=quiet \
	-i image/services/sshd/keys/insecure_key \
	root@$IP -t /bin/bash -l /test/test.sh

TEST_RET=$?

echo -e "\n"
