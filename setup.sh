#!/bin/sh

echo "## nvim ##"
echo "Copying files to ~/.config/nvim"
cp -r ./nvim ~/.config/nvim
echo "Done!"

echo ""

echo "## vscode ##"
echo "Copying files to ~/.config/Code/User/"
cp ./vscode/*.json ~/.config/Code/User/
echo "Done!"

echo ""
