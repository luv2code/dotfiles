# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="mh"

#export TERM=screen-256color

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
plugins=(git debian vi-mode history wd deno rust ripgrep bun)

# opt out of dotnet telemetry
DOTNET_CLI_TELEMETRY_OPTOUT=true

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
alias ts="sudo tailscale"
alias ip="ip --color"

# File handling Suffixes
alias -s md=glow
alias -s js=node
alias -s json='jq .'  
alias -s go='go run'  
alias -s {mkv,avi,ogg,svg,jpg,png,bmp,gif,mp4,wma,mp3,mpeg}=xdg-open
alias -s {pdf,epub,rtx,html,htm}=xdg-open

if [ "$TERM_PROGRAM" = "WezTerm" ]; then
  alias -s {svg,jpg,png,bmp,gif}='wezterm imgcat'  
fi

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
    # turn off audio power save to keep speakers from buzzing
    if [[ "$1" = "performance" ]]; then
      echo "0" | sudo tee /sys/module/snd_hda_intel/parameters/power_save
    fi
}

function wttr () {
  #curl -s ""wttr.in/$LOCAL_CITY?format=3""
  curl -s ""wttr.in/$LOCAL_CITY""
}

function wttr2 () {
  #curl -s ""wttr.in/$LOCAL_CITY?format=3""
  curl -s ""v2.wttr.in/$LOCAL_CITY""
}

function cbfilter() {
  if [ $# -gt 0 ]; then
      clippaste | "$@" | clipcopy
  else
      clippaste | clipcopy
  fi
} 

function while-color() {
  if [[ "$1" = "" ]] || [[ "$2" = "" ]]; then
    echo "usage: while-color [sleep seconds] [command]"
  else
    while true; do
			clear	
			eval $2
			sleep $1
		done
  fi
}

function kill-server() {
  local port="$1"
  if [[ "$1" = "" ]]; then
		local port="8080"
  fi
	local pid=$(lsof -ti ":$port")
	if [[ "$pid" = "" ]]; then
		echo "no process listening on :$port"
		return
	fi
	kill -9 $pid
	if [[ "$?" != "0" ]]; then
    echo "usage: kill-server port"
    echo "if a port was supplied and you are seeing this. there isn't a service running on that port."
	fi
}

function fwatch() {
  if [[ "$1" = "" ]] || [[ "$2" = "" ]]; then
    echo "usage: watch [fileglob] [command]"
  else
    while inotifywait -e close_write $1 || true; do clear; eval $2; done
  fi
}
# this is the prompt from the mh.omz-theme theme with the $HOST added
export PROMPT="[%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}@$HOST:%{$fg[red]%}%30<...<%~%<<%{$reset_color%}]%($)"

# bun completions
[ -s "/home/matt/.bun/_bun" ] && source "/home/matt/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
