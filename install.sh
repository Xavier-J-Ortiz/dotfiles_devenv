#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

sudo localectl set-locale LANG=en_US.UTF-8

# sudo add-apt-repository -y ppa:jonathonf/vim
sudo apt update
sudo apt-get -y install vim-gtk3 fzf python3-venv powerline tmux colordiff xclip wl-clipboard

mkdir -p ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip && mkdir -p ~/.fonts && unzip ./Mononoki.zip -d ~/.fonts/ && rm Noto.zip && fc-cache -f -v


# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# get some linters from pip
# python3 -m pip install black==22.3.0 flake8==4.0.1 isort==5.10.1 mypy==0.950 pylint==2.13.8 vulture==2.3

REPO_DIR=$(pwd)
cat $REPO_DIR/ssh/authorized_keys | tee -a ~/.ssh/authorized_keys
ln -s $REPO_DIR/vimrc ~/.vimrc
ln -s $REPO_DIR/tmux.conf ~/.tmux.conf
ln -s $REPO_DIR/bashrc ~/.bashrc
ln -sn $REPO_DIR/config/nvim ~/.config/nvim
ln -sn $REPO_DIR/config/ghostty ~/.config/ghostty
ln -sn $REPO_DIR/config/alacritty ~/.config/alacritty
