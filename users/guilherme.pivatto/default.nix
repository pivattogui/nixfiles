{ config, pkgs, home-manager, user, ... }:
{
  imports = [
    ../../modules/system/darwin/user.nix
    ../../pkgs/common-casks.nix
  ];

  home-manager.users."${user.login}" = (import ./home.nix { inherit config pkgs user; });

  homebrew.brews = [
    "fop"
    "openssl@3"
    "unixodbc"
    "openjdk"
    "wxmac"
    "cmake"
  ];

  homebrew.casks = [
    "dbgate"
    "orbstack"
    "redis-insight"
    "hoppscotch"
    "notion"
    "notion-calendar"
    "slack"
    "claude"
    "linear-linear"
  ];
}
