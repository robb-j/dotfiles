#!/usr/bin/env zsh

if ! $(which brew > /dev/null)
then
  echo "Please install homebrew"
  open "https://github.com/Homebrew/brew/releases/latest"
  exit 1
fi

if [ ! -d $ZSH ]
then
  echo "install: oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "skip: oh-my-zsh"
fi

echo
echo "=== Homebrew packages ==="
echo
brew bundle install

echo
echo "=== MacOS apps ==="
echo
mas install 1660931205 # Yoath
mas install 1633886387 # BrowserNow
mas install 1606145041 # Sleeve
mas install 1529448980 # Reeder 5
mas install 1594420480 # Prompt 3
mas install 1545870783 # System Color Picker
mas install 1289583905 # Pixelmator Pro
mas install 1497506650 # Yubico Authenticator
mas install 1518425043 # Boop
mas install 904280696 # Things 3
mas install 497799835 # Xcode

echo
echo "=== Third-party apps ==="
echo 
