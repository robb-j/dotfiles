# robb-j's dotfiles

These files are my dotfiles to be shared between dev machines

## files

**[zshrc](./.zshrc)** - common zsh configuration.
Set $ZSH in `~/.zshrc` and source this file.

**[blue-night](./blue-night.terminal)** - custom macOS terminal profile.
Import it in Terminal.app and export it back to apply updates.

## ideas / future work

**commands to sync up/down this config**

```bash
sync_up() {
  cd $DOTFILES_DIR
  # - Fail if git is behind
  # - Fail if uncommited changes

  # Get the current directory
  brew taps > brew.taps
  brew list > brew.apps

  # Commit & push to git
}

sync_down() {
  cd $DOTFILES_DIR

  # Pull from git
  git pull

  # Make sure the same things are tapped
  for TAP in `cat "$DOTFILES_DIR/brew.taps"`
  do
    brew tap $TAP
  done

  # Make sure the same apps are installed
  for APP in `cat "$DOTFILES_DIR/brew.apps"`
  do
    brew install $APP
  done
}
```
