FROM centos:7.4.1708
RUN yum install autoconf gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN yum install -y bzip2 openssl-devel tcl-devel wget
RUN wget http://apache.mirrors.ovh.net/ftp.apache.org/dist/trafficserver/trafficserver-7.1.5.tar.bz2
RUN tar -jxvf trafficserver-7.1.5.tar.bz2; \
    cd trafficserver-7.1.5; \
    ./configure; \
    gmake install; \
    rm -rf trafficserver-7.1.5 /*.bz2 /tmp

COPY include_tmp/files/start.sh     /root/
COPY include_tmp/files/remap.sh     /root/
COPY include_tmp/files/records.sh   /root/
COPY include_tmp/files/ssl_multicert.sh /root/
COPY include_tmp/files/logging.sh /root/

COPY include_tmp/files/cert.pem /usr/local/etc/trafficserver/
COPY include_tmp/files/ip_allow.config /usr/local/etc/trafficserver/

RUN chmod +x /root/start.sh
ENV ATS_REMAP="map / http://127.0.0.1:8080/"
ENV ATS_SERVER_PORTS="80 443:ssl"
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin/
CMD ["/root/start.sh"]

