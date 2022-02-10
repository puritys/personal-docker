#!/bin/bash
source ../../common.sh

# --------
# Settings
# --------
account=`whoami`
dockername=vimBase
dockerfile=$dockername.doc
imageName=$account/$dockername
containerName=$account-$dockername
getDefaultVolume
volume="-v /:/src -v /home/$account/docker_tmp/.bash_history:/root/.bash_history -v /home/$account/:/puritys "
port=""

help () {
    echo "Usage:"
    echo "-c: command, start / stop / build / root / buildx / dockerfile."
    echo "-d: Enable debug"
    echo "-v: Verions, -v 8.1.1"
    echo "-a: arch, -a amd64 arm64"

    echo "Example: ./exec.sh -c build -v 8.1.1"
    echo "Example: ./exec.sh -c buildx -v 8.3.0 -a amd64 --noCache --push"

}
PUSH=""
noCache=""
while true; do
    if [ "x$1" == "x" ];then
        break;
    fi
    case "$1" in
      -c | --command   ) command=$2; shift 2 ;;
      -d | --debug ) DEBUG=true; shift 1 ;;
      -v | --version ) VERSION=$2; shift 2 ;;
      -a | --arch) ARCH=$2; shift 2 ;;
      --push) PUSH="--push"; shift 1 ;;
      --noCache) noCache="--no-cache"; shift 1 ;;
      -h | --help  )
          help
          shift 1
          exit 0
          ;;
      --) echo "-- is not a correct option.";shift 1; ;;
      * ) echo "$1 is not a correct option.";shift 1; ;;
    esac
done

setDockerMachineEnv tool;

rebuild() {
    if [ -z $VERSION ]; then
        echo "Need verions: -v 8.x"
        exit 1
    fi
    rm -rf include_tmp
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockername-$VERSION.doc -o Dockerfile
    fi
    docker build --no-cache -t $imageName  .
    docker tag $imageName:latest $imageName:$VERSION

}

build() {
    if [ -z $VERSION ]; then
        echo "Need verions: -v 8.x"
        exit 1
    fi
    rm -rf include_tmp
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockername-$VERSION.doc -o Dockerfile
    fi
    docker build -t $imageName:$VERSION  .
}

buildx() {
    if [ -z $VERSION ]; then
        echo "Need verions: -v 8.x"
        exit 1
    fi
    if [ -z $ARCH ]; then
        echo "Need arch: -a amd64 arm64"
        exit 1
    fi
    ARCH_NAME="x64"
    if [ $ARCH == "arm64" ];then
        ARCH_NAME="arm64"
    fi
    rm -rf include_tmp
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockername-$VERSION.doc -o Dockerfile
    fi
    docker buildx build $noCache $PUSH --build-arg ARCH_NAME=$ARCH_NAME --platform linux/$ARCH -t $imageName:$VERSION-$ARCH .
    docker tag $imageName:$VERSION-$ARCH $imageName:$VERSION
}

dockerfile() {
    if [ -z $VERSION ]; then
        echo "Need verions: -v 8.x"
        exit 1
    fi
    rm -rf include_tmp
    docker_my_init
    if [ "x1" == "x$enableNodeDockerfileInclude" ]; then
        dockerfile-include  -i $dockername-$VERSION.doc -o Dockerfile
    fi
}

if [ "x" != "x$command" ]; then
    $command
else
    help
fi
