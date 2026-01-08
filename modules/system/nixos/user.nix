{ config, pkgs, home-manager, nix-flatpak, self, user, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "hm-bak";
  home-manager.extraSpecialArgs = { inherit self user; };
  home-manager.sharedModules = [
    nix-flatpak.homeManagerModules.nix-flatpak
  ];

  programs.zsh.enable = true;

  users.users."${user.login}" = {
    isNormalUser = true;
    description = user.login;
    home = "/home/${user.login}";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
