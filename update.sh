#!/usr/bin/bash

[[ -f .zshrc ]] && rm .zshrc
cp /home/randfloat/.zshrc .
[[ -d .config/nvim ]] && rm -r .config/nvim
cp -r /home/randfloat/.config/nvim ./.config/nvim

