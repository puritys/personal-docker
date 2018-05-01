FROM centos:7.4.1708

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


RUN yum install autoconf gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN yum install -y re2c bison libxml2-devel zip unzip git gzip which
RUN git clone https://github.com/php/php-src.git
RUN cd php-src; \
    ./buildconf; \
    ./configure --prefix=/usr --disable-all; \
    gmake; \
    gmake install
RUN cd php-src/ext/hash/; \
    phpize; \
    ./configure; \
    gmake; \
    gmake install;
RUN yum install openssl-devel -y
RUN cd php-src/ext/openssl/; \
    cp ./config0.m4 ./config.m4; \
    phpize; \
    ./configure --with-openssl --with-php-config=/usr/bin/php-config; \
    gmake; \
    gmake install;
RUN cd php-src/ext/json/; \
    phpize; \
    ./configure; \
    gmake; \
    gmake install;
RUN cd php-src/ext/phar/; \
    phpize; \
    ./configure; \
    gmake; \
    gmake install;
RUN cd php-src/ext/filter/; \
    phpize; \
    ./configure; \
    gmake; \
    gmake install;
RUN cd php-src/ext/iconv/; \
    phpize; \
    ./configure; \
    gmake; \
    gmake install;


COPY include_tmp/files/php.ini /usr/lib/php.ini
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php 
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/bin/composer

