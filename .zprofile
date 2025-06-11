#
# fnm
#
if type -p fnm > /dev/null
then
  eval "`fnm env --shell=zsh --use-on-cd`"
fi

#
# go
#
if type -p go > /dev/null
then
  # https://golang.org/doc/gopath_code#GOPATH
  export PATH=$PATH:$(go env GOPATH)/bin
fi

# 
# deno
# 
export PATH="${PATH}:${HOME}/.deno/bin"
