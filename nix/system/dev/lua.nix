{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lua
    luarocks

    lua-language-server
    luaPackages.luacheck
    stylua
  ];
}
