#!/bin/bash

set -e

BASE_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config"

echo "#GATO: Preparation"

echo "updating the system"
sudo pacman -Syu
echo "installing utilities"
sudo pacman -S git gpg fzf wget curl ripgrep wl-clipboard
echo "installing fonts"
sudo pacman -S ttf-jetbrains-mono-nerd 
echo "install apps"
sudo pacman -S tmux neovim ghostty lazygit mise
echo "install docker"
sudo pacman -S docker docker-compose
echo "install gnome and tools"
sudo pacman -S gdm gnome
sudo pacman -S bluez fprintd power-profiles-daemon
systemctl enable gdm

# -----------------------------

echo "#GATO: Symlinking config folders"

declare -a SYMLINKS=("nvim" "ghostty" "tmux")

for folder in "${SYMLINKS[@]}"; do
  TARGET="$CONFIG_DIR/$folder"
  SOURCE="$BASE_DIR/$folder"

  if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
    echo "Skipping $TARGET (already exists)"
  else
    ln -s "$SOURCE" "$TARGET"
    echo "Symlinked $SOURCE -> $TARGET"
  fi
done

# -----------------------------

echo "#GATO: Copying .bashrc"

BASHRC_SOURCE="$BASE_DIR/.bashrc"
BASHRC_TARGET="$HOME/.bashrc"

[ -e "$BASHRC_TARGET" ] && cp "$BASHRC_TARGET" "$BASHRC_TARGET.old"

cp "$BASHRC_SOURCE" "$BASHRC_TARGET"
echo "Copied .bashrc to $BASHRC_TARGET"

# -----------------------------

echo "#GATO: Configuring gnome settings"

echo "set config"
gsettings set org.gnome.desktop.peripherals.keyboard delay 360
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25

gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
gsettings set org.gnome.desktop.peripherals.mouse speed 0.25

gsettings set org.gnome.mutter check-alive-timeout 20000

gsettings set org.gnome.desktop.calendar show-weekdate true

# ----------------------------

echo "#GATO: Configuring git"

git config --global init.defaultBranch main
git config --global pager.branch false
git config --global credential.helper store
git config --global pull.rebase true
git config --global commit.gpgsign true

