{ self, pkgs, ... }: {

  environment.systemPackages = [];

  imports = [
    ../../modules/system/darwin
  ];

  system.defaults.dock = {
    persistent-apps = [
      "/Applications/1password.app"
      "/Applications/Claude.app"
      "/Applications/Kitty.app"
      "/Applications/Linear.app"
      "/Applications/Zen.app"
      "/Applications/Zed.app"
      "/Applications/Slack.app"
      "/Applications/DbGate.app"
      "/Applications/OrbStack.app"
      "/Applications/Spotify.app"
      "/Applications/WhatsApp.app"
    ];
  };

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
}
