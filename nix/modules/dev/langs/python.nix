{ self, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.python = pkgs.buildEnv {
      name = "dev-python";
      paths = with pkgs; [
        python3
        python3Packages.pip

        basedpyright
        black
        pylint
      ];
    };
  };
}
