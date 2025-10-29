{ self, pkgs, ... }: {
  security.pam.services.sudo_local.touchIdAuth = true;

  ids.gids.nixbld = 350;

  system.defaults.dock = {
    # Appearance
    autohide = false;
    mineffect = "scale";
    orientation = "bottom";
    tilesize = 36;

    # Behavior
    minimize-to-application = true;
    mru-spaces = false;
    show-process-indicators = true;
    persistent-others = [];
    show-recents = false;

    # Hot corners
    wvous-tl-corner = 2;
    wvous-tr-corner = 12;
    wvous-bl-corner = 11;
    wvous-br-corner = 4;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    CreateDesktop = false;
    FXPreferredViewStyle = "Nlsv";
    ShowPathbar = true;
  };
}
