{ ... }:
{
    perSystem = { pkgs, ... }: {
        packages.rust = pkgs.buildEnv {
            name = "dev-rust";
            paths = with pkgs; [
                cargo
            ];
        };
    };
}
