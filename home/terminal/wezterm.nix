{ inputs, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;

    colorSchemes = { };
    extraConfig = # lua
      ''
        return {
          color_scheme = "Catppuccin Mocha",

          font_size = 12,
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

          line_height = 0.9,

          hide_tab_bar_if_only_one_tab = true
        }
      '';
  };
}
