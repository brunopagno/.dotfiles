# All the things

### Helpers so I don't need to research every time again

There are less things here now that I use ArchBTW. But to [install arch there's a whole gist file](https://gist.github.com/brunopagno/b395acb60f76df659480f0ef0dd5deb7).

make check alive a little bit more patient in gnome
```bash
gsettings set org.gnome.mutter check-alive-timeout 20000
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
```

```
sudo pacman -S wl-clipboard fzf
```

```
sudo pacman -S waybar swaybg swaylock swayidle sway-contrib wl-mirror
```

```
yay -S light
```

### Function keys keyboard

```
echo 'options hid_apple fnmode=0' | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo mkinitcpio -P
```
