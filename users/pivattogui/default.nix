{ config, pkgs, self, user, ... }:
{
  imports = [
    ../../modules/system/nixos/user.nix
  ];

  home-manager.users."${user.login}" = import ./home.nix { inherit config pkgs self user; };
}
