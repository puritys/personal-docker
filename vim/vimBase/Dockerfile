FROM centos:8.3.2011

ARG ARCH_NAME

RUN dnf install epel-release -y
RUN dnf install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term man glibc-langpack-en zip
RUN dnf install -y gcc gcc-c++ clang make cmake ncurses-devel
RUN ldconfig
RUN dnf install libatomic bind-utils jq -y
RUN dnf install -y openssh-server xorg-x11-server-Xvfb

RUN dnf install -y passwd
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa; \
    passwd -d root;

RUN mkdir -p /root/.ssh/; \
    echo -e "StrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" > /root/.ssh/config


#
#
RUN dnf install -y python2 python3 python2-devel python3-devel
RUN wget https://nodejs.org/dist/v12.16.1/node-v12.16.1-linux-$ARCH_NAME.tar.xz
RUN tar -xf  node-v12.16.1-linux-$ARCH_NAME.tar.xz  --directory /usr/local --strip-components 1
RUN npm install -g eslint
RUN npm install -g jsonlint -g
COPY include_tmp/files/eslintrc.json /.eslintrc.json

RUN dnf install -y java java-1.8.0-openjdk-devel
RUN cd /root; \
    wget https://downloads.gradle-dn.com/distributions/gradle-7.0-bin.zip; \
    unzip gradle-7.0-bin.zip ; \
    rm gradle-7.0-bin.zip ; \
    rm -rf /usr/local/gradle; \
    mv gradle-7.0 /usr/local/gradle
COPY include_tmp/files/eclipse /root/eclipse/
RUN cd /root/eclipse ; \
    cat x* > eclipse.jdt.ls-0.52.1.tar.gz; \
    tar -zxvf eclipse.jdt.ls-0.52.1.tar.gz; \
    mv  /root/eclipse/eclipse.jdt.ls /root/; \
    cd /root; \
    rm -rf /root/eclipse /root/eclipse.jdt.ls*.gz
RUN yum install epel-release yum-utils -y ; \
    yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y ; \
    yum install php php-common php-opcache  php-cli php-gd php-curl php-mysqlnd -y ;
RUN dnf install -y golang
RUN cd /root ; \
    wget https://github.com/vim/vim/archive/v8.2.2566.tar.gz; \
    tar -zxvf v8.2.2566.tar.gz ; \
    mv /root/vim-8.2.2566 /root/vim; \
    cd /root/vim ; ./configure --prefix=/usr  --enable-multibyte \
         --enable-pythoninterp=yes --with-python2-config-dir=/usr/bin/ \
        --enable-python3interp=yes --with-python3-config-dir=/usr/bin/;  \
    cd /root/vim ; gmake ; gmake install ; cd /; rm -rf /root/vim* /root/v8*.gz

RUN mkdir -p /root/.vim/JavaImp/cache

RUN echo "update 1"
RUN git clone https://github.com/puritys/dotfiles.git ; \
    cd dotfiles; \
    git pull; \
    ./install.sh -i -p --ctags

COPY include_tmp/files/.vimrc_plugins /root/.vimrc_plugins_tmp
COPY include_tmp/files/JavaImp /root/.vim/JavaImp/
RUN rm -rf /root/.vim/plugged/ale/
RUN echo "\n" | vim -u /root/.vimrc_plugins_tmp -c :PlugInstall +qall
RUN echo "\n" | vim  -c :CocInstall coc-json coc-tsserver +qall
RUN echo "\n" | vim  -c :CocInstall coc-java  +qall
RUN echo "\n" | vim  -c :CocInstall coc-pyright  +qall


ENV BASH_ENV "/root/.bashrc"
ENV PATH "/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/gradle/bin"
