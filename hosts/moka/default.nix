{ self, pkgs, ... }: {

  environment.systemPackages = [];

  imports = [
    ../../modules/system/darwin
    ../../modules/system/fonts
  ];

  system.defaults.dock = {
    persistent-apps = [
      "/Applications/1password.app"
      "/Applications/Proton Mail.app"
      "/Applications/Kitty.app"
      "/Applications/Zen.app"
      "/Applications/Zed.app"
      "/Applications/Obsidian.app"
      "/Applications/Spotify.app"
      "/Applications/WhatsApp.app"
      "/Applications/Discord.app"
    ];
  };

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
}
