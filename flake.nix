{
  description = "Nix configuration for Darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };

    hosts = {
      moka = {
        system = "aarch64-darwin";
        user = {
          login = "pivatto";
          git-email = "github@pivatto.dev";
        };
      };
    };
  in {
    darwinConfigurations = nixpkgs.lib.mapAttrs mkSystem hosts;
  };
}
