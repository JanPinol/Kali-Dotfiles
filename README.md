# Kali Dotfiles

Dotfiles i configuració de la meva VM de Kali gestionats amb [chezmoi](https://www.chezmoi.io/).

## Què inclou

- `zsh`, `bash`, `p10k`
- `bspwm`, `sxhkd`, `picom`
- `kitty`
- `polybar`
- `nvim`
- `qt6ct`, `qterminal`
- fonts personalitzades
- wallpaper
- scripts d'instal·lació bàsics
- llistes de paquets per recrear l'entorn

## Estructura

- `dot_config/` → configuracions de `~/.config`
- `dot_local/share/fonts/` → fonts addicionals
- `Wallpapers/` → wallpapers
- `dot_setup/` → llistes de paquets i eines instal·lades
- `run_once_install-packages.sh` → instal·lació de paquets base
- `run_once_install-extra-tools.sh` → eines extra

## Instal·lació ràpida en una VM nova

Instal·la dependències bàsiques i chezmoi:

```bash
sudo apt update
sudo apt install -y git curl
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

