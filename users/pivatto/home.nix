{ config, pkgs, user, ... }: {
  imports = [
    ../../pkgs/zsh.nix
    ../../pkgs/1password.nix
    ../../pkgs/git.nix
    ../../pkgs/kitty.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    _1password-cli
    docker
    gh
    lazygit
    lazydocker
    unzip
    fzf
    btop
    eza
    yazi
    bat
    tig
    ntl
  ];

  programs.git.settings.user.email = user.git-email;

  home.stateVersion = "25.05";
}
