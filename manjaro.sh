sudo pacman -S gcc r python gcc-fortran base-devel cmake unzip ninja xclip npm python-pip yarn
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

# Configuración de github 
git config --global user.name "Justo Manrique Urbina"
git config --global user.email ja.manrique@pm.me

git clone git://github.com/jamanrique/linux-conf.git ~/Documents/linux-conf

ssh-keygen -t rsa -b 4096 -C "ja.manrique@pm.me"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

xclip -sel clip < ~/.ssh/id_rsa.pub

# Configuración de neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
