# robb-j's dotfiles

These files are my dotfiles to be shared between development machines

## files

**[zshrc](./.zshrc)** - common zsh configuration, usage:

```sh
# ~/.zprofile
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES_DIR="$HOME/dev/dotfiles"
source "$DOTFILES_DIR/.zprofile"

# ~/.zshrc
source "$DOTFILES_DIR/.zshrc"
```

**[ssh_config](./ssh_config)** - ssh configuration

```conf
# ~/.ssh/config
Include ~/dev/dotfiles/ssh_config
```

**[gitconfig](./.gitconfig)** - git configuration

```toml
# ~/.gitconfig
[include]
  path = ~/dev/dotfiles/.gitconfig
```

**[blue-night](./blue-night.terminal)** - custom macOS terminal profile.
Import it in Terminal.app and export it back to apply updates.

## global commands

```sh
# Start editing the zshrc and re-source it afterwards
zshrc

# Update the dotfiles repo (if the repo is clean)
update_dotfiles
```

## helpful commands

```sh
# cd to/this/directory

# check brew dependencies
brew bundle check

# generate a new brewfile
brew bundle dump

# update from the current brewfile
brew bundle install

# uninstall dependencies not in brewfile
brew bundle cleanup

# create a defaults diff
defaults read > tmp/before.txt
  # do some changes ...
defaults read > tmp/after.txt
opendiff tmp/before.txt tmp/after.txt
```

- https://scriptingosx.com/2016/11/editing-property-lists/

## container use

```sh
# cd to/this/folder

# generate server key
ssh-keygen container/server_key

# setup authorized keys
cat ~/.ssh/id_rsa.pub > container/authorized_keys

# build and run development
./container/dev.sh

# ssh into the container
ssh -p 30022 user@0.0.0.0

# stop the container (in a new terminal)
docker ps
docker stop $CONTAINER_ID
```
