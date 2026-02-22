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
    accent = "base0B";

    stylix = {
      enable = true;

      polarity = "dark";
      base16Scheme = {
        base00 = "#000000"; # background
        base01 = "#121212"; # status
        base02 = "#1f1f1f"; # selection
        base03 = "#484848"; # comment
        base04 = "#8f8f8f"; # status fg
        base05 = "#aeaeae"; # text
        base06 = "#cecece"; # bright
        base07 = "#eeeeee"; # brightest
        base08 = "#b97d7a"; # red
        base09 = "#b68169"; # orange
        base0A = "#a18d59"; # yellow
        base0B = "#7b9a6b"; # green
        base0C = "#579e91"; # cyan
        base0D = "#5999b2"; # blue
        base0E = "#a181af"; # purple
        base0F = "#b47c91"; # hotpink
      };

      icons = {
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

        gtk = {
          flatpakSupport.enable = false;
          # fix ugly tooltips
          extraCss =
            let
              inherit (config.lib.stylix) colors;
              accent = colors.${config.accent};
            in
            # css
            ''
              @define-color accent_color #${accent};
              @define-color accent_bg_color #${accent};

              tooltip * {
                color: #${colors.base05};
              }

              tooltip.background {
                background-color: rgba(${colors.base00-rgb-r}, ${colors.base00-rgb-b}, ${colors.base00-rgb-g}, 0.9);
              }
            '';
        };
      };
    };
  };
}
