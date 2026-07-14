{ self, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.js = pkgs.buildEnv {
      name = "dev-js";
      paths = with pkgs; [
        nodejs
        bun
        biome
      ];
    };
  };
}
