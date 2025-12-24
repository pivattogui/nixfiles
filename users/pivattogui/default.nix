{ config, pkgs, home-manager, user, ... }:
{
  imports = [
    ../../modules/user-base-nixos.nix
  ];

  home-manager.users."${user.login}" = (import ./home.nix { inherit config pkgs user; });

  users.users."${user.login}".packages = with pkgs; [
    claude-code
    zed-editor
  ];
}
