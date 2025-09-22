echo "Install flatpak..."

sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Install flatpak apps..."

flatpak install -y \
	com.brave.Browser \
	org.telegram.desktop \
	com.mattjakeman.ExtensionManager \
	org.onlyoffice.desktopeditors \
	org.qbittorrent.qBittorrent \
	md.obsidian.Obsidian \
	com.bitwarden.desktop \
	org.kde.krita \
	org.kde.kdenlive \
	org.gnome.Extensions \
	com.teamspeak.TeamSpeak \
	org.gnome.Totem \
	com.discordapp.Discord \
	com.obsproject.Studio \
	
