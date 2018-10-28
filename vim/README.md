A docker image for vim-8

- You could find vim settings from here https://github.com/puritys/dotfiles


# Edit file
docker run -d -t --name puritys-vim -v /:/src  -w /src puritys/vim -p xxx.filename


# Set a alias on bash rc
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

# vim a file via ssh
```
ssh -t -e ] root@localhost -p39901 "cd /src/home/puritys/workspace && vim "
```

## Environment

- VIMRC:  customized .vimrc , example :  -e VIMRC=/src/.vimrc
- VIM_THEME:  change theme , example :  -e VIM_THEME=dracula ,    options: dracula, seoul256, seoul256-light


## Font
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
|ale|||`
