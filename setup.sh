#!/bin/bash

link_config() {
  local config_name="$1"
  local config_path="$(pwd)/$config_name"
  local target_dir="$HOME/.config/$config_name"

  if [ -d "$target_dir" ]; then
    echo "skipping $config_name, already exists"
  else
    echo "linking $config_name"
    ln -s "$config_path" "$HOME/.config/"
  fi
}

echo "Symlink config folders"

read -e -p "[y/N]" choice
if [[ "$choice" == [Yy]* ]] then
  link_config "alacritty"
  link_config "nvim"
fi

# --------------------

echo "Gnome things..."
 
read -e -p "[y/N]" choice
if [[ "$choice" == [Yy]* ]] then
  echo "set keyboard repeat speeds"
  gsettings set org.gnome.desktop.peripherals.keyboard delay 360
  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25
  
  echo "set workspaces and shortcuts"
  gsettings set org.gnome.mutter dynamic-workspaces false
  gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
  gsettings set org.gnome.shell.keybindings switch-to-application-1 "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
  gsettings set org.gnome.shell.keybindings switch-to-application-2 "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
  gsettings set org.gnome.shell.keybindings switch-to-application-3 "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
  gsettings set org.gnome.shell.keybindings switch-to-application-4 "[]"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
  
  echo "set other gnome settings"
  gsettings set org.gnome.mutter check-alive-timeout 20000
  gsettings set org.gnome.desktop.interface enable-hot-corners false
fi

# ------------------

echo "Git things..."

read -e -p "[y/N]" choice
if [[ "$choice" == [Yy]* ]] then
  echo "setting up git"
  git config --global init.defaultBranch main
  git config --global pager.branch false
  git config --global credential.helper store
  git config --global pull.rebase true
fi

echo "Done!"
