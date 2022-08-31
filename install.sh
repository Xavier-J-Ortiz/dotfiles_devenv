#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
sudo apt-get -y install vim-gtk3 vim-scripts powerline vim-pathogen tmux
# .tmux.conf
git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree

echo "call pathogen#infect()
syntax on
filetype plugin indent on

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set laststatus=2" >> ~/.vimrc

echo "if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/bash/powerline.sh
fi" >> ~/.bashrc

echo 'set -g default-terminal "screen-256color"
source "/usr/share/powerline/bindings/tmux/powerline.conf"

unbind C-b
set -g prefix C-a
bind C-a send-prefix' >> ~/.tmux.conf

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2L+WHRgzTECGb+dO4azOr7IrEIMI16b6nMU9wKxi/z xortiz@MainDesktop' >> .ssh/authorized_keys
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBvul+3jmbRflJlO4ceNkLxsmI5kNuXTrUv6o1PlJh46 xortiz@Xaviers-MBP.fios-router.home' >> .ssh/authorized_keys
