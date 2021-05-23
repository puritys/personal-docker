#!/bin/bash
source ../common.sh

# --------
# Settings
# --------
account=`whoami`
dockerfile=vim.doc
dockername=vim
imageName=$account/$dockername
containerName=$account-$dockername
getDefaultVolume
volume="-v /:/src -v /home/$account/docker_tmp/.bash_history:/root/.bash_history -v /home/$account/:/puritys "
port="-p 39901:22"

rm -rf include_tmp/

help () {
    echo "Usage:"
    echo "-c: command, start / stop / build / buildx / root."
    echo "-d: Enable debug"
    echo "Example: ./exec.sh -c build"
    echo "Example: ./exec.sh -c buildx -a amd64 --noCache --push"
}
noCache=""
while true; do
    if [ "x$1" == "x" ];then
        break;
    fi
    case "$1" in
      -c | --command   ) command=$2; shift 2 ;;
      -d | --debug ) DEBUG=true; shift 1 ;;
      -a | --arch) ARCH=$2; shift 2 ;;
      --noCache) noCache="--no-cache"; shift 1 ;;

      --push) PUSH="--push"; shift 1 ;;
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

if [ "x" != "x$command" ]; then
    $command
else
    help
fi
