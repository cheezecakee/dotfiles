# 🍰 nix-flake-config

My personal [NixOS](https://nixos.org/) flake-based configuration for a development and content-creation workstation powered by **Hyprland**, **NVIDIA**, and secure boot.

---

## 🖥️ System Overview

- **OS**: NixOS 25.05
- **Display Protocol**: Wayland (Hyprland with UWSM)
- **Display Manager**: SDDM (Qt6, Astronaut theme)
- **Graphics**: NVIDIA (PRIME setup with Intel iGPU)
- **Boot**: Secure Boot via [Lanzaboote](https://github.com/nix-community/lanzaboote)
- **Terminal**: Ghostty
- **Shell**: Bash
- **Launcher**: Rofi
- **Bar**: Waybar
- **Audio**: PipeWire
- **File Systems**: Auto-mount via `udisks2`, `devmon`, `gvfs`

---

## 📁 Repository Structure

```
.
├── flake.nix                    # Flake entry point
├── hosts/
│   └── desktop/
│       ├── default.nix          # Host-specific configuration
│       ├── hardware-configuration.nix
│       ├── filesystems.nix      # Mount points
│       └── private.nix          # gitignored - see setup below
├── modules/                     # Reusable system modules
│   ├── audio.nix
│   ├── databases.nix
│   ├── desktop/
│   │   ├── hyprland.nix
│   │   ├── ricing.nix
│   │   └── sddm.nix
│   ├── development.nix
│   ├── editors.nix
│   ├── fonts.nix
│   ├── nvidia.nix
│   ├── programs.nix
│   ├── security/
│   │   └── secure-boot.nix
│   ├── services.nix
│   └── virtualisation.nix
├── users/
│   └── cheeze.nix              # User configuration
└── scripts/
    ├── nixos-rebuild.sh
    └── nixos-update.sh
```

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/cheezecakee/nix-flake-config.git ~/nix-flake-config
cd ~/nix-flake-config
```

### 2. Create private configuration

Copy the example and fill in your personal details:

```bash
cp hosts/desktop/private.nix.example hosts/desktop/private.nix
```

Edit `hosts/desktop/private.nix` with your database names, usernames, etc.

### 3. Update hardware configuration

Replace `hosts/desktop/hardware-configuration.nix` with your system's hardware config:

```bash
sudo nixos-generate-config --show-hardware-config > hosts/desktop/hardware-configuration.nix
```

### 4. Configure filesystems (optional)

Edit `hosts/desktop/filesystems.nix` if you have additional drives to mount.

### 5. Build and switch

```bash
sudo nixos-rebuild switch --flake .#nixos
```

---

## 🔐 Secure Boot Setup

This configuration uses **Lanzaboote** for UEFI Secure Boot support.

### Initial Setup (if not already configured):

1. **Disable Secure Boot** in your BIOS/UEFI (temporarily)

2. **Build the system** with Lanzaboote enabled:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

3. **Enroll your keys**:
   ```bash
   sudo sbctl create-keys
   sudo sbctl enroll-keys --microsoft  # Include Microsoft keys for dual-boot compatibility
   ```

4. **Verify signing**:
   ```bash
   sudo sbctl verify
   ```

5. **Re-enable Secure Boot** in BIOS/UEFI

### Check Status:

```bash
sudo sbctl status
```

**Note**: `secure-boot.nix` is currently configured and enabled. If you want to disable secure boot, comment out the import in `hosts/desktop/default.nix`.

---

## 🔧 Core Packages

### 📝 Editors
- **neovim** – system default editor with Python/Node support
- **obsidian** – knowledge management

### 🖥️ Desktop & Terminal
- **ghostty** – GPU-accelerated terminal
- **rofi** – application launcher
- **waybar** – status bar with MPRIS support
- **wlogout** – logout menu
- **wl-clipboard** – Wayland clipboard utilities

### 📽️ Media & Communication
- **vlc** – media player
- **obs-studio** – streaming/recording
- **discord** – communication
- **spotify** – music streaming

### 🎨 Ricing & Customization
- **swww** – animated wallpaper daemon
- **hyprpaper** – wallpaper manager
- **hyprshot** – screenshot tool
- **hyprshade** – screen shader/filter
- **eww** – widget system
- **SDDM Astronaut theme** – login screen theme

### 🎮 Gaming
- **steam** – game platform

---

## 👨‍💻 Development Tools

### Languages & Runtimes
- **C/C++**: `gcc`, `clang`, `cmake`
- **Rust**: `cargo`
- **JavaScript**: `nodejs`, `bun`
- **Python**: `python3`
- **Go**: `go`
- **Lua**: `lua`, `luarocks`
- **Zig**: `zig`
- **Dart**: `dart`
- **.NET**: `dotnet-sdk_9`
- **Haskell**: `haskellPackages.hindent`

### Tools & LSPs
- **Git** – version control
- **Lua tools**: `lua-language-server`, `luacheck`, `stylua`
- **Ripgrep** – fast search
- **Android Studio** – mobile development

### Containerization
- **Docker** – enabled with user access
- **NVIDIA Container Toolkit** – GPU support in containers

---

## 🧠 Services & Configuration

### 🖼️ Graphics (NVIDIA)
- **PRIME** sync mode (Intel iGPU + NVIDIA dGPU)
- **Modesetting** enabled
- **32-bit support** for gaming
- **Persistent daemon** enabled
- **Open-source drivers** disabled (using proprietary)
- Bus IDs:
  - NVIDIA: `PCI:14:0:0`
  - Intel: `PCI:0:2:0`

### 🔊 Audio (PipeWire)
- **ALSA** compatibility
- **PulseAudio** compatibility
- **JACK** support
- **Wireplumber** session manager
- **32-bit support** for games
- **pavucontrol** GUI mixer

### 🗄️ Databases
- **PostgreSQL** – enabled (credentials in private.nix)
- **MongoDB** – disabled by default

### 🌐 Networking & Remote Access
- **NetworkManager** – network management
- **OpenSSH** – remote shell access
- **XRDP** – RDP server for remote desktop
- **Cloudflared** – secure tunnels

### 🔌 Storage & Auto-Mount
- **udisks2** – disk management
- **devmon** – device monitor
- **gvfs** – virtual filesystem
- **NTFS-3g** – NTFS filesystem support

### ⚡ Power Management
- **power-profiles-daemon** – power profiles
- **TLP** integration ready (currently disabled)

---

## 🎨 Dotfiles

**Important**: This repository only contains the NixOS system configuration. My user dotfiles (Hyprland, Waybar, Neovim configs, etc.) are managed separately.

You can find my dotfiles here: [Link to your dotfiles repo]

Or clone them to the expected location:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/.config
```

**Recommended structure**:
```
~/.config/
├── hypr/           # Hyprland config
├── waybar/         # Waybar config
├── rofi/           # Rofi config
├── nvim/           # Neovim config
└── ...
```

---

## 🛠️ Helper Scripts

### `scripts/nixos-rebuild.sh`
Wrapper for rebuilding the system (you can customize this).

### `scripts/nixos-update.sh`
Update flake inputs and rebuild.

---

## 📝 Customization Guide

### Add a new machine

1. Copy `hosts/desktop/` to `hosts/your-machine/`
2. Update `hardware-configuration.nix`
3. Adjust `filesystems.nix` and `private.nix`
4. Add new config to `flake.nix`:

```nix
nixosConfigurations.your-machine = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    lanzaboote.nixosModules.lanzaboote
    ./hosts/your-machine/default.nix
  ];
};
```

### Disable a module

Comment out the import in `hosts/desktop/default.nix`:

```nix
# ../../modules/nvidia.nix  # Disabled NVIDIA
```

### Add packages

Edit the appropriate module:
- Dev tools → `modules/development.nix`
- GUI apps → `modules/programs.nix`
- Desktop tools → `modules/desktop/ricing.nix`

---

## ⚠️ Known Issues & Notes

- **Secure Boot**: Must be set up manually after first boot (see above)
- **NVIDIA**: Nouveau drivers are blacklisted
- **PostgreSQL**: Uses trust authentication (insecure for production - change in `private.nix`)
- **System State Version**: 25.05 - Do not change this after installation

---

## 📚 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Package Search](https://search.nixos.org/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Lanzaboote Documentation](https://github.com/nix-community/lanzaboote)
- [Home Manager Manual](https://nix-community.github.io/home-manager/) (for future user config migration)

---

## 📄 License

This configuration is provided as-is for personal use. Feel free to fork and adapt to your needs!

---

## 🙏 Acknowledgments

Thanks to the NixOS community and all the amazing open-source projects that make this configuration possible.
