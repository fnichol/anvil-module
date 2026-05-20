#!/usr/bin/env sh
# shellcheck disable=SC3043

# shellcheck source=/dev/null
. "$ANVIL_HOOK_SUPPORT"

configure_hook_macos_defaults() {
  if [ "$ANVIL_OS" != "macos" ]; then
    return 0
  fi

  _defaults_write \
    "Enable screen saver hot corner (bottom left)" \
    com.apple.dock wvous-bl-corner -int 5

  _defaults_write \
    "Disable screen saver hot corner (top right)" \
    com.apple.dock wvous-tr-corner -int 6

  _defaults_write \
    "Automatically show and hide the Dock" \
    com.apple.dock autohide -bool true

  _defaults_write \
    "Remove the Dock autohide animation" \
    com.apple.dock autohide-time-modifier -float 0

  _defaults_write \
    "Set icon size of Dock images" \
    com.apple.dock tilesize -int 34

  _defaults_write \
    "Set large icon size of Dock images" \
    com.apple.dock largesize -float 44

  _defaults_write \
    "Enable Dock magnification" \
    com.apple.dock magnification -bool true

  _defaults_write \
    "Disable recent apps in the Dock" \
    com.apple.dock show-recents -bool false

  _defaults_write \
    "Disable press-and-hold for keys in favor of key repeat" \
    NSGlobalDomain ApplePressAndHoldEnabled -bool false

  _defaults_write \
    "Set a blazingly fast keyboard repeat rate (1/2)" \
    NSGlobalDomain KeyRepeat -int 1

  _defaults_write \
    "Set a blazingly fast keyboard repeat rate (2/2)" \
    NSGlobalDomain InitialKeyRepeat -int 10

  _defaults_write \
    "Enable full keyboard access for all controls" \
    NSGlobalDomain AppleKeyboardUIMode -int 3

  _defaults_write \
    "Disable annoying UI error sounds (1/3)" \
    com.apple.systemsound com.apple.sound.beep.volume -int 0

  _defaults_write \
    "Disable annoying UI error sounds (2/3)" \
    com.apple.sound.beep feedback -int 0

  _defaults_write \
    "Disable annoying UI error sounds (3/3)" \
    com.apple.systemsound com.apple.sound.uiaudio.enabled -int 0

  _defaults_write \
    "Set the menu bar date format (1/7)" \
    com.apple.menuextra.clock DateFormat -string "\"HH:mm:ss\""

  _defaults_write \
    "Set the menu bar date format (2/7)" \
    com.apple.menuextra.clock FlashDateSeparators -bool false

  _defaults_write \
    "Set the menu bar date format (3/7)" \
    com.apple.menuextra.clock IsAnalog -bool false

  _defaults_write \
    "Set the menu bar date format (4/7)" \
    com.apple.menuextra.clock ShowAMPM -bool false

  _defaults_write \
    "Set the menu bar date format (5/7)" \
    com.apple.menuextra.clock Show24Hour -bool true

  _defaults_write \
    "Set the menu bar date format (6/7)" \
    com.apple.menuextra.clock ShowSeconds -bool true

  _defaults_write \
    "Set the menu bar date format (7/7)" \
    com.apple.menuextra.clock ShowDayOfWeek -bool false

  _defaults_write \
    "Announce time on the hour" \
    com.apple.speech.synthesis.general.prefs \
    TimeAnnouncementPrefs -dict \
    TimeAnnouncementsEnabled -bool true \
    TimeAnnouncementsIntervalIdentifier -string "EveryHourInterval" \
    TimeAnnouncementsPhraseIdentifier -string "ShortTime"

  _defaults_write \
    "Save to disk (not to iCloud) by default" \
    NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  _defaults_write \
    "Expand Save panel by default (1/2)" \
    NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

  _defaults_write \
    "Expand Save panel by default (2/2)" \
    NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

  _defaults_write \
    "Expand Print panel by default (1/2)" \
    NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

  _defaults_write \
    "Expand Print panel by default (2/2)" \
    NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  _defaults_write \
    "Save screenshots to the desktop" \
    com.apple.screencapture location -string "\$HOME/Desktop"

  _defaults_write \
    "Save screenshots in PNG format" \
    com.apple.screencapture type -string "png"

  _defaults_write \
    "Disable shadow in screenshots" \
    com.apple.screencapture disable-shadow -bool true

  _defaults_write \
    "Show all filename extensions in Finder" \
    NSGlobalDomain AppleShowAllExtensions -bool true

  _defaults_write \
    "Avoid creating .DS_Store files on network volumes" \
    com.apple.desktopservices DSDontWriteNetworkStores -bool true

  _defaults_write \
    "Avoid creating .DS_Store files on USB volumes" \
    com.apple.desktopservices DSDontWriteUSBStores -bool true

  _defaults_write \
    "Check for software updates daily" \
    com.apple.SoftwareUpdate ScheduleFrequency -int 1

  _defaults_write \
    "Show icons for external hard drives on the Desktop" \
    com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

  _defaults_write \
    "Show icons for servers on the Desktop" \
    com.apple.finder ShowMountedServersOnDesktop -bool true

  _defaults_write \
    "Show icons for removable media on the Desktop" \
    com.apple.finder ShowRemovableMediaOnDesktop -bool true

  _defaults_write \
    "Show Finder status bar" \
    com.apple.finder ShowStatusBar -bool true

  _defaults_write \
    "Disable warning when changing a file extension" \
    com.apple.finder FXEnableExtensionChangeWarning -bool false

  _defaults_write \
    "Use list view in all Finder windows by default" \
    com.apple.finder FXPreferredViewStyle -string "Nlsv"

  _defaults_write \
    "Empty trash securely by default" \
    com.apple.finder EmptyTrashSecurely -bool true

  _defaults_write \
    "Disable crash reporter." \
    com.apple.CrashReporter DialogType none

  _defaults_write \
    "Disable smart dashes" \
    NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

  _defaults_write \
    "Remove animation for switching between spaces" \
    com.apple.Accessibility ReduceMotionEnabled -int 1

  _defaults_write \
    "Disable rearranging of spaces" \
    com.apple.dock mru-spaces -int 0
}

_defaults_write() {
  local msg="$1"
  shift
  local domain="$1"
  shift
  local key="$1"
  shift

  if ! defaults read "$domain" "$key" >/dev/null 2>&1; then
    info "$msg"
  fi
  defaults write "$domain" "$key" "$@"
}
