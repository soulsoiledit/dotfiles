{
  stylix.targets.vesktop.enable = false;
  programs.vesktop = {
    enable = true;

    settings = {
      discordBranch = "stable";
      spellCheckLanguages = [
        "en-US"
        "en"
      ];

      arRPC = true;
      openLinksWithElectron = false;

      enableMenu = false;
      customTitleBar = false;
      enableSplashScreen = true;
      splashTheming = true;
      disableMinSize = true;

      tray = true;
      minimizeToTray = true;
      appBadge = true;

      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
    };

    vencord = {
      useSystem = true;
      settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        cloud.settingsSync = false;
        plugins = {
          Settings.settingsLocation = "bottom";

          AlwaysTrust.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          KeepCurrentChannel.enabled = true;
          YoutubeAdblock.enabled = true;

          MessageLinkEmbeds = {
            enabled = true;
            messageBackgroundColor = true;
          };
          NoReplyMention = {
            enabled = true;
            inverseShiftReply = true;
          };
          ValidUser.enabled = true;
          VoiceChatDoubleClick.enabled = true;
        };
      };
    };
  };
}
