# A docker image for vim-8

- You could find vim settings from here https://github.com/puritys/dotfiles

# Quick Start
- docker pull puritys/vim
- docker run -d -t --name puritys-vim -v /:/src  -w /src puritys/vim -p xxx.filename

![vim example](https://www.puritys.me/filemanage/blog_files/docker_vim.png)

## How to change setting

The docker image support the following environments for customized vim.

*   VIMRC

    customized .vimrc , example :  -e VIMRC=/src/.vimrc

*   VIM_THEME

    change theme , example :  -e VIM_THEME=dracula ,    options: dracula, seoul256, seoul256-light

*   VIMRC_CUSTOMIZED

    default is 1, the .vimrc_customized has some hot plugins such as lightline, if you don't need them, just set to zero it will stop loading these plugins.


## Directly edit file from docker
docker run -d -t --name puritys-vim -v /:/src  -w /src puritys/vim -p xxx.filename


### Set a alias on bashrc for docker vim
```
alias  vim="vim_fn"

function vim_fn() {
    command=" $@ "
    pwd=`pwd`
    r=`docker inspect puritys-vim 2>&1`
    docker run -d -t --name puritys-vim -v /:/src  -w /src puritys/vim -p $command
    echo $command
    $command
}

```

## vim a file via ssh
We could not use job-control suspend (`Ctrl+z`) when we edit file at a container, one solution is connect into container from ssh then vim files. In order to solve the hotkey conflict of multiple-ssh connections I change the escape character to "]". 

```
ssh -t -e ] root@localhost -p39901 "cd /src/workspace && vim "
```

### Set a Alias on bashrc for ssh vim

```
alias dvs="vim_ssh_fn"

function vim_ssh_fn() {
    port="39901"
    command=" $@ "
    pwd=`pwd`
    vim_start
    command="ssh -t -e ] root@localhost -p$port \"cd /src$pwd && vim \"";

    echo $command
    eval $command
}


function vim_start() {
    port="39901"
    r=`docker ps --filter="name=puritys-vim" 2>&1 | wc -l`
    if [ "x1" == "x$r" ]; then
        pwd=`pwd`
        docker rm puritys-vim 2>&1
        docker run -d -t --name puritys-vim  \
            -e VIM_THEME=mystyle_white \
            -p $port:22 \
            -v $(readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent \
            -v /:/src  \
            -v ~/:/puritys \
            -v ~/docker_tmp:/tmp \
            -v ~/docker_tmp/.bash_history:/root/.bash_history \
            -v ~/.m2:/root/.m2 \
            -w /src$pwd \
            puritys/vim

        docker exec -d puritys-vim sh /root/start.sh
    fi
}
```

## Fonts
- You will need the font: https://github.com/puritys/dotfiles/blob/master/assets/CustFont-SFMono-Powerline.woff2


## Vim Plugins

|plugin | shortcut| description|
|:---|:---|:---|
| jistr/vim-nerdtree-tabs        |          | Show file tree when you call ":tabe" to open a file |
| junegunn/fzf                   | [Ctrl+p] | Fuzzle search for opening a existed file            |
| thinca/vim-quickrun            | [Ctrl+e] | Execute the file you are editing                    |
| ntpeters/vim-better-whitespace |          | Show white space of line tail                       |
| haya14busa/incsearch.vim       |          | Better search interface                             |
| vim-syntastic/syntastic        | sc       | syntax check                                        |
| garbas/vim-snipmate            |          | Auto complete script                                |
|1995eaton/vim-better-javascript-completion| |Javascript auto complete function|
| Valloric/YouCompleteMe     |               | Auto complete function for c/c++/ruby/... |
| google/vim-codefmt         |               | Auto fix java code formatter/indent       |
| vim-airline/vim-airline    |               | Beautiful status bar and tab              |
| godlygeek/tabular          | align,<Enter> | Auto align code                           |
| vim-json-line-format       | ,jp ,jw       | JSON Parser (support unicode)             |
| shawncplus/phpcomplete.vim |               | PHP Auto Complete                         |
| Yggdroot/indentLine        |               | Display indent line                       |
| vim-scripts/PDV--phpDocumentor-for-Vim| doc | generate php document |
|w0rp/ale|| Asynchronous Linting Engine|
    

