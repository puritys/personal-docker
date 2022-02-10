FROM centos:7

RUN yum install -y epel-release
RUN yum install -y ocserv wget telnet
RUN yum install -y tcpdump nc net-tools git


COPY include_tmp/files/genCert.sh /root/
COPY include_tmp/files/genServerCert.sh /root/
COPY include_tmp/files/genClientCert.sh /root/
COPY include_tmp/files/ocserv.conf /etc/ocserv/
COPY include_tmp/______common_files_vpn/ocpasswd              /etc/ocserv/
COPY include_tmp/______common_files_vpn_certs/ca-cert.pem     /etc/ocserv/
COPY include_tmp/______common_files_vpn_certs/server-cert.pem /etc/ocserv/
COPY include_tmp/______common_files_vpn_certs/server-key.pem  /etc/ocserv/
COPY include_tmp/files/sysctl.conf /etc/
COPY include_tmp/files/start.sh    /root/

