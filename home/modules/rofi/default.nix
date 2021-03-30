{ pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;

    font = "UbuntuMono Nerd Font 14";
    lines = 10;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "theme";

    extraConfig = {
      display-combi = "> ";
      drun-display-format = "{icon} {name}";
      show-icons = true;
      combi-hide-mode-prefix = true;
    };
  };

  xdg.dataFile."rofi/themes/theme.rasi".source = ./theme.rasi;
}
