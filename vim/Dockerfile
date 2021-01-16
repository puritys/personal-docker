from puritys/vimbase:8.1.2

COPY include_tmp/files/vimrc_customized /root/.vimrc_customized 
COPY include_tmp/files/.vimrc_plugins /root/.vimrc_plugins_tmp2
COPY include_tmp/vimBase_files/JavaImp /root/.vim/JavaImp/

RUN npm install -g jsonlint -g
RUN rm -rf /root/.vim/plugged/ale/
RUN echo "\n" | vim -u /root/.vimrc_plugins_tmp2 -c :PlugInstall +qall 

RUN cd dotfiles; \
    git pull; \
    cp vim/javaPlugin/google_checks.xml /usr/local/etc/; \
    cp vim/javaPlugin/checkstyle.xml /usr/local/etc/ ; \
    ./install.sh -p

COPY include_tmp/files_eclipseAnnotationProcessor/lombok.jar /root/lombok.jar
COPY include_tmp/files/sshd_config /etc/ssh/sshd_config
COPY include_tmp/files/pam.sshd /etc/pam.d/sshd
COPY include_tmp/files/start.sh /root/start.sh
COPY include_tmp/files/bash_customized /root/.bash_customized
COPY include_tmp/files/bash_host       /root/.bash_host

ENV BASH_ENV "/root/.bashrc"
ENV PATH "/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/gradle/bin"
