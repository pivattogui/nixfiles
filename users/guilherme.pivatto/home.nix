{ config, pkgs, user, ... }: {
  imports = [
    ../../pkgs/common-cli.nix
    ../../pkgs/zsh.nix
    ../../pkgs/1password.nix
    ../../pkgs/git.nix
    ../../pkgs/kitty.nix
    ../../pkgs/vim.nix
    ../../pkgs/zed.nix
    ../../pkgs/claude.nix
  ];

  xdg.enable = true;

  # User-specific packages
  home.packages = with pkgs; [
    docker
    tree
    pscale
    ngrok
    go
  ];

  programs.git.settings.user.email = user.git-email;

  home.stateVersion = "26.05";
}
