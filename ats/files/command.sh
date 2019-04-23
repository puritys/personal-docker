command=$1

if [ "xlog" == "x$command" ]; then
    file=`ls -c /usr/local/var/log/trafficserver/ | grep squid | tail -n 1`
    tail -f $file
fi
