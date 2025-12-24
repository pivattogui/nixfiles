{ config, pkgs, home-manager, user, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-bak";

  programs.zsh.enable = true;

  users.users."${user.login}" = {
    isNormalUser = true;
    description = user.login;
    home = "/home/${user.login}";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
