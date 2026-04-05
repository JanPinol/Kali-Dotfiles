#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

ensure_line() {
  local line="$1"
  local file="$2"
  touch "$file"
  grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

# PATH persistent
ensure_line 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc"
ensure_line 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"

# Base tools necessaris
sudo apt update
sudo apt install -y curl git unzip tar npm python3-pip pipx

# pipx path
python3 -m pipx ensurepath || true

# ---------- oh-my-zsh ----------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ---------- plugins zsh ----------
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ---------- powerlevel10k ----------
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# ---------- fzf ----------
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all
fi

# ---------- tmux repo ----------
if [ ! -d "$HOME/.tmux" ]; then
  git clone https://github.com/gpakosz/.tmux.git "$HOME/.tmux"
fi

if [ ! -L "$HOME/.tmux.conf" ]; then
  ln -sf "$HOME/.tmux/.tmux.conf" "$HOME/.tmux.conf"
fi

# ---------- npm language servers ----------
if ! command -v bash-language-server >/dev/null 2>&1; then
  sudo npm install -g bash-language-server
fi

if ! command -v pyright-langserver >/dev/null 2>&1; then
  sudo npm install -g pyright
fi

if ! command -v yaml-language-server >/dev/null 2>&1; then
  sudo npm install -g yaml-language-server
fi

if ! command -v vim-language-server >/dev/null 2>&1; then
  sudo npm install -g vim-language-server
fi

# ---------- ruff via pipx ----------
if ! command -v ruff >/dev/null 2>&1; then
  pipx install ruff || true
fi

# ---------- lua-language-server ----------
if ! command -v lua-language-server >/dev/null 2>&1; then
  mkdir -p "$HOME/.local/opt" "$HOME/.local/bin"
  cd "$HOME/.local/opt"

  ver="3.18.0"
  archive="lua-language-server-${ver}-linux-x64.tar.gz"
  url="https://github.com/LuaLS/lua-language-server/releases/download/${ver}/${archive}"

  rm -f "$archive"
  curl -fLO "$url"

  rm -rf "$HOME/.local/opt/lua_ls"
  mkdir -p "$HOME/.local/opt/lua_ls"
  tar -xzf "$archive" -C "$HOME/.local/opt/lua_ls"

  ln -sf "$HOME/.local/opt/lua_ls/bin/lua-language-server" "$HOME/.local/bin/lua-language-server"
fi

# ---------- feather font ----------
mkdir -p "$HOME/.local/share/fonts"
if [ -f "$HOME/.local/share/fonts/feather.ttf" ]; then
  fc-cache -fv >/dev/null 2>&1 || true
fi

# ---------- final checks ----------
hash -r || true

echo "Installed tools:"
command -v bash-language-server || true
command -v pyright-langserver || true
command -v yaml-language-server || true
command -v vim-language-server || true
command -v lua-language-server || true
command -v ruff || true
