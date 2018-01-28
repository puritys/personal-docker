#!/bin/bash
source ../common.sh

# --------
# Settings
# --------
account=`whoami`
dockerfile=Dockerfile
dockername=node
imageName=$account/$dockername
containerName=$account-$dockername
enableNodeDockerfileInclude=0
#getDefaultVolume
volume="-v /www:/www -v /www/node8Modules:/usr/local/lib/node_modules/"
port=""

help () {
    echo "Usage:"
    echo "-c: command, start / stop / build / root."
    echo "-d: Enable debug"
    echo "Example: ./exec.sh -c build"
}

while true; do
    if [ "x$1" == "x" ];then
        break;
    fi
    case "$1" in
      -c | --command   ) command=$2; shift 2 ;;
      -d | --debug ) DEBUG=true; shift 1 ;;
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
    docker build -t $imageName  .
}

if [ "x" != "x$command" ]; then
    $command
else 
    help
fi


