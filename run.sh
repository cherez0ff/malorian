#!/bin/bash
#TODO: delete internet connection check?
curl -O https://blackarch.org/strap.sh

cd configs
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/nvim/files/hybrid.vim
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/zsh/files/zshrc
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/zsh/files/zshrc_aliases
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/tmux/files/tmux.conf
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/nvim/files/init.vim
cd ..

# Allow connection to clipboard
#pacman -Sy xorg-xhost
xhost local:root

echo 'Input VULNERS_TOKEN'
read VULNERS_TOKEN
echo 'Input SHODAN_TOKEN'
read SHODAN_TOKEN
#echo "VULNERS_TOKEN=$VULNERS_TOKEN" >> /tmp/environment
#echo "SHODAN_TOKEN=$SHODAN_TOKEN" >> /tmp/environment
export "VULNERS_TOKEN=$VULNERS_TOKEN"
export "SHODAN_TOKEN=$SHODAN_TOKEN"
echo 'done!'
#podman-compose up
docker-compose up --build
