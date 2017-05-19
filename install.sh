sudo apt-get install \
    vim-nox \
    vim-gtk \
    git \
    tmux \
    zsh \
    build-essential \
    curl \
    xclip \
    keepass2 \
    cinnamon \
    easystroke \
    xbindkeys \
    python-pip

sudo -H pip install pip --upgrade

sudo -H pip install glances awscli

mv /home/matt/.bashrc /home/matt/.bashrc.orig
mv /home/matt/.zshrc /home/matt/.zshrc.orig
ln -s /home/matt/.dotfiles/home/.zshrc /home/matt/.
ln -s /home/matt/.dotfiles/home/.bashrc /home/matt/.bashrc
ln -s /home/matt/.dotfiles/home/.gitconfig /home/matt/.gitconfig
ln -s /home/matt/.dotfiles/home/.speedswapper /home/matt/.speedswapper
ln -s /home/matt/.dotfiles/home/.tmux.conf /home/matt/.tmux.conf
ln -s /home/matt/.dotfiles/home/.vimrc /home/matt/.vimrc
ln -s /home/matt/.dotfiles/home/.xbindkeysrc /home/matt/.xbindkeysrc

gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.nemo.desktop show-desktop-icons true
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search 
 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ~/Downloads/chrome.deb

sudo dpkg -i ~/Downloads/chrome.deb
sudo apt-get install -f

xdg-open https://www.dropbox.com/install

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
