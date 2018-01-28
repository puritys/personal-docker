FROM centos:7

RUN yum install -y sudo wget telnet openssh-server vim git ncurses-libs ncurses-term man
RUN ldconfig
RUN wget https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.xz
RUN tar -xvf node-v8.9.4-linux-x64.tar.xz; rm node-v8.9.4-linux-x64.tar.xz
RUN ln -sf /node-v8.9.4-linux-x64/bin/node /usr/bin/node
RUN ln -sf /node-v8.9.4-linux-x64/bin/npm /usr/bin/npm
RUN ln -sf /node-v8.9.4-linux-x64 /node

ENV NODE_PATH /node/lib/node_modules
ENV PATH /usr/bin:/usr/local/bin:/node/lib/node_modules/bin
