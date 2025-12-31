{ config, pkgs, ... }: {
  home.packages = [ pkgs.hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/wallpaper.jpg
    wallpaper = ,~/Pictures/wallpaper.jpg
    splash = false
    ipc = off
  '';
}
