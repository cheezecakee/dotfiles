{ self, inputs, ... }:
{
    perSystem = { pkgs, ... }: {
        packages.mypackage = pkgs.sl;
    };
}
