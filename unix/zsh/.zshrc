# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

export TERM=xterm-256color

export ZSH=$HOME/.zsh

# Load and initialise completion system
autoload -Uz compinit && compinit

# Determine OS and source the appropriate config file
case "$(uname)" in
  Darwin)
    . "$ZSH/config-osx.zsh"
    ;;
  Linux)
    . "$ZSH/config-linux.zsh"
    ;;
  *)
    . "$ZSH/config-windows.zsh"
    ;;
esac




# Check if local configuration file exists and source it
LOCAL_CONFIG="$ZSH/config-local.zsh"
[[ -f $LOCAL_CONFIG ]] && source $LOCAL_CONFIG

# Import module function from fish, need to convert to zsh equivalent
# source ~/.config/fish/custom_functions/copy_to_clipboard.fish
# This will need to be converted or rewritten for zsh.

# Set neovim as default editor
export EDITOR=nvim

# NodeJS
export TERM=xterm-256color

# Update PATH
export PATH=~/bin:~/.local/bin:$HOME/.rbenv/bin:$ANDROID_HOME/cmdline-tools/tools:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/cmdline-tools/tools/lib:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:~/miniconda3/bin:$HOME/go/bin:~/.cargo/bin:node_modules/.bin:~/personal_scripts:$PATH

# NVM
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc


# For conda, initialize in zsh like so:
if [[ -f $HOME/miniconda3/bin/conda ]]; then
  eval "$($HOME/miniconda3/bin/conda 'shell.zsh' 'hook')"
fi

# Keybindings, for vi-mode you can set in zsh directly
bindkey -v

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/personal_scripts/:$PATH"

export PATH=$HOME/bin:$PATH


# Plugins 
[[ -f $ZSH/aliases.zsh ]] && source $ZSH/aliases.zsh
[[ -f "$ZSH/functions.zsh" ]] && source "$ZSH/functions.zsh"
[[ -f $ZSH/plugins.zsh ]] && source $ZSH/plugins.zsh
