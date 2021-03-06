#!/bin/bash

cmd=$1
project=$2

host_data_dir=$(pwd)/data
host_log_dir=$(pwd)/logs
hostname=$(hostname)

repo=localhost:5000
version=latest
image_name=cms_zookeeper/$project
image=$repo/$image_name:$version

container=cms-zookeeper
target_data_dir=/external/data
target_log_dir=/external/logs

os=$(uname)
if [[ $os == 'Darwin' ]]; then
    host_ip=$(ipconfig getifaddr en0)
elif [[ $os == 'Linux' ]]; then
    host_ip=$(hostname --ip-address)
fi

function usage() {
    echo "USAGE: $0 (image|image-no-cache|push|pull|create|remove|start|stop|bash|log) [project]"
}

if [[ $cmd == 'image' ]]; then
    if [[ -z $project ]]; then
        echo "project argument must not be empty"
    else
        exec docker build --tag $image --build-arg project=$project .
    fi
elif [[ $cmd == 'image-no-cache' ]]; then
    if [[ -z $project ]]; then
        echo "project argument must not be empty"
    else
        exec docker build --no-cache --tag $image --build-arg project=$project .
    fi
elif [[ $cmd == 'push' ]]; then
    if [[ -z $project ]]; then
        echo "project argument must not be empty"
    else
        exec docker image push $image
    fi
elif [[ $cmd == 'pull' ]]; then
    if [[ -z $project ]]; then
        echo "project argument must not be empty"
    else
        exec docker image pull $image
    fi
elif [[ $cmd == 'create' ]]; then
    if [[ -z $project ]]; then
        echo "project argument must not be empty"
    else
        exec docker run -d \
		-p 2181:2181 \
		-p 2888:2888 \
		-p 3888:3888 \
		--env host_ip=$host_ip \
		-it \
		--name $container \
		-h $hostname \
		--volume $host_data_dir:$target_data_dir \
		--volume $host_log_dir:$target_log_dir \
		$image
    fi
elif [[ $cmd == 'remove' ]]; then
    exec docker rm $container
elif [[ $cmd == 'start' ]]; then
    exec docker container start $container
elif [[ $cmd == 'stop' ]]; then
    exec docker container stop $container
elif [[ $cmd == 'bash' ]]; then
    exec docker exec -it $container /bin/bash
elif [[ $cmd == 'log' ]]; then
    exec docker logs $container
else
    usage
fi
