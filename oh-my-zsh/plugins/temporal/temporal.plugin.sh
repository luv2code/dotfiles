# If Temporal is not found, don't do the rest of the script
if (( ! $+commands[temporal] )); then
  return
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `temporal`. Otherwise, compinit will have already done that.
if [[ ! -f "$ZSH_CACHE_DIR/completions/_temporal" ]]; then
  typeset -g -A _comps
  autoload -Uz _temporal
  _comps[temporal]=_temporal
fi

temporal completion zsh >| "$ZSH_CACHE_DIR/completions/_temporal" &|
