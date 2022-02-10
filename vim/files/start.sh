echo "Execute start.sh\n"

echo "Execcuter is `whoami`\n"

. ~/.alias_common

hasSSHD=`ps aux |grep 'sbin/sshd' |grep -v 'ag|grep' | wc -l`

if [ "x0" == "x$hasSSHD" ]; then
    sudo /usr/sbin/sshd -E /tmp/sshd.log
fi
