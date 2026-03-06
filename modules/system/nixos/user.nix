{ pkgs, home-manager, nix-flatpak, ags, astal, caelestia-shell, caelestia-cli, spicetify-nix, self, user, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = { inherit self user ags astal caelestia-shell caelestia-cli spicetify-nix; };
    sharedModules = [
      nix-flatpak.homeManagerModules.nix-flatpak
      ags.homeManagerModules.default
      spicetify-nix.homeManagerModules.default
    ];
  };

  programs.zsh.enable = true;

  users.users."${user.login}" = {
    isNormalUser = true;
    description = user.login;
    home = "/home/${user.login}";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
