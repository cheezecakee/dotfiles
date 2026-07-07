{ inputs, self, ... }:
{
    flake.nixosModules.appsMod = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            # File manager 
            superfile

            # Text Editors & Note Taking
            obsidian

            # Terminal
            ghostty

            # Communication
            discord

            # Media
            vlc
            obs-studio
            spotify

            # Development IDEs
            # android-studio

            # Gaming
            # steam

            # Utilities
            pavucontrol  # Audio control GUI

            # Browser
            brave

            caligula

            # Minecraft
            prismlauncher
        ];
    };
}
