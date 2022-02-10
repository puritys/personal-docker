# A docker image with vim 8

- https://hub.docker.com/r/puritys/vim
- You could find vim settings from here https://github.com/puritys/dotfiles
- Support language: Java / PHP / Javascript / golang / C / CPP / Python

# Quick Start
- docker pull puritys/vim:stable
- docker run -ti -v $(pwd):/src  -w /src puritys/vim vim xxx

# Theme

## seoul256

<img src="https://www.puritys.me/filemanage/blog_files/docker_vim.png" width=700/>

## mystyle_white

<img src="https://www.puritys.me/filemanage/blog_files/vim_my_theme.png" width=700/>

- You have to change the terminal background color to be "#F1E7D0"

## Environments

The docker image support the following environments for customized vim.

* VIMRC

    customized .vimrc , example :  -e VIMRC=/src/.vimrc

* VIM_THEME

    change theme , example :  -e VIM_THEME=dracula ,    options: nord, dracula, seoul256, seoul256-light

* VIM_PLUGIN_Eclim (only support in image vim:8.0)

    Enable eclim, example: -e VIM_PLUGIN_Eclim=1
    Maunal start eclim: `cd /dotfiles; sudo -u vim ./startEclim.sh `

* VIM_PLUGIN_YouCompleteMe
  * Enable YouCompleteMe, example: -e VIM_PLUGIN_YouCompleteMe=1
  * YouCompleteMe will be loaded when switch to insert mode.
  * To remove .project and .classpath if you used eclim to create project before.

* VIM_PLUGIN_YouCompleteMe_ENABLE_SYNTAX
    Enable YouCompleteMe java syntax, the default value is "0".

* VIM_PLUGIN_YouCompleteMe_auto_trigger
    Enable / Disable ycm_auto_trigger

* VIM_PLUGIN_LightLine
    Enable lightline, the default value is "1"

* VIM_PLUGIN_ALE
  * Default will enable ALE lint, you can disable it by `-e VIM_PLUGIN_ALE=0`
  * I suggest you to use ALE instead of YouCompletMe.

* VIM_PLUGIN_ALE_AUTO_COMPLETE
  * Default will enable ALE Auto Complete

* VIM_PLUGIN_AIRLINE
  * enable airline plugin, the default value is "0"

* CUST_FONT: Use "Cust SF Mono" and "Cust SF Mono Powerline" fonts, you have to install the following fonts first.
    `-e CUST_FONT=1`
    * https://github.com/puritys/dotfiles/blob/master/assets/CustSFMono-Regular.otf
    * https://github.com/puritys/dotfiles/blob/master/assets/CustSFMonoPowerline-Regular.otf


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

## Quick Command

- `sc`: syntax check
- `align|<Enter>`: use "|" to align all field, Use visual mode to select colums then type 'aling?<Enter>' to align by '?'
- `ar`: async run
- `Ctrl+p`: fuzzle find files
- `Ctrl+e`: Execute this file
- `Ctrl+g`: Goto defined function
- `Ctrl+d`: Show Auto Complete


## Java compile issue

#### class not found

- you have to run ecliConfig & ecliUpdate on shell then restart vim agein. ecliUpdate will download all packages of pom.xml to ~/.m2/repository

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
|neoclide/coc.nvim|| IDE like|


## Java (vim:8.0 eclim)

I use Eclim for java synax check and youCompleteMe for autocomplete. You have to create a project once if you want to see the synax error UI.


- Create Eclipse Project:  `:ProjectCreate ./ -n java` , execute this command inside vim.
- Start Maven Project: Just use last command to create project   will be fine.
- Start gradle project: `gradle eclipse`, execute this command then create a project.
- Update Maven Or gradle .classpath : `ecliUpdate`, execute this alias command on terminal.
    - for Maven project: You can save the pom.xml to trigger eclipse update .classpath and libraries.
    - for Gradle proecjt: You can save the .classpath to trigger eclipse update libraries.
- You use `:ProjectImport ./ ` command to import project after restart container.


## How to push multiple architecture
- build image from different env
- docker manifest rm puritys/vim:latest
- docker manifest create puritys/vim:latest --amend puritys/vim:latest-amd64 --amend puritys/vim:latest-arm64
- docker manifest push puritys/vim:latest

## login docker on Mac
- security unlock-keychain
- cat ~/.docker_paxx | docker login --username xxx --password-stdin
