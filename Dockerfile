FROM blackarchlinux/blackarch

ARG VULNERS_TOKEN
ENV VULNERS_TOKEN=$VULNERS_TOKEN

ARG SHODAN_TOKEN
ENV SHODAN_TOKEN=$SHODAN_TOKEN

ENV TERM xterm-256color


###########################################################################
### MISC

RUN mkdir /root/scripts
RUN mkdir -p /var/www/dav
RUN mkdir -p /root/wordlists

COPY wordlists /root/wordlists/
COPY prepare_scripts /tmp/prepare_scripts/
###########################################################################
### SOFTWARE INSTALLATION

WORKDIR /tmp

# Add multilib repo (for wine)
RUN echo '[multilib]' >> /etc/pacman.conf && echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf

# rubygens ipv6 fail fix
RUN echo ':ipv4_fallback_enabled: true' > ~/.gemrc

# Install black arch
#COPY strap.sh strap.sh
RUN pacman -Sly && \
    pacman -Syyu --noconfirm reflector && \
    reflector --latest 5 -p https --sort rate --save /etc/pacman.d/mirrorlist

RUN ln -s /usr/sbin/nvim /usr/sbin/vim

# Install pacman packages
COPY software/base.txt base.txt
COPY software/toolkit.txt toolkit.txt
RUN cat base.txt | xargs pacman -S --noconfirm --needed
RUN cat toolkit.txt  | xargs pacman -S --noconfirm --needed

# Install pip packages
COPY software/pip.txt pip.txt
RUN pip install --upgrade pip
RUN pip install -r pip.txt

# Install go packages
RUN go install github.com/deletescape/goop@latest

# Get scripts
RUN /tmp/prepare_scripts/tools.sh

# Install npm packages
#COPY software/npm.txt npm.txt
# FAILED ON podman
#RUN cat npm.txt | xargs npm install
# TODO install

# Install ouch https://github.com/ouch-org/ouch
#RUN curl -s https://raw.githubusercontent.com/ouch-org/ouch/master/install.sh | sh

# Install namebuster
#RUN go install github.com/benbusby/namebuster@latest

# Install perl modules
#RUN cpan install Class::C3 Data::Validate::IP Dpkg::Compression::FileHandle DPKG::Parse::Packages File::Touch IO::Socket::INET6 Mojo::Collection Mojo::Date Mojo::File Mojo::UserAgent Mojo::SQLite Net::CIDR::Set Net::DNS Params::Validate Try::Tiny YAML::Any 

###########################################################################

## Getscripts
#RUN git clone --depth=1 https://github.com/isauditsscripts /optscripts && \
#    rm -rf /optscripts/.git
## Get payloads
#RUN git clone --depth=1 https://github.com/swisskyrepo/PayloadsAllTheThings /opt/payloads && \
#    rm -rf /opt/payloads/.git

####################################################################
### Fileserver stuff
COPY configs/httpd.conf /etc/httpd/conf/httpd.conf
COPY dav /var/www/dav
RUN chmod -R 777 /var/www
#RUN /usr/bin/apachectl start
RUN ln -s /var/www/dav /root/fileserver

RUN /tmp/prepare_scripts/fileserver.sh


####################################################################
## Wordlists stuff

RUN /tmp/prepare_scripts/wordlists_gen.sh
####################################################################
# Vuln docker exmaples

#RUN mkdir /root/vulhub
#RUN wget -4 https://github.com/vulhub/vulhub/archive/master.zip -O /root/vulhub-master.zip && \
#   unzip /root/vulhub-master.zip -d /root && \
#   mv /root/vulhub-master /root/vulhub && \
#   rm /root/vulhub-master.zip

####################################################################
### MISC

#Fix rpcclient
RUN touch /etc/samba/smb.conf

# Get powershell stuff
# TODO: choose what I really need
#RUN git clone --depth=1 https://github.com/samratashok/nishang /opt/nishang && \
#    rm -rf /opt/nishang/.git

#RUN git clone --depth=1 https://github.com/Ascotbe/Kernelhub /opt/kernelhub && \
#    rm -rf /opt/kernelhub/.git

# update cmsmap
RUN cmsmap -U PC -D || true

# Copy my scripts and make them executable
COPY scripts/* /root/scripts/
RUN chmod +x /root/scripts/*
####################################################################
### ENV & tools configuration
WORKDIR /root


# Configure zsh 
RUN git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh
RUN chsh -s $(which zsh)

# Copy configs
COPY configs/zshrc .zshrc
COPY configs/zshrc_aliases .zshrc_aliases
COPY configs/zshrc_extra .zshrc_extra
COPY configs/tmux.conf .tmux.conf
COPY configs/msf_res.rb .msf_res.rb
COPY configs/hybrid.vim .config/nvim/colors/hybrid.vim
COPY configs/init.vim .config/nvim/init.vim
COPY configs/proxychains.conf /etc/proxychains.conf
COPY configs/git_config ~/.git/config
COPY configs/lynxrc ~/.lynxrc

# Configure vim
RUN curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN nvim --headless +PlugInstall +qa

RUN echo 'nameserver 9.9.9.9' > /etc/resolv.conf
COPY configs/resolv.conf /etc/resolv.conf

# Add default ssh key payload
COPY ssh /root/.ssh
RUN chmod 600 /root/.ssh/id_rsa

# SSH config
COPY configs/ssh_config /root/.ssh/config

###########################################################################
RUN rm -rf /tmp/*

WORKDIR /root
