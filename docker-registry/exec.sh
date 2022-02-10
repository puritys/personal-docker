#!/bin/bash
source ../common.sh

# --------
# Settings
# --------
account=`whoami`
dockerfile=registry.doc
dockername=registry
imageName=registry:2
containerName=registry
getDefaultVolume
volume=""
port="-p 443:443"

help () {
    echo "Usage:"
    echo "-c: command, init / build / start / stop / build / root."
    echo "-d: Enable debug"
    echo "--host: hostname, Sample: xxx.yy.com"
    echo "Example: ./exec.sh -c build"
}

while true; do
    if [ "x$1" == "x" ];then
        break;
    fi
    case "$1" in
      -c | --command   ) command=$2; shift 2 ;;
      -d | --debug ) DEBUG=true; shift 1 ;;
      --host   ) host=$2; shift 2 ;;
      --port   ) port=$2; shift 2 ;;
      --dockerPath    ) dockerPath=$2; shift 2 ;;
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

init () {
    if [ "x" == "x$host" ]; then
        echo "Please set --host";
        exit 1
    fi
    if [ "x" == "x$port" ]; then
        echo "Please set --port";
        exit 1
    fi

    createCertificate $host
    sudo mkdir -p /etc/docker/certs.d/$host:$port/
    sudo cp ./$host.crt /etc/docker/certs.d/$host:$port/ca.crt
    sudo cp ./$host.crt /etc/pki/ca-trust/source/anchors/$host.crt
    sudo mkdir certs
    sudo mv $host* certs/
    sudo update-ca-trust enable
    sudo service docker restart
}


start () {
    if [ "x" == "x$host" ]; then
        echo "Please set --host";
        exit 1
    fi
    if [ "x" == "x$dockerPath" ]; then
        echo "Please set --dockerPath";
        exit 1
    fi

    docker kill registry || true
    docker rm registry || true
    docker run -d \
      --restart=always \
      --name registry \
      -v $dockerPath:/var/lib/registry \
      -v `pwd`/certs:/certs \
      -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
      -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/$host.crt \
      -e REGISTRY_HTTP_TLS_KEY=/certs/$host.key \
      -p 443:443 \
      registry:2
}

createCertificate() {
  name=$1
  OPENSSL=${OPENSSL:-openssl}
  COUNT=${COUNT:-100001}
  NPROCS=${NPROC:-$(getconf _NPROCESSORS_ONLN)}

  $OPENSSL genrsa -out ${name}.key 2048
  $OPENSSL req -new -key ${name}.key -out ${name}.csr \
    -subj /C=US/ST=CA/L=Norm/O=TrafficServer/OU=Test/CN=${name}
  $OPENSSL x509 -req -days 365 \
    -in ${name}.csr -signkey ${name}.key -out ${name}.crt
  cat ${name}.crt ${name}.key > ${name}.pem
}

if [ "x" != "x$command" ]; then
    $command
fi

