{ pkgs, lib, config, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "FantasqueSansM Nerd Font Propo:size=12";
        prompt = "_ ";
        icon-theme = "Papirus-Dark";
        terminal = "alacritty -e";

        width = 30;
        horizontal-pad = 20;
        lines = 8;
        line-height = 25;
      };

      border = {
        width = 1;
        radius = 15;
      };

      colors = {
        background = "1e1e2eff";
        text = "cdd6f4ff";
        border = "89b4faff";

        selection = "313244ff";
        selection-text = "cdd6f4ff";

        selection-match = "a6e3a1ff";
        match = "a6e3a1ff";
      };
    };
  };

  # programs.wofi.enable = true;
}
