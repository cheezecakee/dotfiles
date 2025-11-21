{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Build Tools & Compilers
    gcc
    clang
    cmake
    cargo

    # Programming Languages & Runtimes
    nodejs
    bun
    python3
    go
    gomodifytags
    lua
    luarocks
    zig
    dart
    dotnet-sdk_9

    # Language Servers & Formatters
    lua-language-server
    luaPackages.luacheck
    stylua
    # haskellPackages.hindent
  ];
}
