
FROM centos

ARG ARCH_NAME
RUN cd /etc/yum.repos.d/; \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*; \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*; \
    yum update -y
RUN dnf install epel-release -y
RUN dnf install -y sudo wget telnet openssh-server git ncurses-libs ncurses-term man glibc-langpack-en zip
RUN dnf install -y gcc gcc-c++ clang make cmake ncurses-devel
RUN ldconfig
RUN dnf install libatomic bind-utils jq -y
RUN dnf install -y openssh-server xorg-x11-server-Xvfb

RUN dnf install -y passwd
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa; \
    passwd -d root;

RUN mkdir -p /root/.ssh/; \
    echo -e "StrictHostKeyChecking no\nUserKnownHostsFile=/dev/null" > /root/.ssh/config
RUN wget https://nodejs.org/dist/v16.18.1/node-v16.18.1-linux-$ARCH_NAME.tar.xz
RUN tar -xf  node-v16.18.1-linux-$ARCH_NAME.tar.xz  --directory /usr/local --strip-components 1
RUN npm install -g eslint
RUN npm install -g jsonlint -g
COPY include_tmp/files/eslintrc.json /.eslintrc.json

#
#
RUN dnf install -y python2 python3 python2-devel python3-devel
RUN npm install -g pyright

RUN dnf install -y java-11-openjdk-devel maven
RUN alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.*/bin/java
ENV JAVA_HOME "/usr/lib/jvm/java-11-openjdk-11.0.13.0.8-4.el8_5.x86_64/"
RUN cd /root; \
    wget https://downloads.gradle-dn.com/distributions/gradle-7.0-bin.zip; \
    unzip gradle-7.0-bin.zip ; \
    rm gradle-7.0-bin.zip ; \
    rm -rf /usr/local/gradle; \
    mv gradle-7.0 /usr/local/gradle

RUN mkdir -p /root/.config/coc/extensions/coc-java-data/server; \
    cd /root/.config/coc/extensions/coc-java-data/server ; \
    wget https://download.eclipse.org/jdtls/snapshots/jdt-language-server-1.11.0-202205051421.tar.gz; \
    tar -zxvf jdt-language-server-1.11.0-202205051421.tar.gz ;\
    rm -rf jdt-language-server-*.gz; \
    ln -sf /root/.config/coc/extensions/coc-java-data/server /root/eclipse

RUN wget https://projectlombok.org/downloads/lombok.jar; \
    mv lombok.jar /usr/local/lib/
RUN yum install epel-release yum-utils -y ; \
    yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y ; \
    yum install php php-common php-opcache  php-cli php-gd php-curl php-mysqlnd php-json -y ;
RUN dnf install -y golang
RUN yum -y install libtool
RUN cd /root; \
    if [ "$ARCH_NAME" == "arm64" ]; then \
        git clone https://github.com/neovim/neovim.git; \
        cd neovim; \
        make CMAKE_BUILD_TYPE=Release PREFER_LUA=On CMAKE_INSTALL_PREFIX=/usr ; \
        make install ; \
        cd ../; \
        rm -rf neovim; \
    else \
        wget https://github.com/neovim/neovim/releases/download/v0.6.1/nvim-linux64.tar.gz ; \
        tar -zxvf nvim-linux64.tar.gz ; \
        cd nvim-linux64; \
        mv bin/* /usr/bin/ ; \
        mv lib/* /usr/lib/ ; \
        mkdir -p /share; \
        mv share/man/man1/nvim.1  /usr/share/man/man1/;\
        mv share/syntax/*         /share/nvim/syntax/; \
        mv share/macros/*         /share/nvim/macros/; \
        mv share/nvim/*           /share/nvim/; \
        cd /root; \
        rm -rf nvim-linux64.tar.gz  nvim-linux64 ; \
    fi; \
    ln -sf /usr/bin/nvim /usr/bin/vim;

RUN python3 -m pip install --user --upgrade pynvim

RUN mkdir -p /root/.vim/JavaImp/cache

RUN echo "update 1"
RUN git clone https://github.com/puritys/dotfiles.git ; \
    cd dotfiles; \
    git pull; \
    ./install.sh -i -p --ctags

COPY include_tmp/files/.vimrc_plugins /root/.vimrc_plugins_tmp
COPY include_tmp/files/JavaImp /root/.vim/JavaImp/
RUN rm -rf /root/.vim/plugged/ale/
RUN echo "\n" | /usr/bin/vim -u /root/.vimrc_plugins_tmp -c :PlugInstall +qall

ENV BASH_ENV "/root/.bashrc"
ENV PATH "/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/gradle/bin"
