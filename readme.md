# Bolinhos' setup

## Linux

```bash
sudo pacman -S \
  base-devel git fzf ripgrep wl-clipboard bash-completion \
  alacritty neovim ttf-jetbrains-mono-nerd mise \
  docker docker-compose docker-buildx \
  lazygit lazydocker
```

```bash
ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
ln -s "$(pwd)/alacritty" "$HOME/.config/alacritty"
ln -s "$(pwd)/lazydocker" "$HOME/.config/lazydocker"
ln -s "$(pwd)/bash/.bashrc" "$HOME/.bashrc"
ln -s "$(pwd)/bash/.inputrc" "$HOME/.inputrc"
```

## Windows (PowerShell)

```powershell
winget install `
  Git.Git junegunn.fzf BurntSushi.ripgrep.MSVC `
  Alacritty.Alacritty Neovim.Neovim jdx.mise `
  JesseDuffield.lazygit JesseDuffield.Lazydocker
```

### Manually Install

- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)
- [Docker](https://www.docker.com/)

```powershell
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "$HOME\.dotfiles\nvim"
New-Item -ItemType Junction -Path "$env:APPDATA\alacritty" -Target "$HOME\.dotfiles\alacritty"
New-Item -ItemType Directory -Force -Path "$env:APPDATA\jesseduffield"
New-Item -ItemType Junction -Path "$env:APPDATA\jesseduffield\lazydocker" -Target "$HOME\.dotfiles\lazydocker"
New-Item -ItemType SymbolicLink -Path "$HOME\.alacritty.local.toml" -Target "$HOME\.dotfiles\alacritty\windows.toml"
New-Item -ItemType SymbolicLink -Path "$HOME\.bashrc" -Target "$HOME\.dotfiles\bash\.bashrc"
New-Item -ItemType SymbolicLink -Path "$HOME\.inputrc" -Target "$HOME\.dotfiles\bash\.inputrc"
```

The symlinks need Developer Mode or an admin shell, junctions don't.
