{ nixpkgs, inputs }:
  name:
    { system, user }:
    let
      hostConfig = ../hosts/${name};
      userConfig = ../users/${(user.login)};

    in inputs.nix-darwin.lib.darwinSystem rec {
      inherit system;

      specialArgs = inputs // { inherit user; };

      modules = [
        { nixpkgs.config.allowUnfree = true; }
        {
          nix = {
            enable = false;
            settings = {
              experimental-features = [ "nix-command" "flakes" ];
            };
          };
        }
        hostConfig
        userConfig
      ];
    }
