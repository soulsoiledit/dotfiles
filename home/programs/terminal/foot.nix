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
          pad = "10x10";
        };

        scrollback.lines = 4096;

        mouse.hide-when-typing = true;

        url = {
          osc8-underline = "always";
          label-letters = "arstneiodhwfuy";
        };
      };
    };
  };
}
