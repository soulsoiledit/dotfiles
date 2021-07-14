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
        theme = (import ../../other/colors.nix).theme;
    in {
      "*" = {
        background-color =    mkLiteral theme.background;
        text-color =          mkLiteral theme.foreground;
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
        background-color =    mkLiteral theme.selection;
      };

      "inputbar" = {
          children =          map mkLiteral [ "prompt" "entry" ];
          background-color =  mkLiteral theme.highlight;
          padding =           mkLiteral "0.5% 0";
      };

      "entry" = {
          background-color =  mkLiteral "#0000";
          text-color =        mkLiteral theme.background;
      };

      "prompt" = {
          background-color =  mkLiteral "#0000";
          text-color =        mkLiteral theme.background;
          padding =           mkLiteral "0 0.5%";
      };
    };
  };
}
