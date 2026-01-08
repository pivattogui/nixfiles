{ pkgs, ... }: {
  imports = [
    ../../modules/home-common.nix
    ../../pkgs/xcompose.nix
    ../../pkgs/nixos/gnome-dconf.nix
    ../../pkgs/nixos/hyprland.nix
    ../../pkgs/nixos/hyprlock.nix
    ../../pkgs/nixos/wlogout.nix
  ];

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
    _1password-gui
    docker
    nh
    pavucontrol
    google-chrome
    prismlauncher
    libnotify
    playerctl
    swaybg
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  services.flatpak.remotes = [{
    name = "flathub";
    location = "https://flathub.org/repo/flathub.flatpakrepo";
  }];

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "com.stremio.Stremio"
  ];
}
