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

    image = config.lib.stylix.pixel "base00";

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 24;
    };

    fonts = {
      sansSerif = {
        package = pkgs.hello;
        name = "sans-serif";
      };

      serif = {
        package = config.stylix.fonts.sansSerif.package;
        name = "serif";
      };

      monospace = {
        package = config.stylix.fonts.sansSerif.package;
        name = "monospace";
      };

      emoji = {
        package = config.stylix.fonts.sansSerif.package;
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
}
