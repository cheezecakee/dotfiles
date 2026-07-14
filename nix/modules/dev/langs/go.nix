{ self, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.go = pkgs.buildEnv {
      name = "dev-go";
      paths = with pkgs; [
        go

        gopls
        gofumpt
        goimports

        gotools
        gomodifytags
      ];
    };
  };
}
