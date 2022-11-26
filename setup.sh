#!/bin/sh

echo "## nvim ##"
echo "Copying files to ~/.config/nvim"
cp -r ./nvim ~/.config/nvim
echo "Setting up nvim things"
~/.config/nvim/install.sh
echo "Done!"

echo ""

echo "## vscode ##"
echo "Copying files to ~/.config/Code/User/"
cp ./vscode/*.json ~/.config/Code/User/
echo "Done!"

echo ""

echo "Allow keychron keyboard Fkeys"
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo "Done!"

echo ""

echo "Initial git config"
git config --global init.defaultBranch main
echo "Done!"

echo ""

