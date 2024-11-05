{ config, lib, ... }:
let
  cfg = config.modules.foot;
in
{
  options.modules.foot.enable = lib.mkEnableOption "enable foot terminal";

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        main = {
          selection-target = "both";
          pad = "5x5 center";
        };

        mouse = {
          hide-when-typing = "yes";
        };

        scrollback.lines = 10000;

        url = {
          osc8-underline = "always";
          label-letters = "arstneiowfpluyxcdhgm";
        };
      };
    };
  };
}
