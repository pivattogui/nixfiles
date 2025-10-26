{ nixpkgs, inputs }:
  name:
    { system, user }:
    let
      systemFn = inputs.nix-darwin.lib.darwinSystem;
      hostConfig = ../hosts/${name};
      userConfig = ../users/${user.login};
    in systemFn rec {
      inherit system;

      specialArgs = inputs // { user = user; };

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
