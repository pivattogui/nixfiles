{ pkgs, ... }:
{
  # Common CLI packages shared across all users
  home.packages = with pkgs; [
    asdf-vm
    _1password-cli
    gh
    unzip
    fzf
    btop
    eza
    bat
    tig
    ntl
  ];
}
