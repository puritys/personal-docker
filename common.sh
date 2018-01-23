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
    dockerfile-include  -i $dockerfile -o Dockerfile
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
    docker run -t -i -p $port --name $containerName $volume  $imageName  /bin/bash
}

