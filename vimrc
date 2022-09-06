call pathogen#infect()
syntax on
filetype plugin indent on

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2

" number lines and dark background
set background=dark
set number

"sets powerline to look good
set rtp+=~/.vim/plugin/powerline.vim

let g:Powerline_symbols = "fancy"

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
set paste " turn off horrible autoindent on buffer paste

set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype off          " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set modeline
autocmd filetype ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd filetype python setlocal ts=8 sts=4 sw=4 expandtab

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <C-n> :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


" adding a space delim for nerdcommenter
let NERDSpaceDelims=1

" allow strikethrough for markdown and disable folding
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_disabled = 1
