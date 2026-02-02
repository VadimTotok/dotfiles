set -e

echo "Install flatpak..."

echo "Updating system and installing Flatpak..."
sudo apt update
sudo apt install flatpak -y

echo "Adding Flathub repository..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

APPS=(
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
)

echo "Install flatpak apps..."
flatpak install -y flathub "${APPS[@]}"
echo "Done! Restart your system if the app icons dont appear."
