#!/bin/bash

# this assumes ""${NAME}"" is disposable!
# runs ${IMAGE} with external file systems mounted in.

export IMAGE="bootstrappers"
export NAME="bootstrappers"
export BASE="/data/docker/bootstrappers"


if [ "X$1" != "Xyes" ]; then
	echo
	echo "--------------------------------------------------------------------"
	echo "This script destroys existing container with name \"${NAME}\" and"
	echo "starts a new instance based on ${IMAGE}."
	echo
	echo "Run as '$0 yes' if this is what you intend to do."
	echo "--------------------------------------------------------------------"
	echo
	exit 0
fi

docker stop "${NAME}"
docker rm "${NAME}"
docker run \
	--hostname bootstrappers \
	--name bootstrappers \
	-d --restart=always \
	-P -p 127.0.0.1:8100:80 \
	-v "${BASE}/var/log:/var/log" \
	-v "${BASE}/var/www/html/:/var/www/html/" \
	--hostname="${NAME}" --name="${NAME}" "${IMAGE}"
	

