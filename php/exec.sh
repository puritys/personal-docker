#!/bin/bash
source ../common.sh

# --------
# Settings
# --------
account=`whoami`
dockername=phpLatest
dockerfile=$dockername.doc
imageName=$account/$dockername
containerName=$account-$dockername
getDefaultVolume
#volume="-v /xx:/xx"
port=""

while true; do
    if [ "x$1" == "x" ];then
        break;
    fi
    case "$1" in
      -c | --command   ) command=$2; shift 2 ;;
      -d | --debug ) DEBUG=true; shift 1 ;;
      -h | --help  ) 
          echo "Usage:"
          echo "-c: command."
          echo "-d: Enable debug"
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
fi


