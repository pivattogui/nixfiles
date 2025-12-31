{ config, pkgs, user, ... }: {
  imports = [
    ../../pkgs/common-cli.nix
    ../../pkgs/zsh.nix
    ../../pkgs/1password.nix
    ../../pkgs/git.nix
    ../../pkgs/kitty.nix
    ../../pkgs/vim.nix
    ../../pkgs/gnome-dconf.nix
    ../../pkgs/xcompose.nix
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    lazydocker
    yazi
    obsidian
    spotify
    discord
    floorp-bin
    _1password-gui
    steam
    docker
    btop
    nh
    nix-output-monitor
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.git.settings.user.email = user.git-email;

  home.stateVersion = "26.05";
}
