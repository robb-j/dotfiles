# Path to your oh-my-zsh installation.
export ZSH=${ZSH:-"/Users/rob/.oh-my-zsh"}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  kubectl
  kube-ps1
)

source $ZSH/oh-my-zsh.sh

#
# User configuration
#

alias dc='docker-compose'
alias de='docker exec -it'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dce='docker-compose exec'
alias drmi='docker images -q |xargs docker rmi'
alias d1='docker run -it --rm'
alias k8s='kubectl'

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
    echo "Usage: k1 <image> <cmd>"
    return 1
  fi
  if [ -z "$2" ]; then
    echo "Usage: k1 <image> <cmd>"
    return 1
  fi
  kubectl run -it --rm "k1-$1-$2" --generator=run-pod/v1 --image -- $@
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
alias zshrc='nano ~/.zshrc && source ~/.zshrc'


# Run an npm command queitly and pass args to node not npm
alias npr='npm run -s --'


# Use experimental buildkit docker builder (for multi-arch builds)
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

# Restart macOS's DNS
alias reset_dns='sudo killall -HUP mDNSResponder; sleep 2;'


# Use nano to edit files from kubectl
export KUBE_EDITOR=nano


# Configure kube-ps1
KUBE_PS1_PREFIX="["
KUBE_PS1_SUFFIX="] "
KUBE_PS1_SYMBOL_DEFAULT=
KUBE_PS1_SEPARATOR=
PROMPT=$PROMPT'$(kube_ps1)'
kubeoff


# Better key bindings
# https://github.com/ohmyzsh/ohmyzsh/issues/7609
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word


# Lazy NVM
# -> https://til-engineering.nulogy.com/Slow-Terminal-Startup-Tip-Lazy-Load-NVM/
lazynvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm() {
  lazynvm 
  nvm $@
}
 
node() {
  lazynvm
  node $@
}
 
npm() {
  lazynvm
  npm $@
}

npx() {
  lazynvm
  npx $@
}