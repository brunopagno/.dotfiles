# All the things

### Helpers so I don't need to research every time again

hostname
```bash
hostnamectl set-hostname gengar
```

make check alive a little bit more patient in gnome
```bash
gsettings set org.gnome.mutter check-alive-timeout 20000
```

install dev tools
```bash
# ubuntu
sudo apt install build-essential
# fedora
sudo dnf group install "C Development Tools and Libraries" "Development Tools"
```

git defaults
```bash
git config --global init.defaultBranch main
git config --global user.name "name"
git config --global user.email "email"
git config --global pager.branch false
git config --global credential.helper store
```

### NuPhy/Keychron keyboard

This will enable f# keys
```
# for the current session
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode

# permanent
echo 'options hid_apple fnmode=0' | sudo tee -a /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u
```

### Using Cedilla on intl keyboard

Copy `.XCompose` to the home folder and run:
```
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/IMModule': <'ibus'>}"
```
[Reference](https://garajau.com.br/2021/02/enabling-cedilla-acute-c-on-gnome)

### ZSA Moonlander

[Oryx config](https://configure.zsa.io/)

