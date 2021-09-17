# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew history tmux gpg-agent lein fasd docker-compose docker git-prompt z)

eval "$(/opt/homebrew/bin/brew shellenv)"

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:~/.bin
export JAVA_HOME=$(/usr/libexec/java_home 2> /dev/null)

# Clear
zsh_clear() { command clear; zle redisplay; }
zle -N zsh_clear

# Vim
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins '^@' zsh_clear

# Shortcuts
alias rma='rm *'

# sshto
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LEIN_FAST_TRAMPOLINE=1

# istheinternetonfire
if [ $[$RANDOM % 100] -lt 10 ]; then
    host -t txt istheinternetonfire.com | cut -f 2 -d '"' | cowsay -f moose
fi

## Prompt
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    echo '$';
}

PROMPT='%n:%{$fg[yellow]%}$(collapse_pwd)%{$reset_color%}$(git_super_status) $(prompt_char) '
RPROMPT=""
ZSH_THEME_GIT_PROMPT_PREFIX=" on "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" ∆ "
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[yellow]%}%{●%G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[green]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND=" %{$fg[red]%}%{↓%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg[blue]%}%{↑%G%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$fg[gray]%}%{⧖%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"

# tmux
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tmux attach 2> /dev/null || tmux new-session -s ft;
  fi
}

ensure_tmux_is_running

## Command Line Edit
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

## Vim
alias vim=nvim
export EDITOR=nvim
export VISUAL=nvim

## NVM
NVM_INIT="/usr/local/opt/nvm/nvm.sh"
loadNvm() { source "$NVM_INIT" }

if [ -s "$NVM_INIT" ]; then
  export NVM_DIR="$HOME/.nvm"
  alias nvm='unalias nvm node npm && loadNvm && nvm'
  alias node='unalias nvm node npm && loadNvm && node'
  alias npm='unalias nvm node npm && loadNvm && npm'
  alias aws-azure-login='unalias nvm node npm && loadNvm && aws-azure-login'
fi

## Clojure
alias iced="iced repl with-profile +iced,+kaocha"

## Path

export PATH="$HOME/.yarn/bin:$HOME/.cargo/bin:$PATH:$HOME/.vim/plugged/vim-iced/bin"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
