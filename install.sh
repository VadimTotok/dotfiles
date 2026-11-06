#!/usr/bin/env bash

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting full workspace deployment on Fedora...${NC}"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# 1. Update system and install base utilities
echo -e "${GREEN}Installing base utilities (Stow, Git, Zsh, Curl, Unzip)...${NC}"
sudo dnf update -y
sudo dnf install -y stow git zsh curl fastfetch unzip

# 2. Install system packages via DNF
SYSTEM_PACKAGES=(
    niri
    alacritty
    fuzzel
    mako
    wl-clipboard
)

echo -e "${GREEN}Installing system packages via DNF...${NC}"
sudo dnf install -y "${SYSTEM_PACKAGES[@]}"

# 3. Setup fonts (FiraMono Nerd Font)
echo -e "${GREEN}Installing FiraMono Nerd Font...${NC}"
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/FiraMonoNerdFont-Regular.otf" ]; then
    curl -fLo /tmp/FiraMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip
    unzip -o /tmp/FiraMono.zip -d "$FONT_DIR"
    rm /tmp/FiraMono.zip
    fc-cache -fv
fi

# 4. Setup Zsh and plugins
echo -e "${GREEN}Setting up Zsh and plugins...${NC}"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
fi

# 5. Install DankMaterialShell (DMS)
if ! command -v dms &> /dev/null; then
    echo -e "${GREEN}Installing DankMaterialShell (DMS)...${NC}"
    curl -fsSL https://install.duxlabs.dev | sh
fi

# 6. Setup Flatpak and applications
echo -e "${GREEN}Setting up Flatpak and installing applications...${NC}"
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

FLATPAK_APPS=(
    com.brave.Browser
    org.telegram.desktop
    org.onlyoffice.desktopeditors
    org.qbittorrent.qBittorrent
    md.obsidian.Obsidian
    com.bitwarden.desktop
    org.kde.krita
    com.teamspeak.TeamSpeak
    com.discordapp.Discord
    com.obsproject.Studio
    com.github.tchx84.Flatseal
)

flatpak install -y flathub "${FLATPAK_APPS[@]}"

# 7. Apply configurations via GNU Stow
echo -e "${GREEN}Linking configurations via GNU Stow...${NC}"

# Clear existing dirs/files before linking to avoid Stow conflicts
rm -rf ~/.config/niri ~/.config/DankMaterialShell ~/.config/alacritty ~/.config/fastfetch
rm -f ~/.zshrc

STOW_PACKAGES="niri dms zsh alacritty fastfetch"

for pkg in $STOW_PACKAGES; do
    echo "Linking package: $pkg"
    stow -R "$pkg"
done

echo -e "${GREEN}Complete! Restart your Niri session or reboot the system.${NC}"
