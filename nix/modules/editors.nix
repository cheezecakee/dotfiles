{ config, pkgs, ... }:

{
  # Configure neovim as the system editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };

  # Enhanced sudo configuration for editors
  security.sudo = {
    enable = true;
    extraConfig = ''
      # Preserve environment variables for editor
      Defaults env_keep += "EDITOR VISUAL SUDO_EDITOR"
      Defaults env_keep += "HOME XDG_CONFIG_HOME NVIM_APPNAME"
      # Explicitly set the editor path for sudo
      Defaults editor = "/run/current-system/sw/bin/nvim"
    '';
  };

  # System-wide environment variables
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };

    # Shell initialization for all shells
    shellInit = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export SUDO_EDITOR="nvim"
    '';

    # Interactive shell initialization
    interactiveShellInit = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export SUDO_EDITOR="nvim"
    '';
  };

  # Configure bash specifically (outside environment block)
  programs.bash.shellInit = ''
    export EDITOR="nvim"
    export VISUAL="nvim"
    export SUDO_EDITOR="nvim"
  '';
}
