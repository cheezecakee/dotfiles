{ inputs, self, ... }:
{
    flake.nixosModules.devMod = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            gcc
            clang
            cmake
            go
            gomodifytags
            nodejs
            bun
            lua
            luarocks
            lua-language-server
            luaPackages.luacheck
            stylua
            python3
        ];
    };
}
