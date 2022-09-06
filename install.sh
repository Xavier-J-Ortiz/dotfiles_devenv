#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

sudo apt-get -y install vim-gtk3 vim-scripts vim-syntastic powerline vim-pathogen tmux

if [[ ! -d ~/.vim/bundle/nerdtree ]]; then
  git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree
else
  cd ~/.vim/bundle/nerdtree && git pull origin master
fi

cat ~/dotfiles/ssh/authorized_keys > .ssh/authorized_keys

