{ nixpkgs, inputs }:
  name:
    { system, user }:
    let
      isDarwin = builtins.match ".*-darwin" system != null;
      systemFn = if isDarwin
        then inputs.nix-darwin.lib.darwinSystem
        else nixpkgs.lib.nixosSystem;
      hostConfig = ../hosts/${name};
      userConfig = ../users/${(user.profile or user.login)};
    in systemFn rec {
      inherit system;

      specialArgs = inputs // { user = user; };

      modules = [
        { nixpkgs.config.allowUnfree = true; }
      ] ++ (if isDarwin then [
        {
          nix = {
            enable = false;
            settings = {
              experimental-features = [ "nix-command" "flakes" ];
            };
          };
        }
      ] else [])
      ++ [
        hostConfig
        userConfig
      ];
    }
