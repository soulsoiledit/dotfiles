{
  stylix.targets.vesktop.enable = false;
  programs.vesktop = {
    enable = true;
    vencord.useSystem = true;
    vencord.settings.plugins.NoReplyMention = {
      enabled = true;
      inverseShiftReply = true;
    };
  };
}
