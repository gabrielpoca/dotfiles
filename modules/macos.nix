{
  config,
  lib,
  pkgs,
  ...
}:

{
  security.pam.services.sudo_local.touchIdAuth = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
  # system.keyboard.userKeyMapping = [
  #   {
  #     # Right Command to Ctrl
  #     HIDKeyboardModifierMappingSrc = 30064771303;
  #     HIDKeyboardModifierMappingDst = 30064771300;
  #   }
  # ];

  system.activationScripts.postActivation.text = ''
    # Disable the sound effects on boot
    sudo nvram SystemAudioVolume=" "
    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
    # Disable UI alert audio
    defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0
    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
    # Require password immediately after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0
    # Disable shadow in screenshots
    defaults write com.apple.screencapture disable-shadow -bool true
    # Shows battery percentage
    defaults write com.apple.menuextra.battery ShowPercent YES; killall SystemUIServer
    # Stop iTunes from responding to the keyboard media keys
    launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null
    # Show the ~/Library folder
    chflags nohidden ~/Library
  '';

  system.defaults = {
    dock = {
      autohide = false;
      tilesize = 40;
      appswitcher-all-displays = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.15;
      dashboard-in-overlay = false;
      enable-spring-load-actions-on-all-items = false;
      expose-animation-duration = 0.2;
      expose-group-apps = false;
      launchanim = true;
      mineffect = "genie";
      minimize-to-application = false;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
      orientation = "left";
      show-process-indicators = true;
      show-recents = false;
      showhidden = true;
      static-only = false;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      persistent-apps = [
        "/Applications/Arc.app"
        "/Applications/WezTerm.app"
        "/Applications/Slack.app"
        "/System/Applications/Mail.app"
        "/Applications/Bear.app"
        "/System/Applications/Calendar.app"
        "/Applications/Telegram.app"
        "/Applications/WhatsApp.app"
      ];
    };

    CustomUserPreferences."com.apple.dock".persistent-others = [
      {
        tile-data = {
          arrangement = 2; # 1 = name, 2 = date-added, 3 = date-modified, 4 = date-created, 5 = kind
          displayas = 1; # 0 = stack, 1 = folder
          showas = 2; # 0 = automatic, 1 = fan, 2 = grid, 3 = list

          file-data = {
            _CFURLString = "file:///Users/gabriel/Downloads/";
            _CFURLStringType = 15;
          };
        };
        tile-type = "directory-tile";
      }
    ];

    finder = {
      AppleShowAllExtensions = true;
      ShowStatusBar = false;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
    };

    NSGlobalDomain = {
      "com.apple.keyboard.fnState" = null;
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleKeyboardUIMode = 3;
      AppleMeasurementUnits = "Centimeters";
      AppleTemperatureUnit = "Celsius";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    loginwindow.GuestEnabled = false;
  };
}
