rec {
  theme = catppuccin;

  gruvbox-material = {
    background = "#1d2021";
    foreground = "#d4be98";
    selection = "#3c3836";
    comment = "#7c6f64";
    highlight = "#a9b665";

    ansi = {
      normal = {
        black = "#1d2021";
        red = "#ea6962";
        green = "#a9b665";
        yellow = "#d8a657";
        blue = "#7daea3";
        magenta = "#d3869b";
        cyan = "#89b482";
        white = "#d4be98";
      };

      bright = {
        black = "#7c6f64";
        red = "#ea6962";
        green = "#a9b665";
        yellow = "#d8a657";
        blue = "#7daea3";
        magenta = "#d3869b";
        cyan = "#89b482";
        white = "#d4be98";
      };
    };
  };

  gruvbox-flat = {
    background = "#1d2021";
    foreground = "#d4be98";
    selection = "#3c3836";
    comment = "#7c6f64";
    highlight = "#a9b665";

    ansi = {
      normal = {
        black = "#1d2021";
        red = "#ea6962";
        green = "#a9b665";
        yellow = "#d8a657";
        blue = "#7daea3";
        magenta = "#d3869b";
        cyan = "#89b482";
        white = "#d4be98";
      };

      bright = {
        black = "#7c6f64";
        red = "#ea6962";
        green = "#a9b665";
        yellow = "#d8a657";
        blue = "#7daea3";
        magenta = "#d3869b";
        cyan = "#89b482";
        white = "#d4be98";
      };
    };
  };

  catppuccin = {
    name = "catppuccin";
    background = "#1e1e2e";
    foreground = "#cdd6f4";
    selection = "#45475a";
    comment = "#585b70";
    highlight = catppuccin.ansi.bright.magenta;

    ansi = {
      normal = {
        black = "#45475a"; # surface1
        red = "#f38ba8"; # red
        green = "#a6e3a1"; # green
        yellow = "#f9e2af"; # yellow
        blue = "#89b4fa"; # blue
        magenta = "#f5c2e7"; # pink
        cyan = "#94e2d5"; # teal
        white = "#bac2de"; # subtext1
      };

      bright = {
        black = "#585b70"; # surface2
        red = "#f38ba8"; # red
        green = "#a6e3a1"; # green
        yellow = "#f9e2af"; # yellow
        blue = "#89b4fa"; # blue
        magenta = "#f5c2e7"; # pink
        cyan = "#94e2d5"; # teal
        white = "#a6adc8"; # subtext0
      };
    };
  };
}
