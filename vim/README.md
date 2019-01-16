# A docker image for vim-8

- https://hub.docker.com/r/puritys/vim
- You could find vim settings from here https://github.com/puritys/dotfiles
- Support language: Java / PHP / Javascript / golang

# Quick Start
- docker pull puritys/vim
- docker run -ti -v $(pwd):/src  -w /src puritys/vim vim xxx

![vim example](https://www.puritys.me/filemanage/blog_files/docker_vim.png)

## Environments

The docker image support the following environments for customized vim.

*   VIMRC

    customized .vimrc , example :  -e VIMRC=/src/.vimrc

*   VIM_THEME

    change theme , example :  -e VIM_THEME=dracula ,    options: dracula, seoul256, seoul256-light

*   VIM_PLUGIN_Eclim (only support in image vim:8.0)

    Enable eclim I love eclim more than YouCompleteMe and ale, example: -e VIM_PLUGIN_Eclim=1
    Maunal start eclim: `cd /dotfiles; sudo -u vim ./startEclim.sh `

*   VIM_PLUGIN_YouCompleteMe

    Enable YouCompleteMe, example: -e VIM_PLUGIN_YouCompleteMe=1

## Directly edit file from docker

docker run -ti -v $(pwd):/src  -w /src puritys/vim vim backup.sh

### Set a alias on bashrc for docker vim
```
alias  vim="vim_fn"

function vim_fn() {
    command=" $@ "
    docker run -ti -v $(pwd):/src  -w /src puritys/vim vim -p $command
    echo $command
    $command
}

```

## vim a file via ssh
We could not use job-control suspend [`Ctrl+z`] when we edit file at a container, one solution is connect into container from ssh then vim files. In order to solve the hotkey conflict of multiple-ssh connections I change the escape character to "`]`". 

```
ssh -t -e ] root@localhost -p39901 "cd /src/workspace"
```

### Set a Alias on bashrc for ssh vim

Finally, my favorite way to use docker vim is login in the docker from ssh first. Then I could use zz, fasd, vim-session and fzf to switch project and find files to edit.

```
alias dvs="vim_ssh_fn"

function vim_ssh_fn() {
    common_docker_set_env "tool"
    port="39901"
    command=" $@ "
    pwd=`pwd`
    vim_start
    if [ "x1" == "x$startVimDocker" ];then
        sleep 4
    fi
    command="ssh -t -e ] root@localhost -p$port \"cd /src$pwd; /bin/bash\";";

    echo $command
    eval $command
}

function vim_start() {
    startVimDocker=0
    port="39901"
    r=`docker ps --filter="name=puritys-vim" 2>&1 | wc -l`
    if [[ $r == *"1"* ]]; then
        startVimDocker=1
        mkdir -p ~/docker_tmp ~/docker_tmp/fzf_session ~/.m2
        touch ~/docker_tmp/.bash_history ~/docker_tmp/ssh-agent

        pwd=`pwd`
        docker rm puritys-vim 2>&1
        docker run -d -t --name puritys-vim  \
            -e VIM_PLUGIN_YouCompleteMe=1 \
            -p $port:22 \
            -v ~/docker_tmp/ssh-agent:/ssh-agent \
            -e SSH_AUTH_SOCK=/ssh-agent \
            -v /:/src  \
            -v ~/docker_tmp:/tmp \
            -v ~/docker_tmp/.bash_history:/root/.bash_history \
            -v ~/.m2:/root/.m2 \
            -w /src$pwd \
            puritys/vim

        # start sshd and eclim
        docker exec -d puritys-vim sh /root/start.sh
    fi
}

```

## Fonts
- You could install the font SFMono + Powerline
  - https://github.com/puritys/dotfiles/blob/master/assets/CustFont-SFMono-Powerline.woff2


## Vim Plugins

Default enabled pluings: fzf, fzf-session, incsearch, snipmate, indentLine, YouCompleteMe, ALE, nerdtree

### All installed plugin 
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
    

