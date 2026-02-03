{ pkgs, home-manager, nix-flatpak, ags, astal, caelestia-shell, caelestia-cli, self, user, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = { inherit self user ags astal caelestia-shell caelestia-cli; };
    sharedModules = [
      nix-flatpak.homeManagerModules.nix-flatpak
      ags.homeManagerModules.default
    ];
  };

  programs.zsh.enable = true;

  users.users."${user.login}" = {
    isNormalUser = true;
    description = user.login;
    home = "/home/${user.login}";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
