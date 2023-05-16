{ pkgs, inputs, ... }:

{

  xdg.configFile."alacritty/catppuccin-mocha.yml".source = "${inputs.catppuccin-alacritty}/catppuccin-mocha.yml";

  programs.alacritty = {
    enable = true;

    settings = {
      import = [ "~/.config/alacritty/catppuccin-mocha.yml" ];

      cursor.vi_mode_style = "Beam";
      mouse.hide_when_typing = true;

      font = {
        size = 8;
        normal.family = "FantasqueSansMono Nerd Font";
      };
    };
  };
}
