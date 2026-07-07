{ pkgs, ... }:

{
  imports = [
    ./dev/c.nix
    # ./dev/dotnet.nix
    # ./dev/flutter.nix
    ./dev/go.nix
    ./dev/javascript.nix
    ./dev/lua.nix
    ./dev/python.nix
    # ./dev/rust.nix
    # ./dev/zig.nix
  ];
}
