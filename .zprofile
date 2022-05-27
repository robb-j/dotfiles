#
# fnm
#
if [ -x `which fnm` ]
then
  eval "`fnm env --shell=zsh --use-on-cd`"
fi

#
# go
#
if [ -x `which go` ]
then
  # https://golang.org/doc/gopath_code#GOPATH
  export PATH=$PATH:$(go env GOPATH)/bin
fi

