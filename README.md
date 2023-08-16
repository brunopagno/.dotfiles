# All the things

### Helpers so I don't need to research every time again

hostname
```bash
hostnamectl set-hostname gengar
```

patient check alive
```bash
gsettings set org.gnome.mutter check-alive-timeout 20000
```

- install dev tools

```bash
sudo apt install build-essential
```

```bash
sudo dnf group install "C Development Tools and Libraries" "Development Tools"
```

```bash
git config --global init.defaultBranch main
git config --global user.name "name"
git config --global user.email "email"
git config --global pager.branch false
git config --global credential.helper store
```

### Debian specific bluetooth shenanigans

It seems that the firmware is not detected initially and needs to be manually installed later

```bash
sudo apt install firmware-realtek
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

### ZSA Moonlander

[Oryx config](https://configure.zsa.io/)

### Using Cedilla on intl keyboard

Copy `.XCompose` to the home folder and run:
```
gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/IMModule': <'ibus'>}"
```
[Reference](https://garajau.com.br/2021/02/enabling-cedilla-acute-c-on-gnome)

OR

```
sudo vim /usr/share/X11/locale/en_US.UTF-8/Compose
```

Then replace all ć with ç (lower and uppercase)

### nvim

```
ln -s $(pwd)/nvim ~/.config
```

### Logitech G29 things

The following command will print information about the device, including a path `/devices/pci000:00/.../input30/js0` or similar.

```
udevadm info /dev/input/js0
```

To access driver parameters we want to do `/sys/<the_path_mentioned_above_WITHOUT_js0>/device`
