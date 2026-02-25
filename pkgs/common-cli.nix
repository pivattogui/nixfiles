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
    claude-code
    uv
    opencode
    bun
    ncdu
    ripgrep
    fd
    tldr
    jq
  ];
}
