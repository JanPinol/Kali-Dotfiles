#!/usr/bin/env bash
set -eu

sudo apt update

if [ -f "$HOME/.setup/apt-manual.txt" ]; then
  pkgs=$(grep -vE '^\s*$' "$HOME/.setup/apt-manual.txt" | tr '\n' ' ')
  if [ -n "$pkgs" ]; then
    sudo apt install -y $pkgs
  fi
fi
