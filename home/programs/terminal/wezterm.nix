{ config, lib, ... }:

let
  cfg = config.modules.wezterm;
in
{
  options.modules.wezterm.enable = lib.mkEnableOption "enable wezterm terminal";

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;

      colorSchemes = { };
      extraConfig = # lua
        ''
          return {
            front_end = "WebGpu",
            hide_tab_bar_if_only_one_tab = true
          }
        '';
    };
  };
}
