{
  stylix.targets.vesktop.enable = false;
  programs.vesktop = {
    enable = true;
    vencord = {
      useSystem = true;
      settings.plugins = {
        NoReplyMention = {
          enabled = true;
          inverseShiftReply = true;
        };

        Unindent.enabled = true;
      };
    };
  };
}
