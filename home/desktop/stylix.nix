{
  config,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;

    polarity = "dark";
    base16Scheme = {
      name = "soi";

      base00 = "#161616"; # background
      base01 = "#282828"; # status
      base02 = "#3a3a3a"; # selection
      base03 = "#555555"; # comment
      base04 = "#aeaeae"; # status fg
      base05 = "#cecece"; # text
      base06 = "#dedede"; # bright
      base07 = "#eeeeee"; # brightest
      base08 = "#e69494"; # red
      base09 = "#e39a78"; # orange
      base0A = "#c6ab60"; # yellow
      base0B = "#acb66a"; # green
      base0C = "#5cc3b0"; # cyan
      base0D = "#60bbde"; # blue
      base0E = "#c69bda"; # purple
      base0F = "#e293ab"; # pink
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 24;
    };

    image = config.lib.stylix.pixel "base00";

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "sans-serif";
      };

      monospace = {
        package = pkgs.noto-fonts;
        name = "monospace";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "emoji";
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
  };

  xresources.path = "${config.xdg.configHome}/X11/xresources";
}
