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

      base00 = "#0d120f"; # background
      base01 = "#19241e"; # status
      base02 = "#2c3831"; # selection
      base03 = "#3e4b43"; # comment
      base04 = "#67756d"; # status fg
      base05 = "#abbab1"; # text
      base06 = "#c3d2c9"; # bright
      base07 = "#dcebe2"; # brightest
      base08 = "#ff8a82"; # red
      base09 = "#ff8f53"; # orange
      base0A = "#bfbe00"; # yellow
      base0B = "#2ed86c"; # green
      base0C = "#00d1dc"; # cyan
      base0D = "#69bbff"; # blue
      base0E = "#c69cff"; # purple
      base0F = "#ff82b1"; # pink
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 24;
    };

    image = config.lib.stylix.pixel "base00";

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
