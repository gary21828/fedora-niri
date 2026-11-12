# Fedora Niri Desktop Setup

A script to turn a **Fedora 45 minimal install** into a full [Niri](https://github.com/YaLTeR/niri) Wayland compositor desktop with Waybar, greetd/tuigreet login, and essential applications.

Safe to re-run: package installs are idempotent and existing user configs are preserved.

## What it sets up

- **Niri** scrollable tiling compositor
- **Waybar** status bar
- **greetd + tuigreet** graphical login on VT1
- **Alacritty**, **Fuzzel**, **Firefox**
- **Thunar** file manager with SMB/CIFS support and AppImage thumbnailer
- **fcitx5** with Chinese Pinyin input
- **PipeWire** audio, **mako** notifications, **swaylock** / **swayidle**
- Portals, keyring, polkit, NetworkManager, fonts (Noto CJK, Font Awesome, etc.)
- Media viewers: imv, mpv, zathura
- RPM Fusion free + nonfree repositories

## Requirements

- Fedora 45 (minimal install recommended)
- Run as root (`sudo`)
- Internet connection for package installs

## Usage

```bash
# Download or copy the script
sudo bash setup-niri.sh
```

After it finishes, reboot. Log in via the tuigreet greeter; it will start a niri session.

## Config locations

The script writes (or skips if already present):

- `~/.config/niri/config.kdl`
- `~/.config/waybar/config.jsonc` and `style.css`
- `~/.config/fcitx5/profile`
- `~/.config/environment.d/90-fcitx5.conf`
- `~/.config/swayidle/config`
- `~/.config/mako/config`
- `~/.config/xdg-desktop-portal/niri-portals.conf`
- AppImage thumbnailer in `~/.local/bin/` and `~/.local/share/thumbnailers/`

## Notes

- Tailored for an Intel Haswell iGPU (mesa-dri-drivers). Adjust packages if needed for other hardware.
- fcitx5-chinese-addons pulls a sizable Qt6 WebEngine dependency.
- AppImage thumbnailer never executes the AppImage; it extracts `.DirIcon` under bubblewrap.
- For full media codecs, RPM Fusion is enabled; install `ffmpeg` separately if desired.

## License

MIT
