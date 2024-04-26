{ config, ... }:

{
  programs.foot = {
    enable = true;

    catppuccin.enable = true;

    settings = {
      main = {
        font = "Fantasque Sans Mono:size=10";
        selection-target = "both";
        # pad = "20x20";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      scrollback.lines = 10000;

      url = {
        osc8-underline = "always";
        # label-letters = "sadfjklewcmpgh.";
      };
    };
  };

  programs.wezterm.enable = false;
}
