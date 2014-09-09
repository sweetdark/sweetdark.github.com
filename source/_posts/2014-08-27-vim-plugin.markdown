---
layout: post
title: "vim 插件"
date: 2014-08-27 20:59:00 +0800
comments: true
tags: vim
---
记录一些常用的好用的Vim插件
##通用
1. [Vbundle](https://github.com/gmarik/Vundle.vim) 这个可以很方便的安装和管理Vim的插件。最好是也装上git，因为很多插件托管在github上
2. [txtbrowser](http://www.vim.org/scripts/script.php?script_id=2899) 高效处理纯文本,提供快速的搜索和打开URL等功能，支持Email的格式等
3. [nerdtree](https://github.com/scrooloose/nerdtree) 非常好的目录浏览的插件，功能强大
4. [ctrlp](https://github.com/kien/ctrlp.vim) 文件和buffer的模糊查询
5. [vim-surround](https://github.com/tpope/vim-surround) 引号，括号等操作，非常方便

##编程
1. [pythonmode](https://github.com/klen/python-mode) python必备
2. [vim-debug](https://github.com/vim-debug.vim) 支持python 和php debug
3. [vim-fugitive](https://github.com/tpope/vim-fugitive) git的插件可以在Vim中执行git命令，非常方便, 类似的有git-vim 
4. [a.vim](www.vim.org/script.php?script_id=31)在头文件和cpp,c文件中切换
5. [neocomplcache.vim](https://github.com/Shougo/neocomplcache.vim) 强大的自动补全插件
6. [syntastic](https://github.com/scrooloose/syntastic) Python和其它多种语言的语法检查

##样式
1. [vim-airline](https://github.com/bling/vim-airline)让vim的用户体验更好
2. [Wombat](http://files.werx.dk/wombat.vim)一种样式

<!-- more -->
``` vim _vimrc的配置
set nocompatible "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
let path='$VIMFILES/bundle/'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Python and PHP Debugger
Bundle 'fisadev/vim-debug.vim'
" Better file browser
Bundle 'scrooloose/nerdtree'
" Code commenter
Bundle 'scrooloose/nerdcommenter'
" Class/module browser
Bundle 'majutsushi/tagbar'
" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Bundle 'fisadev/vim-ctrlp-cmdpalette'
" Git integration
Bundle 'motemen/git-vim'
" Tab list panel
Bundle 'kien/tabman.vim'
" Airline
Bundle 'bling/vim-airline'
" Terminal Vim with 256 colors colorscheme
Bundle 'fisadev/fisa-vim-colorscheme'
" Consoles as buffers
Bundle 'rosenfeld/conque-term'
" Pending tasks list
"Bundle 'fisadev/FixedTaskList.vim'
" Surround
Bundle 'tpope/vim-surround'
" Autoclose
Bundle 'Townk/vim-autoclose'
" Indent text object
Bundle 'michaeljsmith/vim-indent-object'
" Python mode (indentation, doc, refactor, lints, code checking, motion and
" operators, highlighting, run and ipdb breakpoints)
Bundle 'klen/python-mode'
" Better autocompletion
Bundle 'Shougo/neocomplcache.vim'
" Automatically sort python imports
Bundle 'fisadev/vim-isort'
" Drag visual blocks arround
Bundle 'fisadev/dragvisuals.vim'
" Window chooser
"Bundle 't9md/vim-choosewin'
" Python and other languages code checker
Bundle 'scrooloose/syntastic'
" Search results counter
Bundle 'IndexedSearch'
" XML/HTML tags navigation
Bundle 'matchit.zip'
" Gvim colorscheme
Bundle 'Wombat'
" Yank history navigation
Bundle 'YankRing.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

```
暂时先介绍这么多，后续更新
