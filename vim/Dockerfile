from puritys/vimbase:8
RUN npm install -g typescript
RUN yum -y install cmake python-devel; \
    rm -rf ~/.vim/plugged/YouCompleteMe; \
    git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/plugged/YouCompleteMe; \
    cd ~/.vim/plugged/YouCompleteMe; \
    git submodule update --init --recursive ; \
    python2 ./install.py --clang-completer --gocode-completer --java-completer ;
RUN echo "update v25";
COPY include_tmp/files/vimrc_customized /root/.vimrc_customized 
RUN cd dotfiles; \
    git pull; \
    ./install.sh -p 

COPY include_tmp/files/sshd_config /etc/ssh/sshd_config
COPY include_tmp/files/pam.sshd /etc/pam.d/sshd
COPY include_tmp/files/start.sh /root/start.sh
COPY include_tmp/files/bash_customized /root/.bash_customized
COPY include_tmp/files/bash_host       /root/.bash_host
COPY include_tmp/files/startEclim.sh   /dotfiles/startEclim.sh

ENV BASH_ENV "/root/.bashrc"

