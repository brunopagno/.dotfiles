#!/bin/bash

set -e

BASE_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config"

echo "#GATO: Preparation"

echo "updating the system"
sudo apt update && sudo apt upgrade -y
echo "installing essential build tools"
sudo apt install -y build-essential
echo "installing dependencies"
sudo apt install -y libssl-dev libyaml-dev zlib1g-dev
echo "installing utilities"
sudo apt install -y git gpg fzf wget curl ripgrep wl-clipboard tmux
echo "installing apps"
snap install neovim alacritty

# -----------------------------

echo "#GATO: Symlinking config folders"

declare -a SYMLINKS=("nvim" "alacritty" "tmux")

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

gsettings set org.gnome.shell.weather locations "[<(uint32 2, <('Berlin', 'EDDB', true, [(0.91426163401859872, 0.23591034304566436)], [(0.91658875132345297, 0.23387411976724018)])>)>]"
gsettings set org.gnome.shell.world-clocks locations "[<(uint32 2, <('London', 'EGWU', true, [(0.89971722940307675, -0.007272211034407213)], [(0.89884456477707964, -0.0020362232784242244)])>)>, <(uint32 2, <('Porto Alegre', 'SBCO', true, [(-0.52388966962472883, -0.89389947104752665)], [(-0.52418054619786614, -0.89360857702109675)])>)>, <(uint32 2, <('Helsinki', 'EFHK', true, [(1.0527244329790106, 0.43575054239901517)], [(1.0502615814182288, 0.43518331039211688)])>)>, <(uint32 2, <('Toronto', 'CYTZ', true, [(0.76154532446909495, -1.3857914260834978)], [(0.76212711252195475, -1.3860823201099277)])>)>]"
gsettings set org.gnome.desktop.calendar show-weekdate true

echo "set shortcuts"
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Super>Up']"

# ----------------------------

echo "#GATO: Configuring git"

git config --global init.defaultBranch main
git config --global pager.branch false
git config --global credential.helper store
git config --global pull.rebase true
git config --global commit.gpgsign true

# ----------------------------

echo "#GATO: Installing JetBrains Mono Nerd Font"

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
FONT_TARGET="$HOME/.local/share/fonts/JetBrainsMono"
TMP_DIR=$(mktemp -d)

if [ ! -d "$FONT_TARGET" ]; then
  mkdir -p "$FONT_TARGET"
  
  if curl -fL "$FONT_URL" -o "$TMP_DIR/JetBrainsMono.tar.xz"; then
    tar -xf "$TMP_DIR/JetBrainsMono.tar.xz" -C "$FONT_TARGET"
    fc-cache -fv
    echo "Font installed successfully"
  else
    echo "Failed to download font"
  fi
else
  echo "already installed... skipping"
fi

rm -rf "$TMP_DIR"

# ----------------------------

echo "#GATO: Installing lazygit"

if ! command -v lazygit &>/dev/null; then
  cd /tmp
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -D -t /usr/local/bin/
  rm lazygit.tar.gz lazygit
  cd -
else
  echo "already installed... skipping"
fi

# ----------------------------

echo "#GATO: Installing mise"

if ! command -v mise &>/dev/null; then
  sudo install -dm 755 /etc/apt/keyrings
  wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
  sudo apt update
  sudo apt install -y mise
else
  echo "already installed... skipping"
fi

# ----------------------------

echo "#GATO: Installing docker"

if ! command -v docker &>/dev/null; then
  sudo apt install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update
  
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker $USER
else
  echo "already installed... skipping"
fi
