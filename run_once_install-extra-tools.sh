#!/usr/bin/env bash
set -eu

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# fzf
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all
fi

# tmux config repo si el vols
if [ ! -d "$HOME/.tmux" ]; then
  git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
  ln -sf "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
fi
