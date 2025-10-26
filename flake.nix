{
  description = "Darwin configuration for Pivattos-MacBook-Air";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }:
  let mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs inputs;
    };
  in
  {
    darwinConfigurations."pivatto-macbook" = mkSystem "pivatto-macbook" {
      system = "aarch64-darwin";
      user = {
        login = "pivatto";
        git-email = "github@pivatto.dev";
      };
    };
  };
}
