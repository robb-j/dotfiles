#
# fnm
#
if [ -x fnm ]
then
  eval "`fnm env --shell=zsh --use-on-cd`"
fi

#
# go
#
if [ -x go ]
then
  # https://golang.org/doc/gopath_code#GOPATH
  export PATH=$PATH:$(go env GOPATH)/bin
fi

# custom ssh
export PATH=$(brew --prefix openssh)/bin:$PATH
