{ pkgs, ... }:
{
  # Common CLI packages shared across all users
  home.packages = with pkgs; [
    _1password-cli
    gh
    unzip
    fzf
    btop
    eza
    bat
    tig
    ntl
    uv
    bun
    ncdu
    ripgrep
    fd
    tldr
    jq
  ];
}
