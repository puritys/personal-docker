FROM centos:7.4.1708

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term screen man
RUN ldconfig

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
RUN rpm -ivh epel-release-7-11.noarch.rpm


RUN yum install autoconf gcc gcc-c++ make cmake -y

RUN yum install ncurses-devel -y
RUN yum upgrade  ncurses-libs ncurses-term ncurses-devel -y
RUN ldconfig


RUN wget https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.xz
RUN tar -xvf node-v8.9.4-linux-x64.tar.xz; rm node-v8.9.4-linux-x64.tar.xz
RUN ln -sf /node-v8.9.4-linux-x64/bin/node /usr/bin/node
RUN ln -sf /node-v8.9.4-linux-x64/bin/npm /usr/bin/npm
RUN ln -sf /node-v8.9.4-linux-x64 /node

ENV NODE_PATH /node/lib/node_modules
ENV PATH /usr/bin:/usr/local/bin:/node/lib/node_modules/bin:/node-v8.9.4-linux-x64/lib/node_modules/bin:/node-v8.9.4-linux-x64/bin/


RUN yum install xorg-x11-server-Xvfb hicolor-icon-theme qt5-qtbase-devel libXrender qt5-qtwebkit -y 
RUN npm install gitbook-convert gitbook-cli -g
RUN cd root ; gitbook init ./temp ; cd temp; gitbook build
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

ENV DISPLAY :2
RUN yum install unzip -y
RUN wget https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKsc-hinted.zip
RUN unzip NotoSansCJKsc-hinted.zip
RUN mkdir -p /usr/share/fonts/noto/ ; \
    mv *.otf /usr/share/fonts/noto/ ; \
    fc-cache -f -v


COPY include_tmp/files/exec.sh /root/
RUN chmod -x /root/exec.sh

WORKDIR /gitbook
EXPOSE 4000

ENTRYPOINT ["sh", "/root/exec.sh"]
