sudo apt-get install \
    vim-nox \
    vim-gtk \
    git \
    tmux \
    zsh \
    build-essential \
    curl \
    xclip \
    xbindkeys \
    python-pip3

# sudo snap install keepassxc vlc steam firefox

sudo -H pip3 install pip3 --upgrade

sudo -H pip3 install glances awscli

mv /home/matt/.bashrc /home/matt/.bashrc.orig
mv /home/matt/.zshrc /home/matt/.zshrc.orig
ln -s /home/matt/.dotfiles/home/.zshrc /home/matt/.zshrc
ln -s /home/matt/.dotfiles/home/.bashrc /home/matt/.bashrc
ln -s /home/matt/.dotfiles/home/.gitconfig /home/matt/.gitconfig
ln -s /home/matt/.dotfiles/home/.speedswapper /home/matt/.speedswapper
ln -s /home/matt/.dotfiles/home/.tmux.conf /home/matt/.tmux.conf
ln -s /home/matt/.dotfiles/home/.vimrc /home/matt/.vimrc
ln -s /home/matt/.dotfiles/home/.xbindkeysrc /home/matt/.xbindkeysrc
ln -s /home/matt/.dotfiles/home/.wezterm.lua /home/matt/.wezterm.lua
ln -s /home/matt/.dotfiles/home/.emacs /home/matt/.emacs
ln -s /home/matt/.dotfiles/home/.sbclrc /home/matt/.sbclrc

gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.nemo.desktop show-desktop-icons true
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search 
 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Downloads/chrome.deb

sudo dpkg -i ~/Downloads/chrome.deb
sudo apt-get install -f

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/Tomorrow-Night.vim --create-dirs \
    https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night.vim   
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Use nativefier to install a gmail application: npm i -g nativefier; nativefier 'https://mail.google.com/mail/u/0/#inbox'" 
echo "install rustup and after, install crates: 'ripgrep'"
