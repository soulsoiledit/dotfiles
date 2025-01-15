{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

with lib;
{
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  options.opt.accent = mkOption {
    type = types.str;
    description = "primary accent color";
  };

  config = {
    opt.accent = config.lib.stylix.colors.base0D;

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

      image = config.lib.stylix.pixel "base00";
      imageScalingMode = "center";

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
          terminal = 11;
        };
      };

      targets.gtk = {
        flatpakSupport.enable = false;
        # fix ugly tooltips
        extraCss = # css
          ''
            tooltip * {
              color: @window_fg_color;
            }

            tooltip.background {
              background-color: transparentize(@window_bg_color, 0.2);
            }
          '';
      };
    };
  };
}
