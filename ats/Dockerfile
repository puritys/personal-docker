FROM centos:7.4.1708

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


RUN yum install autoconf gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN yum install -y bzip2 openssl-devel tcl-devel
RUN wget http://apache.mirrors.ovh.net/ftp.apache.org/dist/trafficserver/trafficserver-7.1.3.tar.bz2
RUN tar -jxvf trafficserver-7.1.3.tar.bz2; \
    cd trafficserver-7.1.3; \
    ./configure; \
    gmake install;

COPY include_tmp/files/start.sh     /root/
COPY include_tmp/files/remap.sh     /root/
COPY include_tmp/files/records.sh   /root/
COPY include_tmp/files/ssl_multicert.sh /root/
COPY include_tmp/files/cert.pem /usr/local/etc/trafficserver/
RUN chmod +x /root/start.sh
ENV ATS_REMAP="map / http://127.0.0.1:8080/"
ENV ATS_SERVER_PORTS="80 443:ssl"

ENTRYPOINT ["/root/start.sh"]

