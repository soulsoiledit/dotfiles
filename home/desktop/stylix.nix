{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [ inputs.stylix.homeModules.stylix ];

  options.accent = lib.mkOption {
    type = lib.types.str;
    description = "primary accent color";
  };

  config = {
    accent = config.lib.stylix.colors.base0D;

    stylix = {
      enable = true;

      polarity = "dark";
      base16Scheme = {
        name = "soi";

        base00 = "#0b0b0b"; # background
        base01 = "#1c1c1c"; # status
        base02 = "#2e2e2e"; # selection
        base03 = "#414141"; # comment
        base04 = "#a6a6a6"; # status fg
        base05 = "#bebebe"; # text
        base06 = "#d6d6d6"; # bright
        base07 = "#eeeeee"; # brightest
        base08 = "#c87180"; # red
        base09 = "#c67854"; # orange
        base0A = "#b08836"; # yellow
        base0B = "#719e58"; # green
        base0C = "#24a592"; # cyan
        base0D = "#2d9dc1"; # blue
        base0E = "#b177b4"; # purple
        base0F = "#c0729c"; # pink
      };

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
        sansSerif.name = "sans-serif";
        serif.name = "serif";
        monospace.name = "monospace";
        emoji.name = "emoji";

        sizes = {
          applications = 10;
          terminal = 12;
        };
      };

      targets = {
        qt.enable = true;
        firefox.enable = false;

        gtk = {
          flatpakSupport.enable = false;
          # fix ugly tooltips
          extraCss =
            with config.lib.stylix.colors;
            # css
            ''
              tooltip * {
                color: #${base05};
              }

              tooltip.background {
                background-color: rgba(${base00-rgb-r}, ${base00-rgb-b}, ${base00-rgb-g}, 0.9);
              }
            '';
        };
      };
    };
  };
}
