#!/bin/bash
set -e

# macOS defaults — Speed & UI optimizations for Apple Silicon
# Run once after a fresh install. Revert with: ./macos.sh revert
# Requires a restart (or at least Dock/Finder restart) to take full effect.

apply() {
  echo "=== Applying macOS optimizations ==="

  # --- Animations OFF ---
  defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
  defaults write -g QLPanelAnimationDuration -float 0
  defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
  defaults write com.apple.finder DisableAllAnimations -bool true
  defaults write com.apple.dock launchanim -bool false
  defaults write com.apple.dock expose-animation-duration -float 0.1
  defaults write com.apple.dock autohide-time-modifier -float 0
  defaults write com.apple.dock autohide-delay -float 0

  # --- Keyboard: ultra-fast repeat ---
  defaults write NSGlobalDomain KeyRepeat -int 1
  defaults write NSGlobalDomain InitialKeyRepeat -int 10

  # --- Finder ---
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"       # Search current folder by default
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true        # Full path in Finder title bar

  # --- Screenshots ---
  defaults write com.apple.screencapture location ~/Downloads
  defaults write com.apple.screencapture disable-shadow -bool true
  defaults write com.apple.screencapture show-thumbnail -bool false

  # --- Save/Print dialogs: expanded by default ---
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
  defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

  # --- Apply ---
  killall Dock
  killall Finder
  killall SystemUIServer

  echo ""
  echo "Done. Restart your Mac for full effect."
}

revert() {
  echo "=== Reverting macOS optimizations to defaults ==="

  # --- Animations: restore defaults ---
  defaults delete NSGlobalDomain NSAutomaticWindowAnimationsEnabled 2>/dev/null
  defaults delete -g QLPanelAnimationDuration 2>/dev/null
  defaults delete NSGlobalDomain NSWindowResizeTime 2>/dev/null
  defaults delete com.apple.finder DisableAllAnimations 2>/dev/null
  defaults delete com.apple.dock launchanim 2>/dev/null
  defaults delete com.apple.dock expose-animation-duration 2>/dev/null
  defaults delete com.apple.dock autohide-time-modifier 2>/dev/null
  defaults delete com.apple.dock autohide-delay 2>/dev/null

  # --- Keyboard: restore defaults ---
  defaults delete NSGlobalDomain KeyRepeat 2>/dev/null
  defaults delete NSGlobalDomain InitialKeyRepeat 2>/dev/null

  # --- Finder: restore defaults ---
  defaults delete com.apple.finder FXDefaultSearchScope 2>/dev/null
  defaults delete com.apple.desktopservices DSDontWriteNetworkStores 2>/dev/null
  defaults delete com.apple.desktopservices DSDontWriteUSBStores 2>/dev/null
  defaults delete com.apple.finder _FXShowPosixPathInTitle 2>/dev/null

  # --- Screenshots: restore defaults ---
  defaults write com.apple.screencapture location ~/Desktop
  defaults delete com.apple.screencapture disable-shadow 2>/dev/null
  defaults delete com.apple.screencapture show-thumbnail 2>/dev/null

  # --- Save/Print dialogs: restore defaults ---
  defaults delete NSGlobalDomain NSNavPanelExpandedStateForSaveMode 2>/dev/null
  defaults delete NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 2>/dev/null
  defaults delete NSGlobalDomain PMPrintingExpandedStateForPrint 2>/dev/null
  defaults delete NSGlobalDomain PMPrintingExpandedStateForPrint2 2>/dev/null

  # --- Apply ---
  killall Dock
  killall Finder
  killall SystemUIServer

  echo ""
  echo "Done. All settings reverted to macOS defaults. Restart for full effect."
}

case "${1:-apply}" in
  revert) revert ;;
  apply)  apply ;;
  *)      echo "Usage: $0 [apply|revert]"; exit 1 ;;
esac
