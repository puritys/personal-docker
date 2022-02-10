# A base docker image for vim-8

- https://hub.docker.com/r/puritys/vimbase
- https://hub.docker.com/r/puritys/vim

including vim8, eclim, YouCompleteMe, php, nodejs, java and golang

## vimbase:8.3.0

use coc to replace most ale features
- neovim 0.5.1, vim 8.4.2105
- gradle 7.0
- nodejs v12.16.1 , eslint
- npm 6.13.4
- java openjdk 1.8.0_292
- python 2.7.17, 3.6.8 , pip2 , pip3, pyright
- golang, gopls
- php 7

## vimbase:8.2.0
- vim 8.4.2105
- gradle 7.0
- nodejs v12.16.1 , eslint
- npm 6.13.4
- java openjdk 1.8.0_292
- java language server: eclipse.jdt.ls 0.52.1
- python 2.7.17, 3.6.8 , pip2 , pip3, pyright
- golang, gopls
- php 7


## vimbase:8.1.2

update packages' version base on vimbase:8.1.

- vim 8.2.0444
- gradle 5.6.4
- nodejs 12.16.1
- npm 6.13.4
- java language server: eclipse.jdt.ls 0.52.1

## vimbase:8.1.1

Add more plugins base on vimbase:8.1.

- eslint
- latest version of ale

## vimbase:8.1
- vim 8.1.1317
- java jdk 11
- go 1.11.4
- php 7.2
- python 2.7.5
- pylint
- clang
- gradle
- maven
- java language server: eclipse.jdt.ls 0.39.0
    - https://github.com/eclipse/eclipse.jdt.ls
    - path: /root/eclipse.jdt.ls
- vim plugin: YouCompleteMe: https://github.com/Valloric/YouCompleteMe
    - path: /root/.vim/plugged/YouCompleteMe/
- php language server : https://github.com/felixfbecker/php-language-server
    - path: /root/vendor/bin/php-language-server.php
- nodejs v6.16.0
- npm 3.10.10
- Xvfb

## vimbase:8

- vim 8.1.0479
- java 1.8
- eclim
- php 5.4
- go 1.11.2
- node v6.14.3
- Xvfb

## How to push multiple architecture
- build image from different env
- docker manifest rm puritys/vimbase:8.3.0
- docker manifest create puritys/vimbase:8.3.0 --amend puritys/vimbase:8.3.0-amd64 --amend puritys/vimbase:8.3.0-arm64
- docker manifest push puritys/vimbase:8.3.0
