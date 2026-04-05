#!/usr/bin/env bash
set -euo pipefail

sudo apt update

if [ -f "$HOME/.setup/apt-manual.txt" ]; then
  mapfile -t pkgs < <(grep -vE '^\s*$|^#' "$HOME/.setup/apt-manual.txt" | sort -u)

  if [ "${#pkgs[@]}" -gt 0 ]; then
    sudo apt install -y "${pkgs[@]}"
  fi
fi
