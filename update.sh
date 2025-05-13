#!/usr/bin/bash

[[ -f .zshrc ]] && rm .zshrc
cp ~/.zshrc .
[[ -d .config/nvim ]] && rm -r .config/nvim
cp -r ~/.config/nvim ./.config/nvim
[[ -f .clang-format ]] && rm .clang-format
cp ~/.clang-format .
