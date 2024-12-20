{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.wezterm;
in
{
  options.modules.wezterm.enable = lib.mkEnableOption "enable wezterm terminal";

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      # TODO: reenable after resizing works again
      # enable = true;
      package = inputs.wezterm.packages.${pkgs.system}.default;

      colorSchemes = { };
      extraConfig = # lua
        ''
          return {
            font = wezterm.font_with_fallback {
              "monospace",
              "Symbols Nerd Font",
              "Twitter Color Emoji",
              "Roboto Mono",
              "Noto Sans Mono CJK SC",
              "Noto Sans Mono CJK JP",
              "Noto Sans Mono CJK KR",
              "Noto Sans Mono",
            },

            hide_tab_bar_if_only_one_tab = true
          }
        '';
    };
  };
}
