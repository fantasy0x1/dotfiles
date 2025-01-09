# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$(pyenv root)/shims:/opt/homebrew/bin/:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export PS1='%n@%m:%F{cyan}%~%f$ '
export EDITOR='vim'

source $ZSH/oh-my-zsh.sh
