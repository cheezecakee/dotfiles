{ self, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.c = pkgs.buildEnv {
      name = "dev-c";
      paths = with pkgs; [
        gcc
        clang
        cmake

        clang-tools
      ];
    };
  };
}
