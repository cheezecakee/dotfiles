{ inputs, self, ... }:
{
    flake.nixosModules.cliMod = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            # Version control
            git

            # Search tools
            ripgrep
            fd
            fzf 

            # File management
            lf
            tree
            eza
            bat

            # System inspection
            lsof
            fastfetch

            # Archive utilites
            unzip

            # Directory navigation
            zoxide 

            # JSON processor
            jq

            # Resource monitor
            btop

            # PDF analyzer 
            pdfid
            pdf-parser
            qpdf


            # Data relay tool
            socat
        ];
    };
}
