{ config, pkgs, home-manager, user, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-bak";

  system.primaryUser = user.login;

  programs.zsh.enable = true;

  users.users."${user.login}" = {
    home = "/Users/${user.login}";
  };

  home-manager.users."${user.login}" = (import ./home.nix { inherit config pkgs user; });

  homebrew.enable = true;

  homebrew.onActivation.cleanup = "zap";

  homebrew.casks = [
    "1password"
    "kitty"
    "obsidian"
    "zed"
    "logi-options+"
    "rectangle"
    "spotify"
    "tableplus"
    "zen"
    "discord"
    "whatsapp"
    "proton-mail"
    "protonvpn"
    "steam"
    "keyboardcleantool"
    "stremio"
    "github"
    "prismlauncher"
  ];
}
