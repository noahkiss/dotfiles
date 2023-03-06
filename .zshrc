# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

# POWERLEVEL9K_MODE="nerdfont_complete"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=1
ENABLE_CORRECTION="true" # for commands
COMPLETION_WAITING_DOTS="true" # red dots while waiting
HIST_STAMPS="yyyy-mm-dd"

# env variables for plugins
# ...

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  git
  asdf
  # zsh-syntax-highlighting
  # zsh-autosuggestions
  # safe-paste
  # extract
  # cp
  # copyfile
  # copydir
  # colorize
  # colored-man-pages
  # pj
  # gitignore
  # jake-node
  # python
  # common-aliases
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code'
fi

# Pyenv (if using)
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Custom aliases
alias zshconfig="code ~/.zshrc"
alias reload="source ~/.zshrc"

alias cat="bat"

alias git-remove-untracked="git fetch -p && git branch -v | grep -F '[gone]' | awk '{print $1}' | xargs git branch -D"
alias cleanup="git fetch --prune origin && git remote prune origin && git-remove-untracked"

if [[ -v VSCODE_WS ]] && [[ "$VSCODE_WS" != '${workspaceFolder}' ]]; then
    alias cd="HOME=\"${VSCODE_WS}\" cd"
fi

# --- start Better LS ---
# modified from https://www.topbug.net/blog/2016/11/28/a-better-ls-command/
# created for macOS / zsh

# if eval "$(dircolors 2>/dev/null)"; then
#   eval "$(gdircolors)"
# fi

# export COLUMNS  # Remember columns for subprocesses.

# unset -f ls gls
# unalias ls
# function ls {
#   if [ $# -gt 1 ]; then
#     # usage: ls [dir] [search term]
#     # ex. ls ~/Desktop pdf
#     # will show all files containing PDF
#     command gls -Flagh --color=always -v --author --time-style=long-iso "$1" | grep -i "$2" | less -R -X -F
#   else
#     # any other number of inputs will just act normally
#     command gls -Flagh --color=always -v --author --time-style=long-iso "$@" | less -R -X -F
#   fi
# }

# try exa instead
unset -f ls gls 2>/dev/null
unalias ls
function ls {
  if [ $# -gt 1 ]; then
    # usage: ls [dir] [search term]
    # ex. ls ~/Desktop pdf
    # will show all files containing PDF
    command exa -FahT --icons --no-filesize --no-user --no-permissions --ignore-glob=.git --level=2 --time-style=long-iso "$1" | grep -i "$2" | less -R -X -F
  elif [[ $# = 1 && $1 = "l" ]]; then
    command exa -FlahT --git --icons --level=2 --time-style=long-iso
  else
    # any other number of inputs will just act normally
    command exa -FahT --level=2 "$@" | less -R -X -F
  fi
}
# ---  end Better LS  ---

function github {
  if [ $# -eq 0 ]; then
    >&2 echo "Please supply a dirname, ex. 'github .' or 'github [dirname]'"
    exit 1
  fi

  echo "Not implemented"
  # gh repo create monsters-data --private --source . --push
}
