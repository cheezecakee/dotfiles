# 🍰 nix-flake-config

My personal [NixOS](https://nixos.org/) flake-based configuration using **flake-parts** for modular system management. Built for development and content-creation workstations powered by **Hyprland**, **NVIDIA**, and secure boot.

---

## 🖥️ System Overview

- **OS**: NixOS (unstable channel)
- **Display Protocol**: Wayland (Hyprland with UWSM)
- **Display Manager**: SDDM (Qt6, Astronaut theme)
- **Graphics**: NVIDIA (PRIME setup with Intel iGPU) - configurable per machine
- **Boot**: Secure Boot via [Lanzaboote](https://github.com/nix-community/lanzaboote) - configurable per machine
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
├── flake.nix                    # Flake entry point with inputs
├── config.nix                   # Machine-specific feature flags
├── nixos.nix                    # NixOS configurations (flake-parts)
├── package.nix                  # Custom packages (flake-parts)
├── shell.nix                    # Dev shell (flake-parts)
├── ags.nix                      # AGS/Astal packages and dev shell
├── machines/
│   ├── desktop.nix              # Desktop configuration
│   ├── notebook.nix             # Notebook configuration
│   ├── hardware-configuration.nix
│   └── drives.nix               # NTFS drive mounts (desktop only)
├── system/                      # Modular system configuration
│   ├── apps.nix                 # GUI applications
│   ├── audio.nix                # PipeWire audio setup
│   ├── boot.nix                 # Boot loader & secure boot
│   ├── cli.nix                  # CLI tools
│   ├── database.nix             # PostgreSQL/MongoDB
│   ├── dev.nix                  # Programming languages & tools
│   ├── docker.nix               # Docker containerization
│   ├── editor.nix               # Neovim configuration
│   ├── fonts.nix                # System fonts
│   ├── graphics.nix             # NVIDIA/GPU configuration
│   ├── hyprland.nix             # Hyprland window manager
│   ├── libraries.nix            # GTK/Astal libraries
│   ├── network.nix              # NetworkManager & IWD
│   ├── region.nix               # Timezone, locale, keymaps
│   ├── sddm.nix                 # Display manager
│   ├── settings.nix             # System-wide settings
│   └── utils.nix                # Wayland/desktop utilities
└── users/
    └── cheeze.nix               # User configuration
```

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/cheezecakee/nix-flake-config.git ~/.dotfiles/nix
cd ~/.dotfiles/nix
```

### 2. Choose your machine configuration

This flake supports multiple machine profiles configured in `config.nix`:

**Desktop** (default):
- Secure Boot enabled
- NVIDIA graphics enabled
- External NTFS drives mounted

**Notebook**:
- Secure Boot disabled
- NVIDIA graphics disabled (uses integrated GPU)
- No external drives

### 3. Update hardware configuration

Replace `machines/hardware-configuration.nix` with your system's hardware config:

```bash
sudo nixos-generate-config --show-hardware-config > machines/hardware-configuration.nix
```

### 4. Configure machine-specific settings

Edit `config.nix` to match your hardware:

```nix
{
  machines = {
    desktop = {
      hasSecureBoot = true;   # Enable/disable secure boot
      hasNvidia = true;       # Enable/disable NVIDIA drivers
    };
    
    notebook = {
      hasSecureBoot = false;
      hasNvidia = false;
    };
  };
}
```

### 5. Build and switch

**For desktop:**
```bash
sudo nixos-rebuild switch --flake .#desktop
```

**For notebook:**
```bash
sudo nixos-rebuild switch --flake .#notebook
```

---

## 🔐 Secure Boot Setup

This configuration uses **Lanzaboote** for UEFI Secure Boot support (configurable per machine).

### Initial Setup (if secure boot is enabled in config.nix):

1. **Disable Secure Boot** in your BIOS/UEFI (temporarily)

2. **Build the system** with Lanzaboote enabled:
   ```bash
   sudo nixos-rebuild switch --flake .#desktop
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

**Note**: Secure boot can be disabled per machine by setting `hasSecureBoot = false` in `config.nix`.

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
- **AGS** – Aylur's GTK Shell for custom widgets
- **Astal** – Widget libraries (io, astal4, notifd, battery, network)
- **SDDM Astronaut theme** – login screen theme

### 🎮 Gaming
- **steam** – game platform

### 🌐 Browsers
- **Zen Browser** – privacy-focused browser
- **Chromium** – web browser

---

## 👨‍💻 Development Tools

### Languages & Runtimes
- **C/C++**: `gcc`, `clang`, `cmake`
- **Rust**: `cargo`
- **JavaScript**: `nodejs`, `bun`
- **Python**: `python3`
- **Go**: `go`, `gomodifytags`
- **Lua**: `lua`, `luarocks`
- **Zig**: `zig`
- **Dart**: `dart`
- **.NET**: `dotnet-sdk_9`

### Tools & LSPs
- **Git** – version control
- **Lua tools**: `lua-language-server`, `luacheck`, `stylua`
- **Ripgrep** – fast search
- **Android Studio** – mobile development
- **DBeaver** – database management GUI
- **fd**, **fzf**, **eza**, **zoxide** – modern CLI utilities

### Containerization
- **Docker** – enabled with user access

---

## 🧠 Services & Configuration

### 🖼️ Graphics (NVIDIA - configurable)
- **PRIME** sync mode (Intel iGPU + NVIDIA dGPU)
- **Modesetting** enabled
- **32-bit support** for gaming
- Bus IDs:
  - NVIDIA: `PCI:14:0:0`
  - Intel: `PCI:0:2:0`
- **Can be disabled** per machine in `config.nix`

### 🔊 Audio (PipeWire)
- **ALSA** compatibility
- **PulseAudio** compatibility
- **JACK** support
- **Wireplumber** session manager
- **32-bit support** for games
- **pavucontrol** GUI mixer

### 🗄️ Databases
- **PostgreSQL** – enabled
- **MongoDB** – disabled by default (broken in unstable)

### 🌐 Networking & Remote Access
- **NetworkManager** – network management
- **IWD** – WiFi backend
- **OpenSSH** – remote shell access
- **XRDP** – RDP server for remote desktop

### 🔌 Storage & Auto-Mount
- **udisks2** – disk management
- **devmon** – device monitor
- **gvfs** – virtual filesystem
- **NTFS-3g** – NTFS filesystem support

### ⚡ Power Management
- **power-profiles-daemon** – power profiles

---

## 🎨 Dotfiles

**Important**: This repository only contains the NixOS system configuration. My user dotfiles (Hyprland, Waybar, Neovim configs, etc.) are managed separately.

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

## 📝 Customization Guide

### Add a new machine

1. Add machine configuration to `config.nix`:

```nix
{
  machines = {
    desktop = { ... };
    notebook = { ... };
    
    # New machine
    workstation = {
      hasSecureBoot = true;
      hasNvidia = true;
    };
  };
}
```

2. Create machine file `machines/workstation.nix`:

```nix
{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Import relevant system modules...
  ];

  networking.hostName = "workstation";
  system.stateVersion = "25.05";
}
```

3. Add to `nixos.nix`:

```nix
nixosConfigurations.workstation = inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ./machines/workstation.nix
  ];
  specialArgs = { 
    inherit inputs;
    machineConfig = configs.machines.workstation;
  };
};
```

4. Build:

```bash
sudo nixos-rebuild switch --flake .#workstation
```

### Disable a system module

Comment out the import in your machine file (`machines/desktop.nix` or `machines/notebook.nix`):

```nix
# ../system/graphics.nix  # Disabled NVIDIA
```

### Add packages

Edit the appropriate module:
- GUI apps → `system/apps.nix`
- CLI tools → `system/cli.nix`
- Dev tools → `system/dev.nix`
- Desktop utilities → `system/utils.nix`

---

## 🛠️ Development

### Enter development shell

**General dev shell:**
```bash
nix develop
```

**AGS development shell:**
```bash
nix develop .#ags
```

### Build custom packages

```bash
nix build .#my-shell
```

---

## 🔄 Updates

### Update all flake inputs

```bash
nix flake update
sudo nixos-rebuild switch --flake .#desktop
```

### Update specific input

```bash
nix flake lock --update-input nixpkgs
```

---

## ⚠️ Known Issues & Notes

- **Secure Boot**: Must be set up manually after first boot (see above)
- **NVIDIA**: Nouveau drivers are blacklisted
- **MongoDB**: Currently disabled due to build failures in unstable
- **System State Version**: 25.05 - Do not change this after installation
- **Channel**: Uses nixos-unstable for latest packages

---

## 📚 Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Nix Package Search](https://search.nixos.org/)
- [Flake Parts Documentation](https://flake.parts/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Lanzaboote Documentation](https://github.com/nix-community/lanzaboote)
- [AGS Documentation](https://aylur.github.io/ags-docs/)
- [Astal Documentation](https://aylur.github.io/astal/)

---

## 📄 License

This configuration is provided as-is for personal use. Feel free to fork and adapt to your needs!

---

## 🙏 Acknowledgments

Thanks to the NixOS community and all the amazing open-source projects that make this configuration possible.
