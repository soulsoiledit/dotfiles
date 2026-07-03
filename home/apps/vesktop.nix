{ pkgs, ... }:

{
  stylix.targets.vesktop.enable = false;
  programs.vesktop = {
    package = pkgs.vesktop.override {
      pnpm_10_29_2 = pkgs.pnpm_10;
    };
    enable = true;
    vencord.useSystem = true;
    vencord.settings.plugins.NoReplyMention = {
      enabled = true;
      inverseShiftReply = true;
    };
  };
}
