_: {
  # Add Homebrew to PATH
  environment.systemPath = [ "/opt/homebrew/bin" ];

  # Enable Touch ID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Set nixbld group ID
  ids.gids.nixbld = 350;

  system.defaults.dock = {
    # Appearance
    autohide = false;
    mineffect = "scale";            # Minimize animation effect
    orientation = "bottom";
    tilesize = 36;

    # Behavior
    minimize-to-application = true; # Minimize windows into application icon
    mru-spaces = false;             # Don't automatically rearrange Spaces
    show-process-indicators = true; # Show indicator lights for open applications
    persistent-others = [];
    show-recents = false;           # Don't show recent applications

    # Hot corners
    # Values: 0=disabled, 2=Mission Control, 3=Show application windows,
    #         4=Desktop, 5=Start screen saver, 6=Disable screen saver,
    #         10=Put display to sleep, 11=Launchpad, 12=Notification Center
    wvous-tl-corner = 2;   # Top-left: Mission Control
    wvous-tr-corner = 12;  # Top-right: Notification Center
    wvous-bl-corner = 11;  # Bottom-left: Launchpad
    wvous-br-corner = 4;   # Bottom-right: Desktop
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;  # Show all file extensions
    CreateDesktop = false;          # Don't show icons on desktop
    FXPreferredViewStyle = "Nlsv";  # Default view: list view
    ShowPathbar = true;             # Show path bar at bottom
  };
}
