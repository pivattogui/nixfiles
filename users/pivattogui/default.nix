{ config, pkgs, home-manager, user, ... }:
{
  imports = [
    ../../modules/user-base-nixos.nix
  ];

  home-manager.users."${user.login}" = (import ./home.nix { inherit config pkgs user; });
}
