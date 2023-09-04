#!/bin/bash

cd /tmp/
mkdir install_process
cd ./install_process

# 1 - install packages via apt-get

sudo apt-get install -y build-essential make cmake git ripgrep python3 flatpak htop curl ninja-build gettext unzip libreadline-dev \ 
                        alsa-utils pipewire pipewire-alsa pulseaudio-utils \
                        i3 i3blocks lxappearance neofetch nitrogen rofi flameshot \
                        python3 python3-pip \
                        lua5.3 liblua5.3-dev \
                        pass

# 2 - install packages out of apt-get

# 2.1 - kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
mkdir -p ~/.local/bin/
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# 2.2 - neovim
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..

# 2.3 - Flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 2.4 - nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# 2.5 - Nerd Fonts
mkdir firacode
cd firacode
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.tar.xz
tar -xf FiraCode.tar.xz
rm -f FiraCode.tar.xz
mkdir -p ~/.local/share/fonts
mv FiraCodeNerdFont* ~/.local/share/fonts
fc-cache -fv
cd ..

# 2.6 - Luarocks
mkdir luarocks
cd luarocks
curl -R -O http://luarocks.github.io/luarocks/releases/luarocks-3.9.2.tar.gz
tar -zxf luarocks-3.9.2.tar.gz
cd luarocks-3.9.2
./configure
make
sudo make install

# 3 - Dotfiles
cd
git clone https://github.com/victoroliveirab/dotfiles .dotfiles
cd .dotfiles
rm -f $HOME/.bashrc
rm -f $HOME/.bash_aliases
ln -s $(pwd)/bash/.bashrc $HOME/.bashrc
ln -s $(pwd)/bash/.bash_aliases $HOME/.bash_aliases
ln -s $(pwd)/i3 $HOME/.config/
ln -s $(pwd)/i3status $HOME/.config/
ln -s $(pwd)/i3blocks $HOME/.config/
ln -s $(pwd)/rofi $HOME/.config/
ln -s $(pwd)/nvim $HOME/.config/

# Post Reboot

# 1 - node
nvm install 16

# 2 - Install flatpaks
flatpak install com.google.Chrome
flatpak install com.slack.Slack
