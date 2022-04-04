{ pkgs, lib, config, ... }:

{
  programs.rofi = {
    enable = true;

    font = "UbuntuMono Nerd Font 12";
    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      show-icons = true;
      display-drun = " ";
      drun-display-format = "{name}";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      theme = (import ../../other/colors.nix).theme;
    in {
      "*" = {
        background-color = mkLiteral "#00000000";
        text-color = mkLiteral theme.background;
      };

      "window" = {
        background-color = mkLiteral theme.background;
        text-color = mkLiteral theme.foreground;
        width = mkLiteral "20%";
      };

      "prompt" = {
        enabled = mkLiteral "true";
        padding = mkLiteral "0.30% 1% 0% -0.5%";
      };

      "inputbar" = {
        background-color = mkLiteral theme.highlight;
        padding = mkLiteral "1.5%";
      };

      "listview" = {
        padding = mkLiteral "0px";
        lines = 5;
      };

      "element" = { padding = mkLiteral "1% 0.5%"; };

      "element-icon" = { size = mkLiteral "32px"; };

      "element-text" = {
        text-color = mkLiteral theme.foreground;
        vertical-align = mkLiteral "0.5";
        margin = mkLiteral "1% 0.25%";
      };

      "element selected" = { background-color = mkLiteral theme.selection; };
    };
  };
}
