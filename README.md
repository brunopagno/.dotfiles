# All the things

### Install ArchBTW

[Install arch gist file](https://gist.github.com/brunopagno/b395acb60f76df659480f0ef0dd5deb7).

### Gnome things

```bash
gsettings set org.gnome.desktop.peripherals.keyboard delay 360
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 4
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"

gsettings set org.gnome.mutter check-alive-timeout 20000
gsettings set org.gnome.desktop.interface enable-hot-corners false
```

git defaults
```bash
git config --global init.defaultBranch main
git config --global user.name "name"
git config --global user.email "email"
git config --global pager.branch false
git config --global credential.helper store
git config --global pull.rebase true
```

### Things to be installed

```
sudo pacman -S ttf-jetbrains-mono-nerd
sudo pacman -S wl-clipboard fzf
sudo pacman -S alacritty
sudo pacman -S gdm gnome
systemctl enable gdm
```

### Function keys keyboard

```
echo 'options hid_apple fnmode=0' | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo mkinitcpio -P
```
