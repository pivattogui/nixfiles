{ config, pkgs, user, ... }: {
  imports = [
    ../../pkgs/zsh.nix
    ../../pkgs/1password.nix
    ../../pkgs/git.nix
    ../../pkgs/kitty.nix
    ../../pkgs/vim.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    asdf-vm
    _1password-cli
    docker
    gh
    tree
    unzip
    fzf
    btop
    tig
    ntl
    bat
    eza
    pscale
    ngrok
  ];


  programs.git.settings.user.email = user.git-email;

  home.stateVersion = "25.05";
}
