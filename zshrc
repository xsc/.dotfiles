# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="___ys"

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
plugins=(git homebrew history tmux gpg-agent lein fasd)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:~/.bin
export JAVA_HOME=$(/usr/libexec/java_home 2> /dev/null)

# Clear
zsh_clear() { command clear; zle redisplay; }
zle -N zsh_clear
bindkey '^@' zsh_clear

# Shortcuts
alias rma='rm *'
alias b2d='boot2docker'

# sshto
alias sshto='/git/sf/sf_scripts/sshto'
alias scp-pngs='/git/sf/sf_scripts/scp-pngs'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# move to git
GIT_REPO_PATH="/git"
function cdg() {
    local r="$1"
    if [ -z "$r" ]; then
        cd "$GIT_REPO_PATH";
    else
        cd "$(find "$GIT_REPO_PATH" -type d -path "*$r" -maxdepth 2 -mindepth 1 | head -n 1)";
    fi
}

# docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# istheinternetonfire
host -t txt istheinternetonfire.com | cut -f 2 -d '"' | cowsay -f moose
