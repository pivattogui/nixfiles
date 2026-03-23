{ pkgs, ... }:
{
  home.packages = with pkgs; [
    _1password-cli
    gh
    unzip
    fzf
    btop
    eza
    bat
    tig
    bun
    ncdu
    ripgrep
    fd
    tldr
    jq
  ];
}
