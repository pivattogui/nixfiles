{
  description = "Nix configuration for Darwin and NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };

    # Caelestia Shell (Quickshell-based bar/widgets)
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Caelestia CLI (wallpaper, theming, scheme management)
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, ... }:
  let mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in
  {
    # Darwin configurations
    darwinConfigurations."moka" = mkSystem "moka" {
      system = "aarch64-darwin";
      user = {
        login = "pivatto";
        git-email = "github@pivatto.dev";
      };
    };

    darwinConfigurations."clinia" = mkSystem "clinia" {
      system = "aarch64-darwin";
      user = {
        login = "pivatto";
        profile = "guilherme.pivatto";
        git-email = "guilherme.pivatto@clinia.io";
      };
    };

    # NixOS configurations
    nixosConfigurations."nixos" = mkSystem "nixos" {
      system = "x86_64-linux";
      user = {
        login = "pivattogui";
        git-email = "github@pivatto.dev";
      };
    };
  };
}
