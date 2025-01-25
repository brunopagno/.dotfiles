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
    
    echo "set check alive timeout"
    gsettings set org.gnome.mutter check-alive-timeout 20000

    echo "set weather location"
    gsettings set org.gnome.shell.weather locations "[<(uint32 2, <('Berlin', 'EDDB', true, [(0.91426163401859872, 0.23591034304566436)], [(0.91658875132345297, 0.23387411976724018)])>)>]"
    gsettings set org.gnome.Weather locations "[<(uint32 2, <('Berlin', 'EDDB', true, [(0.91426163401859872, 0.23591034304566436)], [(0.91658875132345297, 0.23387411976724018)])>)>]"

    echo "set world clock locations"
    gsettings set org.gnome.shell.world-clocks locations "[<(uint32 2, <('London', 'EGWU', true, [(0.89971722940307675, -0.007272211034407213)], [(0.89884456477707964, -0.0020362232784242244)])>)>, <(uint32 2, <('Porto Alegre', 'SBCO', true, [(-0.52388966962472883, -0.89389947104752665)], [(-0.52418054619786614, -0.89360857702109675)])>)>, <(uint32 2, <('Helsinki', 'EFHK', true, [(1.0527244329790106, 0.43575054239901517)], [(1.0502615814182288, 0.43518331039211688)])>)>, <(uint32 2, <('Toronto', 'CYTZ', true, [(0.76154532446909495, -1.3857914260834978)], [(0.76212711252195475, -1.3860823201099277)])>)>]"

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

