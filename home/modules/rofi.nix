{ pkgs, lib, config, ... }:

{
  programs.rofi = {
    enable = true;

    font = "UbuntuMono Nerd Font 14";
    lines = 10;
    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      display-drun = " ";
      show-icons = true;
    };

    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
        # # gruvbox-material {{{
        # background = "#1d2021";
        # foreground = "#d4be98";
        # selection = "#3c3836";
        # bar = "#a9b665";
        # # }}}
        # iceberg {{{
        background = "#191724";
        foreground = "#c6c8d1";
        selection = "#272c42";
        bar = "#84a0c6";
        # }}}
        # # amora {{{
        # background = "#2a2331";
        # foreground = "#dedbeb";
        # selection = "#634e75";
        # bar = "#edabd2";
        # # }}}
    in {
      "*" = {
        background-color =    mkLiteral background;
        text-color =          mkLiteral foreground;
        spacing =             0;
      };

      "window" = {
          border =            mkLiteral "0px";
      };

      "element" = {
        padding =             mkLiteral "0.5%";
      };

      "element-icon" = {
        size =                mkLiteral "2ch";
      };

      "element selected" = {
        background-color =    mkLiteral selection;
      };

      "inputbar" = {
          children =          map mkLiteral [ "prompt" "entry" ];
          background-color =  mkLiteral bar;
          padding =           mkLiteral "0.5% 0";
      };

      "entry" = {
          background-color =  mkLiteral "#0000";
          text-color =        mkLiteral background;
      };

      "prompt" = {
          background-color =  mkLiteral "#0000";
          text-color =        mkLiteral background;
          padding =           mkLiteral "0 0.5%";
      };
    };
  };
}
