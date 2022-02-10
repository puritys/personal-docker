FROM centos:7.4.1708

RUN yum -y install epel-release
RUN yum install -y httpd vim net-tools
RUN yum install -y php-mysql php php-mcrypt
RUN yum install -y mariadb-server mariadb telnet

COPY files/start.sh /root/start.sh
RUN chmod +x /root/start.sh

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin/
CMD ["/root/start.sh"]

