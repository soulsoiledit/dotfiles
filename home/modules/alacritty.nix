{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      cursor.vi_mode_style = "Beam";
      mouse.hide_when_typing = true;

      font = {
        size = 8;
        offset.y = 0;
        normal.family = "UbuntuMono Nerd Font";
      };

      colors = let theme = (import ../../other/colors.nix).theme;
      in {
        primary = {
          background = theme.background;
          foreground = theme.foreground;
        };

        cursor = {
          text = theme.background;
          cursor = theme.foreground;
        };

        search = {
          matches = {
            background = theme.ansi.bright.yellow;
            foreground = theme.background;
          };
          focused_match = {
            background = theme.highlight;
            foreground = theme.background;
          };
        };

        vi_mode_cursor = { cursor = theme.foreground; };

        selection = {
          foreground = "CellForeground";
          background = theme.selection;
        };

        normal = {
          black = theme.ansi.normal.black;
          red = theme.ansi.normal.red;
          green = theme.ansi.normal.green;
          yellow = theme.ansi.normal.yellow;
          blue = theme.ansi.normal.blue;
          magenta = theme.ansi.normal.magenta;
          cyan = theme.ansi.normal.cyan;
          white = theme.ansi.normal.white;
        };

        bright = {
          black = theme.ansi.bright.black;
          red = theme.ansi.bright.red;
          green = theme.ansi.bright.green;
          yellow = theme.ansi.bright.yellow;
          blue = theme.ansi.bright.blue;
          magenta = theme.ansi.bright.magenta;
          cyan = theme.ansi.bright.cyan;
          white = theme.ansi.bright.white;
        };
      };
    };
  };
}
