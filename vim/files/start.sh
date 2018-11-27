. ~/.alias_common

sudo /usr/sbin/sshd -E /tmp/sshd.log


if [ -f /tmp/.fasd ]; then
    sudo chmod 777 /tmp/.fasd
fi

if [ "x" != "x$VIM_PLUGIN_Eclim" ]; then
    sudo rm -f /tmp/.X1-lock
    ps aux |grep -i Xvfb |grep -v grep | awk '{printf "kill -9 %s\n",$2}' | sudo sh
    sudo Xvfb :1 -screen 0 1024x768x24 &
    DISPLAY=:1 ~/.vim/eclipse/eclipse -nosplash -consolelog -debug -application org.eclipse.equinox.p2.director   -repository http://download.eclipse.org/releases/juno      -installIU org.eclipse.wst.web_ui.feature.feature.group
    DISPLAY=:1 ~/.vim/eclipse/eclimd -b
fi
