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
    ARCH_NAME="x64"
    if [ ! -z $ARCH ] && [ $ARCH == "arm64" ];then
        ARCH_NAME="arm64"
    fi
    if [ "x$isPodman" == "xtrue" ]; then
        podman build -t $imageName --build-arg ARCH_NAME=$ARCH_NAME .
    else
        docker build -t $imageName --build-arg ARCH_NAME=$ARCH_NAME .
    fi
}

# build for multiple arch
buildx() {
    if [ -z $ARCH ]; then
        echo "Need arch: -a amd64 arm64"
        exit 1
    fi
    platform="linux/x64"
    ARCH_NAME="x64"
    if [ $ARCH == "amd64" ];then
        ARCH_NAME="x64"
        platform="linux/amd64"
    elif [ $ARCH == "arm64" ];then
        ARCH_NAME="arm64"
        platform="linux/arm64"
    elif [ $ARCH == "arm64/v8" ];then
        ARCH_NAME="arm64"
        platform="linux/arm64/v8"
    elif [ $ARCH == "arm64/v7" ];then
        ARCH_NAME="arm64"
        platform="linux/arm/v7"
    fi

    rm -rf include_tmp
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockerfile -o Dockerfile
    fi
    if [ "x$isPodman" == "xtrue" ]; then
        podman build -t $imageName --platform $platform --build-arg ARCH_NAME=$ARCH_NAME .
    else
        docker buildx build $noCache $PUSH --build-arg ARCH_NAME=$ARCH_NAME --platform $platform -t $imageName:latest-$ARCH .
        docker tag $imageName:latest-$ARCH $imageName:latest
    fi
}

rebuild() {
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockerfile -o Dockerfile
    fi
    if [ "x$isPodman" == "xtrue" ]; then
        podman build --no-cache -t $imageName  .
    else
        docker build --no-cache -t $imageName  .
    fi
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

startIfNotFound() {
    docker_my_init
    r=`docker ps --filter="name=$containerName" 2>&1 | wc -l`
    if [[ $r == *"1"* ]]; then
        echo -e "The container $containerName is not existed.\n"
        start
    else
        echo -e "The container $containerName is existed.\n"
    fi
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
