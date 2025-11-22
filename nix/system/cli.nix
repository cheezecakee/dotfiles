{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    tree
    lsof
    zoxide 
    fd
    fzf 
    eza
    fastfetch

    # PDF analyzer 
    pdfid
    pdf-parser
    qpdf
  ];
}
