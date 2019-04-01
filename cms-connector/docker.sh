#!/bin/bash

cmd=$1
project=$2
user=$3

host_log_dir=$(pwd)/logs
hostname=$(hostname)

repo=localhost:5000
version=latest
image_name=cms_connector/$project
image=$repo/$image_name:$version

container=cms-connector
target_log_dir=/external/logs

os=$(uname)
if [[ $os == 'Darwin' ]]; then
    host_ip=$(ipconfig getifaddr en0)
elif [[ $os == 'Linux' ]]; then
	host_ip=$(hostname --ip-address)
fi

function usage() {
    echo "USAGE: $0 (image|image-no-cache|push|pull|create|remove|start|stop|bash|log) [project] [user]"
}

if [[ $cmd == 'image' ]]; then
    if [[ -z $project || -z $user ]]; then
        echo "project & user argument must not be empty"
    else
        exec docker build --tag $image --build-arg project=$project --build-arg user=$user .
    fi
elif [[ $cmd == 'image-no-cache' ]]; then
    if [[ -z $project || -z $user ]]; then
        echo "project & user argument must not be empty"
    else
        exec docker build --no-cache --tag $image --build-arg project=$project --build-arg user=$user .
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
elif [[ $cmd == 'clean' ]]; then
	images=$(docker images -f dangling=true -q)
	if [[ $images ]]; then
		exec docker rmi $images
	fi
elif [[ $cmd == 'create' ]]; then
    if [[ -z $project ]]; then
        echo "project argument must not be empty"
    else
        exec docker run -d \
        -p 9183:9183 \
        -p 9986:9986 \
		--env host_ip=$host_ip \
        -it \
        --name $container \
        -h $hostname \
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
