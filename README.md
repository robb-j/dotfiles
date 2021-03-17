# robb-j's dotfiles

These files are my dotfiles to be shared between development machines

## files

**[zshrc](./.zshrc)** - common zsh configuration.
Set $ZSH & $DOTFILES_DIR in `~/.zshrc` and source this file.

**[blue-night](./blue-night.terminal)** - custom macOS terminal profile.
Import it in Terminal.app and export it back to apply updates.

## global commands

```bash
# Start editing the zshrc and re-source it afterwards
zshrc

# Update the dotfiles repo (if the repo is clean)
update_dotfiles
```

## helpful commands

```bash
# cd to/this/directory

# check brew dependencies
brew bundle check

# generate a new brewfile
brew bundle dump

# update from the current brewfile
brew bundle install

# uninstall dependencies not in brewfile
brew bundle cleanup
```
