# All the things

### Install ArchBTW

[Install arch gist file](https://gist.github.com/brunopagno/b395acb60f76df659480f0ef0dd5deb7).

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
