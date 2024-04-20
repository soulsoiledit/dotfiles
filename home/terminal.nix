{ config, ... }:

{
  programs.foot = {
    enable = true;

    # this causes https://github.com/nix-community/home-manager/issues/3940 for some reason
    # server.enable = true;
    # potential fix (at the cost of opening urls)
    # systemd.user.services.foot.Service.Environment = "PATH=/run/current-system/sw/bin/";
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
