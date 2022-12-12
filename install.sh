#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

sudo localectl set-locale LANG=en_US.UTF-8

sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt update
sudo apt-get -y install vim-gtk3 vim-scripts powerline tmux colordiff

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# get some linters from pip
python3 -m pip install black==22.3.0 flake8==4.0.1 isort==5.10.1 mypy==0.950 pylint==2.13.8 vulture==2.3

cat ~/dotfiles/ssh/authorized_keys > ~/.ssh/authorized_keys
cat ~/dotfiles/vimrc > ~/.vimrc
