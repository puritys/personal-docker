enableNodeDockerfileInclude=1
setDockerMachineEnv() {
    name=$1
    if [ "x" != "x`command -v docker-machine`" ]; then
        eval $(docker-machine env $name)
    fi
}

getDefaultVolume() {
    volume="-v /www:/www"
}

build() {
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockerfile -o Dockerfile
    fi
    docker build -t $imageName  .
}

stop() {
    docker stop $containerName || true
    docker rm -f $containerName || true
}

start() {
    stop
    docker run -d -t $port $volume --name $containerName $imageName /bin/bash
    docker exec -d $containerName bash -c "sh /root/start.sh"
}

root() {
    stop
    docker run -t -i $port --name $containerName $volume  $imageName  /bin/bash
}

