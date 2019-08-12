sudo pacman -S gcc r python gcc-fortran base-devel cmake unzip ninja
sudo pacman -Rdd tmux

# Instalaciòn de neovim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo mv ~/nvim.appimage /bin/nvim.appimage
sudo mv /bin/nvim.appimage /bin/nvim

# Instalaciòn de snapd
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

# Instalaciòn de aplicaciones utilizando snap - si no funciona se debe reiniciar.
sudo snap install discord
