# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="mh"

export TERM=xterm-256color

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian vi-mode history wd memo deno rust ripgrep)

source $ZSH/oh-my-zsh.sh
apt_pref='aptitude'

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

# Customize to your needs...
alias la='ls -la'
alias grab='wget -nd -r -l 1 -P . -A jpeg,jpg,bmp,gif,png'
alias adu="sudo $apt_pref update && sudo $apt_pref full-upgrade" 
alias v="$EDITOR"
alias rgs="rg -S"

# File handling Suffixes
alias -s md=glow
alias -s js=node
alias -s go='go run'  
alias -s {mkv,avi,ogg,svg,jpg,png,bmp,gif,mp4,wma,mp3,mpeg}=xdg-open
alias -s {pdf,epub,rtx,html,htm}=xdg-open

if hash xclip 2>/dev/null; then
    alias clip='xclip -sel clip'
    alias clippaste='xclip -sel clip -o'
fi

if [[ -f ~/.zshrclocal ]]; then
    source ~/.zshrclocal
fi
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

function setgov ()
{
    # for setting cpu governor like $> setgov powersave
    if [[ "$1" = "performance" ]] || [[ "$1" = "powersave" ]]; then
      echo "$1" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor 
    else
      echo "Wrong parameter. performance|powersave required"
      return 1
    fi
}

# this is the prompt from the mh.omz-theme theme with the $HOST added
export PROMPT="[%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}@$HOST:%{$fg[red]%}%30<...<%~%<<%{$reset_color%}]%($)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
