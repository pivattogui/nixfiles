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

  homebrew.enable = true;

  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap";
    upgrade = true;
  };
}
