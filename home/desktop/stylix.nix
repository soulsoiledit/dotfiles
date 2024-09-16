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

    base16Scheme = {
      name = "soi";

      base00 = "#0b0b0b"; # background
      base01 = "#1c1c1c"; # status
      base02 = "#2e2e2e"; # selection
      base03 = "#414141"; # comment
      base04 = "#717171"; # status fg
      base05 = "#aeaeae"; # text
      base06 = "#cecece"; # bright
      base07 = "#eeeeee"; # brightest
      base08 = "#fe838f"; # red
      base09 = "#f88f4f"; # orange
      base0A = "#e99b2a"; # yellow
      base0B = "#83c25c"; # green
      base0C = "#00cbc3"; # cyan
      base0D = "#00c0f5"; # blue
      base0E = "#e289db"; # purple
      base0F = "#f982aa"; # pink
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 24;
    };

    image = ./wallpaper.png;

    fonts = {
      serif = {
        package = pkgs.roboto-slab;
        name = "Roboto Slab";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
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
