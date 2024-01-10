{inputs, ...}: {
  # xdg.configFile."alacritty/catppuccin-mocha.yml".source = "${inputs.catppuccin-alacritty}/catppuccin-mocha.yml";

  programs.alacritty = {
    enable = true;

    settings = {
      import = ["~/.config/alacritty/catppuccin-mocha.yml"];

      cursor.vi_mode_style = "Beam";
      mouse.hide_when_typing = true;

      font = {
        size = 10;
        normal.family = "FantasqueSansM Nerd Font";
      };
    };
  };

  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        font = "FantasqueSansM Nerd Font:size=10";
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

      # https://raw.githubusercontent.com/catppuccin/foot/main/catppuccin-mocha.conf
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

  programs.rio.enable = true;
  programs.wezterm.enable = true;
}
