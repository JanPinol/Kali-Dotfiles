#!/usr/bin/env bash
set -eu

sudo apt update
sudo apt install -y npm python3-pip lua-language-server

sudo npm install -g \
  bash-language-server \
  pyright \
  yaml-language-server \
  vim-language-server

python3 -m pip install --user ruff
