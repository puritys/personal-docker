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
    echo "-c: command, start / stop / build / root."
    echo "-d: Enable debug"
    echo "-v: Verions, -v 8.1.1"

    echo "Example: ./exec.sh -c build -v 8.1.1"
}

while true; do
    if [ "x$1" == "x" ];then
        break;
    fi
    case "$1" in
      -c | --command   ) command=$2; shift 2 ;;
      -d | --debug ) DEBUG=true; shift 1 ;;
      -v | --version ) VERSION=$2; shift 2 ;;
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
    docker build -t $imageName  .
    docker tag $imageName:latest $imageName:$VERSION
}

if [ "x" != "x$command" ]; then
    $command
else 
    help
fi


