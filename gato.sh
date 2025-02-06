#!/bin/bash

set -e

BASE_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config"

echo "Preparation..."

echo "updating the system"
sudo apt update && sudo apt upgrade -y
echo "installing essential build tools"
sudo apt install -y build-essential
echo "installing dependencies"
sudo apt install -y libssl-dev libyaml-dev zlib1g-dev
echo "installing utilities"
sudo apt install -y git ripgrep wl-clipboard fzf wget curl
echo "installing apps"
snap install neovim ghostty

echo "Preparation finished"

# -----------------------------

echo "Symlinking config folders"

declare -a SYMLINKS=("nvim", "ghostty")

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

echo "Symlinking finished"

# -----------------------------

echo "Copying .bashrc"

BASHRC_SOURCE="$BASE_DIR/.bashrc"
BASHRC_TARGET="$HOME/.bashrc"

if [ -f "$HOME/.bashrc" ]; then
  cat "$BASHRC_SOURCE" >> "$BASHRC_TARGET"
  echo "Appended .bashrc to existing $BASHRC_TARGET"
else
  cp "$BASHRC_SOURCE" "$BASHRC_TARGET"
  echo "Copied .bashrc to $BASHRC_TARGET"
fi

echo "Copy finished"

# -----------------------------

echo "Configuring gnome settings"

echo "set keyboard repeat speeds"
gsettings set org.gnome.desktop.peripherals.keyboard delay 360
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25

echo "set mouse accel and speed"
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
gsettings set org.gnome.desktop.peripherals.mouse speed 0.25

echo "set check alive timeout"
gsettings set org.gnome.mutter check-alive-timeout 20000

echo "set weather location"
gsettings set org.gnome.shell.weather locations "[<(uint32 2, <('Berlin', 'EDDB', true, [(0.91426163401859872, 0.23591034304566436)], [(0.91658875132345297, 0.23387411976724018)])>)>]"

echo "set world clock locations"
gsettings set org.gnome.shell.world-clocks locations "[<(uint32 2, <('London', 'EGWU', true, [(0.89971722940307675, -0.007272211034407213)], [(0.89884456477707964, -0.0020362232784242244)])>)>, <(uint32 2, <('Porto Alegre', 'SBCO', true, [(-0.52388966962472883, -0.89389947104752665)], [(-0.52418054619786614, -0.89360857702109675)])>)>, <(uint32 2, <('Helsinki', 'EFHK', true, [(1.0527244329790106, 0.43575054239901517)], [(1.0502615814182288, 0.43518331039211688)])>)>, <(uint32 2, <('Toronto', 'CYTZ', true, [(0.76154532446909495, -1.3857914260834978)], [(0.76212711252195475, -1.3860823201099277)])>)>]"

echo "Configuring finished"

# ----------------------------

echo "Configuring git"

git config --global init.defaultBranch main
git config --global pager.branch false
git config --global credential.helper store
git config --global pull.rebase true
git config --global commit.gpgsign true

echo "Configuring finished"

# ----------------------------

echo "Installing fzf directly from git to get latest version"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installation finished

# ----------------------------

echo "Installing JetBrains Mono Nerd Font"

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
FONT_TARGET="$HOME/.local/share/fonts/JetBrainsMono"
TMP_DIR=$(mktemp -d)

mkdir -p "$FONT_TARGET"

if curl -fL "$FONT_URL" -o "$TMP_DIR/JetBrainsMono.tar.xz"; then
  tar -xf "$TMP_DIR/JetBrainsMono.tar.xz" -C "$FONT_TARGET"
  fc-cache -fv
  echo "Font installed successfully"
else
  echo "Failed to download font"
fi

rm -rf "$TMP_DIR"

echo "Installing finished"

# ----------------------------

echo "Installing mise"

sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt install -y mise

echo "Installing finished"

