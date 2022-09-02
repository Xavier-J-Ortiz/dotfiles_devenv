#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
sudo apt-get -y install vim-gtk3 vim-scripts vim-syntastic powerline vim-pathogen tmux
git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree

BASH_CONFIG=~/.bashrc
TMUX_CONFIG=~/.tmux.conf
VIM_CONFIG=~/.vimrc
SSH_AUTH_KEYS=~/.ssh/authorized_keys

if [[ ! -f "$VIM_CONFIG" ]]; then
  touch $VIM_CONFIG
fi
echo "
call pathogen#infect()
syntax on
filetype plugin indent on

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2

\"sets powerline to look good
set rtp+=~/.vim/plugin/powerline.vim

let g:Powerline_symbols = \"fancy\"

set laststatus=2 \" Always display the statusline in all windows
set showtabline=2 \" Always display the tabline, even if there is only one tab
set noshowmode \" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set t_Co=256
set paste \" turn off horrible autoindent on buffer paste

set nocompatible      \" We're running Vim, not Vi!
syntax on             \" Enable syntax highlighting
filetype off          \" Enable filetype detection
filetype indent on    \" Enable filetype-specific indenting
filetype plugin on    \" Enable filetype-specific plugins

set modeline
autocmd filetype ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd filetype javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd filetype python setlocal ts=8 sts=4 sw=4 expandtab

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists(\"s:std_in\") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists(\"s:std_in\") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr(\"$\") == 1 && exists(\"b:NERDTree\") && b:NERDTree.isTabTree()) | q | endif
nnoremap <C-n> :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


\" adding a space delim for nerdcommenter
let NERDSpaceDelims=1

\" allow strikethrough for markdown and disable folding
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_disabled = 1
" >> ~/.vimrc

if [[ ! -f \"$BASH_CONFIG\" ]]; then
  touch \$BASH_CONFIG
fi
echo "
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/bash/powerline.sh
fi" >> ~/.bashrc

if [[ ! -f "$TMUX_CONFIG" ]]; then
  touch $BASH_CONFIG
fi
echo '
set -g default-terminal "screen-256color"
source "/usr/share/powerline/bindings/tmux/powerline.conf"

unbind C-b
set -g prefix C-a
bind C-a send-prefix' >> ~/.tmux.conf

if [[ ! -f "$SSH_AUTH_KEYS" ]]; then
  touch $SSH_AUTH_KEYS
fi

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2L+WHRgzTECGb+dO4azOr7IrEIMI16b6nMU9wKxi/z xortiz@MainDesktop' >> ~/.ssh/authorized_keys
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvul+3jmbRflJlO4ceNkLxsmI5kNuXTrUv6o1PlJh46 xortiz@Xaviers-MBP.fios-router.home' >> ~/.ssh/authorized_keys
