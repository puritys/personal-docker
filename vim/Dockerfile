from puritys/vimbase:8
RUN echo "update v26";
COPY include_tmp/files/vimrc_customized /root/.vimrc_customized 
RUN yum install unzip -y
RUN cd dotfiles; \
    rm -rf /root/.vim/JavaImp /root/openjdk/; \
    git pull; \
    cp vim/javaPlugin/google_checks.xml /usr/local/etc/; \
    cp vim/javaPlugin/checkstyle.xml /usr/local/etc/ ; \
    mkdir -p /root/eclipse-workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/; \
    sh vim/javaPlugin/eclipse_config/org.eclipse.jdt.core.prefs.sh > /root/eclipse-workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.jdt.core.prefs ; \
    sudo chmod -R 777 /root/eclipse-workspace/ ; \
    ./install.sh -p --javaImp ;\
    rm /root/openjdk/*.zip

COPY include_tmp/files/sshd_config /etc/ssh/sshd_config
COPY include_tmp/files/pam.sshd /etc/pam.d/sshd
COPY include_tmp/files/start.sh /root/start.sh
COPY include_tmp/files/bash_customized /root/.bash_customized
COPY include_tmp/files/bash_host       /root/.bash_host
COPY include_tmp/files/startEclim.sh   /dotfiles/startEclim.sh
COPY include_tmp/files/startEclim.sh   /root/startEclim.sh

ENV BASH_ENV "/root/.bashrc"

