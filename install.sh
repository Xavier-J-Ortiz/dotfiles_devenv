#!/bin/bash
sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

sudo localectl set-locale LANG=en_US.UTF-8

sudo apt update
sudo apt-get -y install npm git luarocks vim-gtk3 fzf python3-venv pyenv powerline tmux colordiff xclip wl-clipboard

# install nvim from neovim/neovim-releases if not present
if ! type nvim > /dev/null 2>&1; then
    sudo apt-get autoremove
    echo "neovim is not present. Installing \`latest\` from the deb package from the github repo neovim/neovim-releases."
    latest=$(git ls-remote --tags https://github.com/neovim/neovim-releases | grep -Eo 'refs/tags/v([0-9]+(\.)?)+' | sort -r | head -n1 | cut -f3 -d'/')
    wget https://github.com/neovim/neovim-releases/releases/download/$latest/nvim-linux-x86_64.deb
    sudo dpkg -i nvim-linux-x86_64.deb
    rm nvim-linux-x86_64.deb
fi

mkdir -p ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Mononoki.zip && mkdir -p ~/.fonts && unzip -o ./Mononoki.zip -d ~/.fonts/ && rm ./Mononoki.zip && fc-cache -f -v

# Add authorized_keys if the pub key fingerprint doesn't already exist in file.
REPO_DIR=$(pwd)

# Unless you're me, you probably don't want to give me ssh access to your system.
if [[ $USER == 'xortiz' ]]; then
    mkdir -p ~/.ssh
    while IFS= read -r key; do
        if [[ -n "$key" ]]; then
            key_fingerprint=$(echo "$key" | ssh-keygen -lf - 2>/dev/null | awk '{print $2}')
            if [[ -n "$key_fingerprint" ]] && ! grep -q "$key_fingerprint" <(ssh-keygen -lf ~/.ssh/authorized_keys 2>/dev/null); then
                echo "$key" >> ~/.ssh/authorized_keys
            fi
        fi
    done < "$REPO_DIR/ssh/authorized_keys"
fi

ln -s $REPO_DIR/vimrc ~/.vimrc
ln -s $REPO_DIR/tmux.conf ~/.tmux.conf
ln -s $REPO_DIR/bashrc ~/.bashrc
ln -sn $REPO_DIR/config/nvim ~/.config/nvim
ln -sn $REPO_DIR/config/ghostty ~/.config/ghostty
