{ config, pkgs, user, ... }: {
  imports = [
    ../../pkgs/common-cli.nix
    ../../pkgs/zsh.nix
    ../../pkgs/1password.nix
    ../../pkgs/git.nix
    ../../pkgs/kitty.nix
    ../../pkgs/vim.nix
    ../../pkgs/xcompose.nix
    ../../pkgs/zed.nix
    ../../pkgs/claude.nix
    # Gnome
    ../../pkgs/nixos/gnome-dconf.nix
    # Hyprland
    ../../pkgs/nixos/hyprland.nix
  ];

  xdg.enable = true;

  # Cursor theme
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [
    nodejs
    python3
    zed-editor
    lazydocker
    yazi
    obsidian
    spotify
    discord
    floorp-bin
    _1password-gui
    steam
    docker
    nh
    pavucontrol
    nix-output-monitor
    chromium
    # Hyprland
    libnotify
    playerctl
    swaybg
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.git.settings.user.email = user.git-email;

  home.stateVersion = "26.05";
}
