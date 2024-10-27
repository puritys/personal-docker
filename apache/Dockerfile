FROM centos:7.9.2009

RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/CentOS-*.repo; \
    sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/CentOS-*.repo; \
    sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/CentOS-*.repo;

RUN yum -y install epel-release
RUN yum install -y httpd vim net-tools
RUN yum install -y php-mysql php php-mcrypt
RUN yum install -y mariadb-server mariadb telnet

COPY files/start.sh /root/start.sh
RUN chmod +x /root/start.sh

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin/
CMD ["/root/start.sh"]
