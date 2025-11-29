{ config, pkgs, home-manager, user, ... }:
{
  imports = [
    ../../modules/user-base.nix
    ../../pkgs/common-casks.nix
  ];

  home-manager.users."${user.login}" = (import ./home.nix { inherit config pkgs user; });

  # User-specific Homebrew casks
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
