FROM puritys/vimbase:8.1

RUN cd dotfiles; \
    git pull; \
    ./install.sh -p --ctags

COPY include_tmp/files/.vimrc_plugins /root/.vimrc_plugins_tmp
COPY include_tmp/files/JavaImp /root/.vim/JavaImp/
RUN npm install -g eslint
COPY include_tmp/files/eslintrc.json /.eslintrc.json
RUN rm -rf /root/.vim/plugged/ale/
RUN echo "\n" | vim -u /root/.vimrc_plugins_tmp -c :PlugInstall +qall 


ENV BASH_ENV "/root/.bashrc"
ENV PATH "/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/gradle/bin"
