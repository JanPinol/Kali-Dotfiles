# Kali Dotfiles

Personal Kali Linux dotfiles managed with [chezmoi](https://www.chezmoi.io/).

This repository contains my main terminal and desktop environment setup, including configuration for:

- `bspwm`
- `sxhkd`
- `polybar`
- `picom`
- `kitty`
- `zsh` + `oh-my-zsh` + `powerlevel10k`
- `tmux`
- `nvim`
- custom fonts and assets
- personal wallpaper

## Goal

The purpose of this repo is to make it easy to provision a new VM or machine and get it as close as possible to my main setup using `chezmoi`.

That includes:

- configuration files
- wallpaper
- required fonts
- bootstrap scripts
- extra shell and Neovim tooling

## Quick install

### 1. Install basic dependencies

```bash
sudo apt update
sudo apt install -y git curl
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

### 2. Initialize chezmoi

To clone on a fresh machine without depending on SSH:

```bash
chezmoi init --apply https://github.com/JanPinol/Kali-Dotfiles.git
```

## What `chezmoi` deploys

This repo manages:

- configuration under `~/.config`
- shell config (`.zshrc`, `.bashrc`, `.profile`, etc.)
- `~/.p10k.zsh`
- `~/.tmux.conf.local`
- `~/Wallpapers/wallpaper.jpg`
- `~/.local/share/fonts/feather.ttf`

It also includes `run_once_...` scripts so chezmoi can perform first-run setup automatically.

## Bootstrap scripts

### `run_once_install-packages.sh`

Installs packages listed in:

```text
~/.setup/apt-manual.txt
```

This keeps the base package list separate from the dotfiles themselves.

### `run_once_install-extra-tools.sh`

Installs and configures extra tools such as:

- `oh-my-zsh`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `powerlevel10k`
- `fzf`
- base `tmux` setup
- `bash-language-server`
- `pyright`
- `yaml-language-server`
- `vim-language-server`
- `lua-language-server`
- `ruff`

It also makes sure `~/.local/bin` is present in the `PATH`.

## Recommended post-install steps

After running `chezmoi init --apply` or `chezmoi update`, it is a good idea to check these items.

### 1. Restart the session

Especially if fonts, shell plugins, or window-manager config were installed.

### 2. Sync Neovim plugins

Open `nvim` and run:

```vim
:Lazy sync
```

### 3. Install Treesitter parsers

If Markdown or other filetypes show parser-related errors, run this inside `nvim`:

```vim
:TSInstall markdown markdown_inline bash lua python vim yaml json query
```

If needed, load Treesitter first:

```vim
:Lazy load nvim-treesitter
```

## Useful checks

### Language servers

```bash
which bash-language-server
which pyright-langserver
which yaml-language-server
which vim-language-server
which lua-language-server
which ruff
```

### Fonts and wallpaper

```bash
fc-match feather
ls ~/Wallpapers
```

## Notes about screen resolution

Resolution is **not hardcoded in this repository** on purpose.

Reason:

- not every machine or VM uses the same resolution
- it is better to let VMware or the system negotiate it automatically
- this keeps the repo portable

So resolution tweaks are considered machine-specific and are not part of the portable dotfiles.

## Notes for virtual machines

In VMware, you may need:

```bash
sudo apt install -y open-vm-tools-desktop
```

If resolution does not adapt automatically, inspect available modes with:

```bash
xrandr
```

And apply one temporarily if needed, for example:

```bash
xrandr --output Virtual-1 --mode 1920x1080
```

## Notes about BSPWM and Polybar

This setup is adapted to my current environment, but on a fresh VM some machine-specific values may differ, such as:

- network interface names (`eth0`, `wlan0`, `tun0`)
- temperature sensors
- battery support
- brightness controls
- MPD availability

If Polybar shows errors such as:

- `Invalid network interface`
- `Connection refused`
- `No suitable way to get current capacity value`

that usually means a module does not apply to that specific machine, not that the repo is broken.

## Useful maintenance commands

To see what chezmoi manages:

```bash
chezmoi managed | sort
```

To inspect the source repo used by chezmoi:

```bash
cd "$(chezmoi source-path)"
git status
```

To update from GitHub:

```bash
chezmoi update
```

## Important repo structure

- `dot_config/` → application configuration
- `dot_local/share/fonts/` → local fonts
- `Wallpapers/` → wallpapers
- `dot_setup/` → package and tooling inventory
- `run_once_install-packages.sh` → base package installation
- `run_once_install-extra-tools.sh` → extra tools and language servers

## Workflow

When something changes on the main machine:

```bash
cd "$(chezmoi source-path)"
git status
git add .
git commit -m "Update dotfiles"
git push
```

And on the target machine:

```bash
chezmoi update
```

## Current status

At this point, the repository is intended to bring up a working setup for:

- shell
- zsh theme
- kitty
- bspwm
- polybar
- picom
- wallpaper
- fonts
- base Neovim setup
- main language servers

The main thing that may still require a manual step sometimes is installing Treesitter parsers inside Neovim after the first plugin sync.

