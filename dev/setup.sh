#!/bin/bash

link_config() {
  local config_name="$1"
  local config_path="$(pwd)/$config_name"
  local target_dir="$HOME/.config/$config_name"

  if [ -d "$target_dir" ]; then
    echo "skipping $config_name, already exists"
  else
    echo "linking $config_name"
    ln -s "$config_path" "$HOME/.config"
  fi
}

echo "setting up configuration files for nvim"
echo "... this setup does not install any software, only links configuration"

link_config "nvim"

echo "setup complete"

