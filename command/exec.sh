#!/bin/bash
source ../common.sh

# --------
# Settings
# --------
account=`whoami`
dockername=command
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


connect() {
	stop
	docker run -d -t  --name $containerName $imageName /bin/bash
	docker exec -t -i  $containerName bash -c "/usr/bin/mysql -h $docker_service_ip -uroot -p"
}

if [ "x" != "x$command" ]; then
    $command
fi


