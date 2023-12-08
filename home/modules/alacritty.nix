{inputs, ...}: {
  xdg.configFile."alacritty/catppuccin-mocha.yml".source = "${inputs.catppuccin-alacritty}/catppuccin-mocha.yml";

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

  programs.wezterm.enable = true;
  programs.kitty.enable = true;
}
