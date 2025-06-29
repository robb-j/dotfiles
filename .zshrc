# Path to your oh-my-zsh installation.
export ZSH=${ZSH:-"/Users/rob/.oh-my-zsh"}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export ZSH_THEME=${ZSH_THEME:-"nicoulaj"}

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  kubectl
  kube-ps1
  node
  npm
)

source $ZSH/oh-my-zsh.sh

#
# User configuration
#

alias dc='docker compose'
alias de='docker exec -it'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dce='docker compose exec'
alias drmi='docker images -q |xargs docker rmi'
alias d1='docker run -it --rm'
alias k='kubectl'

# start/stop Docker
alias dup='open /Applications/Docker.app'
alias ddown='killall Docker'

# Start an nginx container and mount a relative folder into it
function nginx() {
  if [ -z "$1" ]; then
    echo "Usage: nginx some/relative/folder"
    return 1
  fi
  docker run -it --rm -p 8080:80 -v "`pwd`/$1:/usr/share/nginx/html" nginx:1-alpine
}


# Create a Kubernetes pod and run a command in it
function k1() {
  if [ -z "$1" ]; then
    echo "Usage: k1 <image> [cmd]"
    return 1
  fi
  name=`date | openssl sha256 | cut -c 1-8`
  kubectl run -it --rm "k1-$name" --restart=Never --image=$1 -- ${@:2}
}


# Generate a random string
function random() {
  openssl rand -hex 16
}


# Start an ssh SOCKs v5 proxy agains a host
# usage:
#   $ ssh-socks-proxy somedomain.io
function ssh_socks_proxy() {
  ssh -ND 8080 $1
}


# Ignore commands which start with a space from .xsh_history
setopt HIST_IGNORE_SPACE


# Open zshrc for editing, then apply the changes
zshrc() {
  nano "$DOTFILES_DIR/.zshrc"
  echo "Reloading ..."
  source "$DOTFILES_DIR/.zshrc"
}

# Update dotfiles from git
update_dotfiles() {
  START_DIR=`pwd`
  
  # go into the dotfiles dir if we aren't already there 
  if [ "$START_DIR" != "$DOTFILES_DIR" ]; then
    pushd $DOTFILES_DIR > /dev/null
  fi
  
  # See how git is doing
  STATUS=`git status --porcelain`
  
  # If git is clean, pull and check the bundle
  # Otherwise, output the status
  if [ -z "$STATUS" ]
  then
    git pull origin main
    brew bundle install
  else
    echo "$DOTFILES_DIR is not clean:"
    echo "$STATUS"
  fi
  
  # exit the dotfiles dir if we aren't there originally
  if [ "$START_DIR" != "$DOTFILES_DIR" ]; then
    popd > /dev/null
  fi
}

alias p1='docker run -it --rm -p 5432:5432 -e POSTGRES_USER=user -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=user postgres:12-alpine'

# Run an npm command queitly and pass args to node not npm
alias npr='npm run -s --'


# Restart macOS's DNS
alias reset_dns='sudo killall -HUP mDNSResponder; sleep 2;'


# Generate a secure secret
alias secret="node -e 'console.log(crypto.randomUUID())'"


# Use nano to edit files from kubectl
export KUBE_EDITOR=nano


# Configure kube-ps1
KUBE_PS1_PREFIX=""
KUBE_PS1_SUFFIX=" "
KUBE_PS1_SYMBOL_ENABLE=false
KUBE_PS1_SEPARATOR=
KUBE_PS1_CTX_COLOR=blue
KUBE_PS1_NS_COLOR=cyan
PROMPT='$(kube_ps1)'$PROMPT


# Better key bindings
# https://github.com/ohmyzsh/ohmyzsh/issues/7609
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word


#
# Add PlatformIO to the path
#
export PATH="${PATH}:${HOME}/.platformio/penv/bin"

#
# krew
#
export PATH="${PATH}:${HOME}/.krew/bin"

# 
# Python 3
# 
export PATH="${PATH}:${HOME}/Library/Python/3.11/bin"

# 
# Rust
# 
if type rustup &>/dev/null
then
  export PATH="$(brew --prefix)/opt/rustup/bin:$PATH"
  export PATH="${PATH}:${HOME}/.cargo/bin"
  FPATH="${FPATH}:$(brew --prefix)/opt/rustup/share/zsh/site-functions"
fi

#
# Completions
#
FPATH="${HOME}/.zsh/completions:${FPATH}"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Initialise zsh completions (originally from deno install script)
autoload -Uz compinit
compinit
