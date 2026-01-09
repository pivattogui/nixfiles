{ config, pkgs, user, ... }:
{
  imports = [
    ../../modules/system/darwin/user.nix
    ../../pkgs/common-casks.nix
  ];

  home-manager.users."${user.login}" = import ./home.nix { inherit config pkgs user; };

  homebrew.casks = [
    "tableplus"
    "proton-mail"
    "protonvpn"
    "steam"
    "stremio"
    "prismlauncher"
    "caffeine"
    "docker-desktop"
    "bruno"
  ];
}
