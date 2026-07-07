{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    tree
    lf
    lsof
    zoxide 
    fd
    fzf 
    eza
    fastfetch
    unzip
    bat

    # PDF analyzer 
    pdfid
    pdf-parser
    qpdf
  ];
}
