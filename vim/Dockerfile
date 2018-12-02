FROM centos:7.4.1708

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


RUN yum install autoconf gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN yum install -y python-devel openssh-server
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa; \
    passwd -d root; \
    useradd -g root vim; \
    passwd -d vim

RUN cd /root ; \
    wget https://github.com/vim/vim/archive/v8.1.0479.tar.gz; \
    tar -zxvf v8.1.0479.tar.gz ; \
    cd /root/vim-8.1.0479 ; ./configure --enable-multibyte --enable-pythoninterp=yes --prefix=/usr; \
    cd /root/vim-8.1.0479 ; gmake ; gmake install ; cd /; rm -rf /root/vim* /root/v8*.gz
RUN yum install yum install php-5.4.16-45.el7 java maven nodejs-6.14.3-1.el7 npm-3.10.10-1.6.14.3.1.el7 golang-1.9.4-1.el7 -y

RUN git clone https://github.com/puritys/dotfiles.git; \
    cd dotfiles; \
    ./install.sh -i --javaImp; \
    rm /root/openjdk/*.zip
RUN npm install -g typescript
RUN yum -y install cmake python-devel; \
    rm -rf ~/.vim/plugged/YouCompleteMe; \
    git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/plugged/YouCompleteMe; \
    cd ~/.vim/plugged/YouCompleteMe; \
    git submodule update --init --recursive ; \
    python2 ./install.py --clang-completer --gocode-completer --java-completer ;
RUN yum install ntp -y ; \
    ntpdate -s time.stdtime.gov.tw
COPY include_tmp/files/sudoers /etc/sudoers
RUN sudo mkdir -p /root/.eclipse/ /root/.eclim/; \
    sudo rm -rf /home/vim; sudo ln -sf /root /home/vim; sudo chmod -R 775 /root/; 

RUN echo "1";cd dotfiles; \
    git pull; \
    sudo -u vim ./install.sh -j ; \
    rm -rf ~/*.gz ; \
    touch /tmp/install.log; \
    chmod 777 /tmp/install.log; \
    mkdir -p /root/workspace/.metadata/.plugins/org.eclipse.core.resources/
RUN echo "update v24";
COPY include_tmp/files/vimrc_customized /root/.vimrc_customized 
RUN cd dotfiles; \
    git pull; \
    ./install.sh -p 

COPY include_tmp/files/sshd_config /etc/ssh/sshd_config
COPY include_tmp/files/pam.sshd /etc/pam.d/sshd
COPY include_tmp/files/start.sh /root/start.sh
COPY include_tmp/files/bash_customized /root/.bash_customized
COPY include_tmp/files/bash_host       /root/.bash_host

USER vim
ENV BASH_ENV "/root/.bashrc"

