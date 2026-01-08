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
plugins=(git debian vi-mode history wd deno rust bun terraform jj)

# opt out of dotnet telemetry
DOTNET_CLI_TELEMETRY_OPTOUT=true

# workaround for git_prompt_info not working inside the vcs_prompt_info function
zstyle ':omz:alpha:lib:git' async-prompt no 

source $ZSH/oh-my-zsh.sh
apt_pref='aptitude'

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

# mods completions
[ -s "/home/matt/go/bin/mods" ] && source <(/home/matt/go/bin/mods completion zsh)

# git-delta completions
[ -s "delta" ] && source <(delta --generate-completion zsh)

# bun completions
[ -s "/home/matt/.bun/_bun" ] && source "/home/matt/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="/home/matt/.bun/bin:$PATH"

# Neovim wants a TMPDIR for some reason
export TMPDIR=/tmp

# Customize to your needs...
alias la='ls -la'
alias grab='wget -nd -r -l 1 -P . -A jpeg,jpg,bmp,gif,png'
alias adu="sudo $apt_pref update && sudo $apt_pref full-upgrade" 
alias v="$EDITOR"
alias lfv="nvim -u NONE -n"
alias rgs="rg -S"
alias ts="sudo tailscale"
alias tf="terraform"
alias ip="ip --color"
alias gup="git remote update -p; git merge --ff-only @{u}"
alias gpnv="git push --no-verify"

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

if type mise &>/dev/null; then
	eval "$(mise activate zsh)"
else
	echo Mise not found. Install from https://mise.jdx.dev
fi

# eza (better `ls`)
if type eza &>/dev/null; then
  alias l="eza --icons=always --git"
  alias ls="eza --icons=always --git"
  alias ll="eza -lg --icons=always --git"
  alias llrt="eza -lg --icons=always --git --sort=newest"
  alias llss="eza -lg --icons=always --git --sort=size"
  alias la="eza -lag --icons=always --git"
  alias lart="eza -lag --icons=always --git --sort=newest"
  alias lass="eza -lag --icons=always --git --sort=size"
  alias lt="eza -lTg --icons=always --git"
  alias lt2="eza -lTg --level=2 --icons=always --git"
  alias lt3="eza -lTg --level=3 --icons=always --git"
  alias lt4="eza -lTg --level=4 --icons=always --git"
  alias lta="eza -lTag --icons=always --git"
  alias lta2="eza -lTag --level=2 --icons=always --git"
  alias lta3="eza -lTag --level=3 --icons=always --git"
  alias lta4="eza -lTag --level=4 --icons=always --git"
else
  echo ERROR: eza could not be found. Skip setting up eza aliases.
fi

if hash wl-copy 2>/dev/null; then
		alias clip='wl-copy'
		alias clippaste='wl-paste'
fi

if hash xclip 2>/dev/null; then
    alias clip='xclip -sel clip'
    alias clippaste='xclip -sel clip -o'
fi

if hash govee-control 2>/dev/null; then
    alias gov='govee-control'
    alias govb='govee-control brightness'
    alias govt='govee-control temp'
    alias govo='govee-control on'
    alias govx='govee-control off'
    alias govw='govee-control temp 2500'
    alias govc='govee-control temp 6500'
    alias govh='govee-control brightness 100'
    alias govl='govee-control brightness 10'
		alias govday='govh && govc'
		alias govnight='govl && govw'
fi

if hash notify-send 2>/dev/null; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(echo "CLI->" | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
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

autoload zmv

vcs_prompt_info() {
  local ref='self.change_id().shortest(3)'
  local empty_color="$fg[yellow]"
  local nonempty_color="$fg[magenta]"

  jj_prompt_template_raw \
		"if(self.empty(), \"(%{$empty_color%}\", \"(%{$nonempty_color%}\") ++ $ref ++ \"%{$reset_color%}) \"" \
  || git_prompt_info
}

# this is the prompt from the mh.omz-theme theme with the $HOST added
export PROMPT="[%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}@$HOST:%{$fg[red]%}%30<...<%~%<<%{$reset_color%}]%($)"
export RPROMPT='$(vcs_prompt_info)'
