FROM puritys/vimbase:8.1.1
RUN yum install libatomic bind-utils jq -y
RUN cd /root ; \
    wget https://github.com/vim/vim/archive/v8.2.0444.tar.gz; \
    tar -zxvf v8.2.0444.tar.gz ; \
    mv /root/vim-8.2.0444 /root/vim; \
    cd /root/vim ; ./configure --enable-multibyte --enable-pythoninterp=yes --prefix=/usr; \
    cd /root/vim ; gmake ; gmake install ; cd /; rm -rf /root/vim* /root/v8*.gz
RUN wget https://nodejs.org/dist/v12.16.1/node-v12.16.1-linux-x64.tar.xz
RUN tar -xf  node-v12.16.1-linux-x64.tar.xz --directory /usr/local --strip-components 1
RUN npm install -g eslint
COPY include_tmp/files/eslintrc.json /.eslintrc.json
RUN cd /root; \
    wget https://downloads.gradle.org/distributions/gradle-5.6.4-bin.zip ; \
    unzip gradle-5.6.4-bin.zip ; \
    rm gradle-5.6.4-bin.zip ; \
    rm -rf /usr/local/gradle; \
    mv gradle-5.6.4 /usr/local/gradle
COPY include_tmp/files/eclipse /root/eclipse/
RUN cd root/eclipse ; \
    cat x* > eclipse.jdt.ls-0.52.1.tar.gz; \
    tar -zxvf eclipse.jdt.ls-0.52.1.tar.gz; \
    mv  Users/puritys/eclipse.jdt.ls /root/; \
    rm -rf Users eclipse.jdt.ls*.gz; \
    cd /root ; \
    rm -rf eclipse
RUN wget http://www.java2s.com/Code/JarDownload/tools/tools-1.7.0.jar.zip; \
    unzip tools-1.7.0.jar.zip; \
    rm tools*.zip; \
    mkdir -p /root/lib; \
    mv tools-1.7.0.jar /root/lib/tools.jar


RUN cd dotfiles; \
    git pull; \
    ./install.sh -p --ctags

COPY include_tmp/files/.vimrc_plugins /root/.vimrc_plugins_tmp
COPY include_tmp/files/JavaImp /root/.vim/JavaImp/
RUN rm -rf /root/.vim/plugged/ale/
RUN echo "\n" | vim -u /root/.vimrc_plugins_tmp -c :PlugInstall +qall 


ENV BASH_ENV "/root/.bashrc"
ENV PATH "/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/gradle/bin"
