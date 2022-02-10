FROM centos:7.4.1708

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


RUN yum install autoconf gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN sudo yum install autoconf libcurl-devel expat-devel gcc gettext-devel kernel-headers openssl-devel perl-devel zlib-devel  openssl-devel  -y
RUN curl --tlsv1.2 -O -L https://github.com/git/git/archive/v2.16.3.tar.gz
RUN tar -zxvf v2.16.3.tar.gz
RUN cd git-2.16.3; \
    make clean; \
    make configure; \
    ./configure --prefix=/; \
    make \

RUN cd git-2.16.3; \
    make install 


