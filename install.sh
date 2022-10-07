#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt update
sudo apt-get -y install vim-gtk3 vim-scripts powerline tmux colordiff

if [[ ! -d ~/.vim/bundle/nerdtree ]]; then
  git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree
else
  cd ~/.vim/bundle/nerdtree && git pull origin master
fi

if [[ ! -d ~/.vim/bundle/ale ]]; then
  git clone https://github.com/dense-analysis/ale.git ~/.vim/bundle/ale
else
  cd ~/.vim/bundle/ale && git pull origin master
fi

# get some linters from pip
python3 -m pip install black==22.3.0 flake8==4.0.1 isort==5.10.1 mypy==0.950 pylint==2.13.8 vulture==2.3

cat ~/dotfiles/ssh/authorized_keys > ~/.ssh/authorized_keys
cat ~/dotfiles/vimrc > ~/.vimrc
