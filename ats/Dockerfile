FROM centos:7.4.1708

RUN yum install -y hwloc openssl perl-URI tcl

COPY include_tmp/files/start.sh     /root/
COPY include_tmp/files/remap.sh     /root/
COPY include_tmp/files/records.sh   /root/
COPY include_tmp/files/ssl_multicert.sh /root/
COPY include_tmp/files/logging.sh /root/
COPY include_tmp/files/trafficserver-7.1.8-1.el7.centos.x86_64.rpm /root/
COPY include_tmp/files/cert.pem /usr/local/etc/trafficserver/
COPY include_tmp/files/ip_allow.config /root/

RUN rpm -ivh /root/trafficserver-7.1.8-1.el7.centos.x86_64.rpm

RUN mkdir -p /usr/local/etc/trafficserver/ /usr/local/var/log/trafficserver/ /usr/local/var/trafficserver
RUN chown -R nobody /usr/local/etc/trafficserver/ /usr/local/var/log/trafficserver/ /usr/local/var/trafficserver; \
    chmod -R 755 /usr/local/etc/trafficserver/ /usr/local/var/log/trafficserver/ /usr/local/var/trafficserver;

RUN chmod +x /root/start.sh
ENV ATS_REMAP="map / http://127.0.0.1:8080/"
ENV ATS_SERVER_PORTS="80 443:ssl"
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin/
CMD ["/root/start.sh"]

