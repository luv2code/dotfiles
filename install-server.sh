sudo apt-get install \
    vim-nox \
    git \
    tmux \
    zsh \
    build-essential \
    curl \
    python3-pip

sudo -H pip3 install pip --upgrade

sudo -H pip3 install glances[all]

mv /home/matt/.bashrc /home/matt/.bashrc.orig
mv /home/matt/.zshrc /home/matt/.zshrc.orig
ln -s /home/matt/.dotfiles/home/.zshrc /home/matt/.zshrc
ln -s /home/matt/.dotfiles/home/.bashrc /home/matt/.bashrc
ln -s /home/matt/.dotfiles/home/.gitconfig /home/matt/.gitconfig
ln -s /home/matt/.dotfiles/home/.speedswapper /home/matt/.speedswapper
ln -s /home/matt/.dotfiles/home/.tmux.conf /home/matt/.tmux.conf
ln -s /home/matt/.dotfiles/home/.sift.conf /home/matt/.sift.conf
ln -s /home/matt/.dotfiles/home/.vimrc /home/matt/.vimrc
ln -s /home/matt/.dotfiles/home/.xbindkeysrc /home/matt/.xbindkeysrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/Tomorrow-Night.vim --create-dirs \
    https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night.vim   
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
