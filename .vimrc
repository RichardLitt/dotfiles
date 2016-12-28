set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'valloric/youcompleteme'

" Enable syntax highlighting
syntax on

set nu

" Enable silver searcher https://github.com/ggreer/the_silver_searcher
let g:ackprg = 'ag --vimgrep'

nnoremap s <esc>:w<cr>
