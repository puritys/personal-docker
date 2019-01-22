docker_service_ip=172.17.0.1
enableNodeDockerfileInclude=1

setDockerMachineEnv() {
    name=$1
    if [ "x" != "x`command -v docker-machine`" ]; then
        eval $(docker-machine env $name)
        ip=`docker-machine ip $name`
        return
    fi
    ip="172.17.0.1"
}

getDefaultVolume() {
    volume="-v /www:/www"
}

docker_my_init() {
    imageName=`echo $imageName | tr '[:upper:]' '[:lower:]'`
}

build() {
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockerfile -o Dockerfile
    fi
    docker build -t $imageName  .
}

rebuild() {
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockerfile -o Dockerfile
    fi
    docker build --no-cache -t $imageName  .
}

stop() {
    docker_my_init
    docker stop $containerName || true
    docker rm -f $containerName || true
}

startDef() {
    docker_my_init
    stop
    docker run  -dti --rm $port $volume --name $containerName $imageName /bin/bash
    #docker exec -d $containerName bash -c "sh /root/start.sh"
}

start() {
    host=""
    if [ "X" != "X$hostname" ]; then
        host=" -h $hostname "
    fi
    docker_my_init
    stop
    docker run -ti $port $volume $host --name $containerName $imageName
}

myStart() {
    host=""
    if [ "X" != "X$hostname" ]; then
        host=" -h $hostname "
    fi
    docker_my_init
    stop
    docker run -d -t $port $volume $host --name $containerName $imageName /bin/bash
    docker exec -d $containerName bash -c "sh /root/start.sh"
}

root() {
    docker_my_init
    stop
    docker run -t -i $port --name $containerName $volume  $imageName  /bin/bash
}

login () {
    docker_my_init
    docker exec -ti  $containerName /bin/bash
}

