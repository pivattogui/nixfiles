{ config, pkgs, home-manager, user, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-bak";
  home-manager.sharedModules = [{
    # Use linkApps instead of copyApps to avoid permission issues on macOS
    # https://github.com/nix-community/home-manager/issues/8067
    targets.darwin.copyApps.enable = false;
    targets.darwin.linkApps.enable = true;
  }];

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
