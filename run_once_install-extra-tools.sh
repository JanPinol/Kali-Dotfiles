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

# Nerd Fonts
mkdir -p "$HOME/.local/share/fonts"

if ! fc-list | grep -qi "Iosevka Nerd Font"; then
  cd /tmp
  curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Iosevka.zip
  mkdir -p "$HOME/.local/share/fonts/IosevkaNerd"
  unzip -o Iosevka.zip -d "$HOME/.local/share/fonts/IosevkaNerd"
fi

if ! fc-list | grep -qi "Hack Nerd Font"; then
  cd /tmp
  curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
  mkdir -p "$HOME/.local/share/fonts/HackNerd"
  unzip -o Hack.zip -d "$HOME/.local/share/fonts/HackNerd"
fi

if ! fc-list | grep -qi "feather"; then
  curl -fLo "$HOME/.local/share/fonts/feather.ttf" https://github.com/AT-UI/feather-font/raw/master/dist/feather.ttf
fi

fc-cache -fv

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
