FROM centos:7.4.1708

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


ARG MAVEN_VERSION=3.3.9
ARG USER_HOME_DIR="/root"

RUN useradd puritys
COPY include_tmp/files/sudoers /etc/


RUN yum install -y zip unzip git gzip which
RUN yum install -y java-1.8.0 java-1.8.0-openjdk-devel.x86_64

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
RUN su puritys bash -c"/usr/bin/git clone https://github.com/puritys/dotfiles.git /home/puritys/dotfiles"
RUN su puritys bash -c "cd /home/puritys/dotfiles && sh install.sh -j "

COPY include_tmp/files/start.sh /root/
RUN chmod 755 /root/start.sh

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

VOLUME ["/usr/src/mymaven", "/root/.m2"]


