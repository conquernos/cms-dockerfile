#!/bin/bash

cmd=$1

repo=localhost:5000
version=latest
image_name=cms_base
image=$repo/$image_name:$version

function usage() {
	echo "USAGE: $0 (image|image-no-cache|push|pull)"
}

if [[ $cmd == 'image' ]]; then
	exec docker build --tag $image .
elif [[ $cmd == 'image-no-cache' ]]; then
	exec docker build --no-cache --tag $image .
elif [[ $cmd == 'push' ]]; then
	exec docker image push $image
elif [[ $cmd == 'pull' ]]; then
	exec docker image pull $image
else
	usage
fi
