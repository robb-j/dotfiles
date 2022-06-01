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
# Completions
#
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
