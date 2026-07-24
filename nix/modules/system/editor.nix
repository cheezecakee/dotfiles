{ inputs, self, ... }:
{
  flake.nixosModules.editorMod = { lib, pkgs, ... }: {
    # Configure neovim as the system editor
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    environment.systemPackages = with pkgs; [
      nil
      statix
      nixfmt

      lua
      lua-language-server
      stylua

      bash-language-server
      shfmt

      marksman
      mdformat
      markdownlint-cli2
      markdown-toc

      gcc
    ];
  };
}
