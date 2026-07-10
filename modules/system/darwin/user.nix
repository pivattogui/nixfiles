{ home-manager, user, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = { inherit user; };
    sharedModules = [{
      # Use linkApps instead of copyApps to avoid permission issues on macOS
      # https://github.com/nix-community/home-manager/issues/8067
      targets.darwin.copyApps.enable = false;
      targets.darwin.linkApps.enable = true;
    }];
  };

  system.primaryUser = user.login;

  programs.zsh.enable = true;

  users.users."${user.login}" = {
    home = "/Users/${user.login}";
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
      # Homebrew >=5.1 requires an explicit flag for non-interactive `brew
      # bundle --cleanup`; without it activation aborts. --force-cleanup runs
      # cleanup without prompting (not --force, which means install overwrite).
      extraFlags = [ "--force-cleanup" ];
    };
  };
}
