{ inputs, self, ... }:
{
    flake.nixosModules.regionMod = { pkgs, ... }: {
        # Timezone and Locale
        time.timeZone = "America/Sao_Paulo";

        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "pt_BR.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
        };

        # Console keymap
        console.keyMap = "us";

        # X11 keymap
        services.xserver.xkb = {
        layout = "us";
        variant = "";
        };
    };
}

