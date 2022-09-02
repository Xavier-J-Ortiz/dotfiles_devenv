#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
sudo apt-get -y install vim-gtk3 vim-scripts vim-syntastic powerline vim-pathogen tmux
git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree
