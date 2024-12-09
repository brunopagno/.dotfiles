#!/bin/sh

if [[ $# -eq 0 ]] then
  echo "Usage: 'gato <command> <options>'"
  echo ""
  echo "gato link <folder_name> # creates a symlink to the ~/.config folder"
  echo "gato gnome # sets default gnome settings"
  echo "gato git # sets default git settings"
  echo ""
  exit 1
fi

# lib
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


# command handling
command=$1

case $command in
  "link")
    if [[ -z "$2" ]] then
      echo "Usage: 'gato link <folder_name>"
      exit 1
    fi

    link_config $2
    ;;

  "gnome")
    echo "set keyboard repeat speeds"
    gsettings set org.gnome.desktop.peripherals.keyboard delay 360
    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25
 
    echo "set mouse accel and speed"
    gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
    gsettings set org.gnome.desktop.peripherals.mouse speed 0.25
    
    echo "set console settings"
    gsettings set org.gnome.Console use-system-font false
    gsettings set org.gnome.Console custom-font 'JetBrainsMonoNL Nerd Font Mono 12'

    echo "set other gnome settings"
    gsettings set org.gnome.mutter check-alive-timeout 20000
    gsettings set org.gnome.desktop.interface enable-hot-corners false
    gsettings set org.gnome.shell.app-switcher current-workspace-only true

    echo "done"
    ;;

  "git")
    echo "setting up git config"
    git config --global init.defaultBranch main
    git config --global pager.branch false
    git config --global credential.helper store
    git config --global pull.rebase true
    git config --global commit.gpgsign true
    echo "all done"
    ;;
esac

