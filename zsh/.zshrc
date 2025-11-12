# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Exports
export EDITOR="nvim"
export VISUAL="nvim"
export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"


# Init programs
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"

# Plugins
zinit light zsh-users/zsh-completions
source ~/.config/zsh/zsh-syntax-highlighting.zsh
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Load completions
autoload -Uz compinit && compinit -C

# Keybindings
bindkey -v
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion behaviour
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# Aliases
alias upgrade='sudo nala update && sudo nala upgrade -y'
alias clean='sudo nala autoremove && sudo nala clean && sudo nala autopurge'
alias myip='curl http://ipecho.net/plain; echo'
alias ls='eza --icons --group-directories-first --color=always'
alias lsl='ls -l'
alias lsa='ls -a'
alias lst='lsa --tree'
alias cd='z'
alias neofetch='fastfetch'
alias src='source ~/.zshrc'

# Startup commands
if [[ $- == *i* ]]; then
  fastfetch
fi


# Compile zsh files for faster load
autoload -Uz zrecompile
if [[ ! -f ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zrecompile -pq ~/.zshrc
fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
