#!/bin/bash
#TODO: delete internet connection check?
curl -O https://blackarch.org/strap.sh

cd configs
rm zshrc hybrid.vim zshrc_aliases tmux.conf init.vim git_config
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/nvim/files/hybrid.vim
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/zsh/files/zshrc
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/zsh/files/zshrc_aliases
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/zsh/files/git_config
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/tmux/files/tmux.conf
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/nvim/files/init.vim
wget https://raw.githubusercontent.com/cherez0ff/os/master/roles/lynx/files/lynxrc
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
#podman build . -t malorian
docker build . -t malorian
#docker run -it --rm -v /home/user/hack:/root/hack -v /etc/hosts:/etc/hosts -v /tmp/.X11-unix:/tmp/.X11-unix --cap-add NET_BIND_SERVICE --cap-add NET_RAW --cap-add NET_ADMIN --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH malorian zsh
