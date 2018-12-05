from puritys/vimbase:8
RUN echo "update v26";
COPY include_tmp/files/vimrc_customized /root/.vimrc_customized 
RUN yum install unzip -y
RUN cd dotfiles; \
    rm -rf /root/.vim/JavaImp /root/openjdk/; \
    git pull; \
    ./install.sh -p --javaImp ;\
    rm /root/openjdk/*.zip

COPY include_tmp/files/sshd_config /etc/ssh/sshd_config
COPY include_tmp/files/pam.sshd /etc/pam.d/sshd
COPY include_tmp/files/start.sh /root/start.sh
COPY include_tmp/files/bash_customized /root/.bash_customized
COPY include_tmp/files/bash_host       /root/.bash_host
COPY include_tmp/files/startEclim.sh   /dotfiles/startEclim.sh

ENV BASH_ENV "/root/.bashrc"

