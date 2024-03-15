{ config, ... }:

{
  programs.foot = {
    enable = true;

    # this causes https://github.com/nix-community/home-manager/issues/3940 for some reason
    # server.enable = true;
    # potential fix (at the cost of opening urls)
    # systemd.user.services.foot.Service.Environment = "PATH=/run/current-system/sw/bin/";

    settings = {
      main = {
        font = "Fantasque Sans Mono:size=10";
        selection-target = "both";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      scrollback.lines = 10000;

      url = {
        osc8-underline = "always";
        # label-letters = "sadfjklewcmpgh.";
      };

      colors = {
        foreground = "cdd6f4";
        background = "1e1e2e";
        regular0 = "45475a";
        regular1 = "f38ba8";
        regular2 = "a6e3a1";
        regular3 = "f9e2af";
        regular4 = "89b4fa";
        regular5 = "f5c2e7";
        regular6 = "94e2d5";
        regular7 = "bac2de";
        bright0 = "585b70";
        bright1 = "f38ba8";
        bright2 = "a6e3a1";
        bright3 = "f9e2af";
        bright4 = "89b4fa";
        bright5 = "f5c2e7";
        bright6 = "94e2d5";
        bright7 = "a6adc8";
      };
    };
  };
}
