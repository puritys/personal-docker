FROM centos:7.4.1708

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


RUN yum install autoconf gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN yum install -y python-devel
RUN cd /root ; wget https://github.com/vim/vim/archive/v7.4.2367.tar.gz
RUN cd /root ; tar -zxvf v7.4.2367.tar.gz ;
RUN cd /root/vim-7.4.2367 ; ./configure --enable-multibyte --enable-pythoninterp=yes --prefix=/usr --with-x --x-includes=/usr/include/X11/ --x-libraries=/usr/lib64/ 
RUN cd /root/vim-7.4.2367 ; gmake ; gmake install


RUN git clone https://github.com/puritys/dotfiles.git
RUN cd dotfiles; \
    ./install.sh -i
RUN cd dotfiles; \
    rm -rf ~/.vim/plugged/YouCompleteMe; \
    ./install.sh --autoComplete
RUN yum install yum install php-5.3.3-14  -y
RUN yum install java -y
RUN cd dotfiles; \
    ./install.sh -j
RUN yum install -y yum install glibc-static

RUN git clone https://github.com/Yelp/dumb-init.git
RUN cd dumb-init; \
    gmake
RUN mv /dumb-init/dumb-init /usr/local/bin/

ENV BASH_ENV "/root/.bashrc"


