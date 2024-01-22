#!/usr/bin/env zsh

MAC_VARIANT="${MAC_VARIANT:-Personal}"

if ! $(which brew > /dev/null)
then
  echo "install: Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "skip: oh-my-zsh"
fi

if [ ! -d $ZSH ]
then
  echo "install: oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "skip: oh-my-zsh"
fi

echo
echo
echo "=== Homebrew packages ==="
brew bundle install

echo
echo
echo "=== App configuration ==="

# Dock
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "mineffect" -string "genie"
defaults write com.apple.dock "magnification" -bool "true"
defaults write com.apple.dock "tilesize" -int 50
defaults write com.apple.dock "largesize" -int 60
defaults write com.apple.dock "mru-spaces" -int 0
killall Dock

# WindowManager
defaults write com.apple.WindowManager "EnableStandardClickToShowDesktop" -bool false
defaults write -g "com.apple.trackpad.scaling" "1"
defaults write -g "AppleActionOnDoubleClick" -string Minimize
defaults write -g "AppleShowAllExtensions" -int 1
defaults write -g "AppleInterfaceStyleSwitchesAutomatically" 1 # doesn't update
killall WindowManager

# Finder
# This whole bit might just be overkill
mkdir -p tmp
F=tmp/finder.xml
defaults export com.apple.Finder $F
plutil -replace DesktopViewSettings.IconViewSettings.arrangeBy -string kind $F
plutil -replace DesktopViewSettings.IconViewSettings.iconSize -integer 128 $F
plutil -replace StandardViewSettings.ListViewSettings.iconSize -integer 32 $F
plutil -replace StandardViewSettings.ListViewSettings.textSize -integer 14 $F
plutil -replace StandardViewSettings.ExtendedListViewSettingsV2.iconSize -integer 32 $F
plutil -replace StandardViewSettings.ExtendedListViewSettingsV2.textSize -integer 14 $F
plutil -replace ICloudViewSettings.ExtendedListViewSettingsV2.iconSize -integer 32 $F
plutil -replace ICloudViewSettings.ExtendedListViewSettingsV2.textSize -integer 14 $F
plutil -replace FXDefaultSearchScope -string SCcf $F
plutil -replace FXEnableExtensionChangeWarning -integer 0 $F
plutil -replace FXEnableRemoveFromICloudDriveWarning -integer 0 $F
plutil -replace FXRemoveOldTrashItems -integer 1 $F
plutil -replace ShowRecentTags -integer 0 $F
plutil -replace SidebarDevicesSectionDisclosedState -integer 0 $F
defaults import com.apple.Finder tmp/finder.xml
killall Finder

if [[ "$MAC_VARIANT" == "OpenLab" ]]
then
  defaults write -g AppleAccentColor -int 1
else
  defaults write -g AppleAccentColor -int 3
fi

# Nova
echo "- Nova"
defaults write com.panic.Nova ExtensionsDeveloperEnabled -bool "true"
defaults write com.panic.Nova ShowSourceControlInlineBlame -bool "false"
defaults write com.panic.Nova TerminalUseOptionAsMeta -bool "true"
defaults write com.panic.Nova FontName "BerkeleyMonoVariable-Regular"
defaults write com.panic.Nova FontSize 15
defaults write com.panic.Nova DefaultSyntaxMode markdown
defaults write com.panic.Nova ExtendContentBeyondLastLine 3
defaults write com.panic.Nova IndentationStyle 0
defaults write com.panic.Nova ShowColorPreviewsInGutter -bool "false"
defaults write com.panic.Nova ShowHiddenFiles -bool "true"
defaults write com.panic.Nova ShowIgnoredFiles -bool "true"
defaults write com.panic.Nova ShowWrapGuide -bool "true"
defaults write com.panic.Nova TabWidth -integer 2
defaults write com.panic.Nova TerminalFontName "BerkeleyMonoVariable-Regular"
defaults write com.panic.Nova TerminalFontSize -integer 14
defaults write com.panic.Nova TerminalUseGPUAcceleration -boolean "true"
defaults write com.panic.Nova TerminalUseOptionAsMeta -boolean "true"
defaults write com.panic.Nova WelcomeAutomaticallyAddRecentProjects -boolean "false"

# Music
defaults write com.apple.Music dontWarnAboutRequiringExternalHardware -boolean "true"
defaults write com.apple.Music losslessEnabled -integer 1
defaults write com.apple.Music preferredDownloadAudioQuality -integer 20
defaults write com.apple.Music preferredStreamPlaybackAudioQuality -integer 15
defaults write com.apple.Music userWantsPlaybackNotifications -boolean "false"

# Sleeve
write com.replay.sleeve displayDockIcon -bool false

# ...
