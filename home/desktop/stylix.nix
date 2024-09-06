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
      base00 = "#090B0F";
      base01 = "#14161A";
      base02 = "#1F2226";
      base03 = "#383B3F";
      base04 = "#8d8f95";
      base05 = "#BBBDC4";
      base06 = "#CBCED4";
      base07 = "#DBDEE5";
      base08 = "#B1667E";
      base09 = "#B16C4C";
      base0A = "#977D30";
      base0B = "#668E4F";
      base0C = "#239382";
      base0D = "#2B8CAD";
      base0E = "#697DBC";
      base0F = "#976DA9";
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 24;
    };

    image = ../astro-jelly.jpg;

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
