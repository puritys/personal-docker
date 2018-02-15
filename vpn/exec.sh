#!/bin/bash

source ../../personal-docker/common.sh

# --------
# Settings
# --------
account=`whoami`
dockername=vpn
dockerfile=$dockername.doc
imageName=$account/$dockername
containerName=$account-$dockername
sshPort=8006
getDefaultVolume
#volume="-v /www:/www"
port="-p 443:443"

while true; do
    if [ "x$1" == "x" ];then
        break;
    fi
    case "$1" in
      -c | --command   ) command=$2; shift 2 ;;
      -d | --debug ) DEBUG=true; shift 1 ;;
      -h | --help  ) 
          echo "Usage:"
          echo "-c: command, start / stop / build / root / login."
          echo "-d: Enable debug"
          echo "Example: ./exec.sh -c build"
          shift 1 
          exit 0
          ;;
      --) echo "-- is not a correct option.";shift 1; ;;
      * ) echo "$1 is not a correct option.";shift 1; ;;
    esac
done

setDockerMachineEnv "service"

root() {
    docker_my_init
    stop
    docker run --privileged --security-opt seccomp:unconfined -t -i $port --name $containerName $volume  $imageName  /bin/bash
}


start() {
	stop
	docker run --privileged -d -t $port $volume --name $containerName $imageName /bin/bash
    docker exec -d $containerName bash -c "sh /root/start.sh"
	docker exec -d $containerName bash -c "sh /root/startSSHD.sh"
}


if [ "x" != "x$command" ]; then
    $command
fi


