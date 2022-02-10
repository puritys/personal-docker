
FROM centos:7

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


RUN yum install gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN yum install -y zlib-devel openssl-devel
RUN wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz
RUN tar -xvf Python-2.7.14.tar.xz
RUN cd Python-2.7.14 ; \
    ./configure --prefix=/usr/local/share/python2.7 --with-zlib=/usr/include --enable-unicode=ucs4; \
    gmake 
RUN cd Python-2.7.14; sudo gmake install

RUN ln -sf /usr/local/share/python2.7/bin/python2.7 /usr/local/bin/python2.7
RUN cd Python-2.7.14; python2.7 setup.py install
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python2.7 get-pip.py
RUN ln -sf /usr/local/share/python2.7/bin/pip /usr/local/bin/pip2.7
RUN rm -rf Python-2.7.14 Python-2.7.14.tar.xz


COPY include_tmp/files/start.sh /root/
