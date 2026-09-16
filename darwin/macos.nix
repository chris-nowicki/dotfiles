{ ... }:
{
  # Shared preferences from ~/Setup, reconciled with the personal Mac.
  # Each switch reapplies these values for the host's system.primaryUser.
  system.defaults = {
    dock = {
      tilesize = 45;
      magnification = true;
      minimize-to-application = true;
      autohide = true;
      show-recents = false;
    };

    WindowManager = {
      GloballyEnabled = false;
      EnableStandardClickToShowDesktop = false;
      AppWindowGroupingBehavior = true;
      StandardHideWidgets = false;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      "com.apple.swipescrolldirection" = false;
    };

    finder = {
      FXEnableExtensionChangeWarning = false;
      FXDefaultSearchScope = "SCcf";
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
      ShowExternalHardDrivesOnDesktop = false;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
    };

    # The pinned nix-darwin has no typed option for Finder's tab bar.
    CustomUserPreferences."com.apple.finder".ShowTabView = true;

    menuExtraClock = {
      ShowDate = 0; # When space allows.
      ShowDayOfWeek = false;
      ShowSeconds = true;
      FlashDateSeparators = false;
    };
  };
}
