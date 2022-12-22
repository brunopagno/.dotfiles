# Things

run `setup.sh` to setup general things

## Helpers so I don't need to research every time again

### Nvidia stuff on linux (ubuntu)

This for listing drivers available
```sh
sudo ubuntu-drivers devices
```

Then install the latest one compatible
```
sudo apt install nvidia-driver-520
```

It's probably worth to do a restart here

And finally open nvidia settings to check if settings are available
```sh
nvidia-settings
```

And under `Settings -> About` there should be a reference to Nvidia there

### Git stuff

Probably want to setup git config globals like `git config --global init.defaultBranch main`

### Keychron keyboard

This will enable f# keys
```
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
```

### ZSA Moonlander Thingy

[Oryx config](https://configure.zsa.io/moonlander/layouts/DNyab/latest/0)

### Using Cedilla on intl keyboard

Add this to `.profile`
```
GTK_IM_MODULE=cedilla QT_IM_MODULE=cedilla
```
