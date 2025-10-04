{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version Control
    git

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
    haskellPackages.hindent

    # Development Tools
    ripgrep
    tree
    lsof
  ];
}
