#!/bin/bash

# apt
sudo apt install zsh vim neovim git git-flow make curl cifs-utils ca-certificates curl thunderbird hibiscus vlc gimp filezilla solaar libreoffice libreoffice-l10n-de libreoffice-help-de darktable stow flatpak gnome-software-plugin-flatpak

echo "solaar works after a reboot"

wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/google.gpg] https://dl-ssl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install google-chrome-stable

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /usr/share/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker "${USER}"
sudo systemctl stop docker
echo '{ "data-root": "/home/docker" }' | sudo tee /etc/docker/daemon.json
sudo systemctl start docker

wget -qO- https://pkg.ddev.com/apt/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/ddev.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ddev.gpg] https://pkg.ddev.com/apt/ * *" | sudo tee /etc/apt/sources.list.d/ddev.list
sudo apt update
sudo apt install ddev
mkcert -install

wget -qO- https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor -o /usr/share/keyrings/signal-desktop.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/signal-desktop.gpg] https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal-desktop.list
sudo apt update
sudo apt install signal-desktop

wget -qO- http://repo.steampowered.com/steam/archive/stable/steam.gpg | sudo gpg --dearmor -o /usr/share/keyrings/steam.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/steam.gpg] http://repo.steampowered.com/steam/ stable steam" | sudo tee /etc/apt/sources.list.d/steam-stable.list
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install libgl1-mesa-dri:amd64 libgl1-mesa-dri:i386 steam-launcher

sudo apt install libminizip1 gdebi-core
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -P /tmp
sudo apt install /tmp/teamviewer_amd64.deb

# flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

sudo flatpak install flathub com.skype.Client

# manually
sudo apt install libfuse2
Download from https://www.jetbrains.com/toolbox-app/
Extract jetbrains-toolbox to /home/Programme/

sudo mkdir /home/dotfiles
sudo chown -R sebastian /home/dotfiles
cd /home/dotfiles || exit
git clone git@github.com:garbast/dotfiles.git .
mv /home/sebastian/.profile /home/sebastian/.profile.old
make install

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
