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
        base00 = "#101010"; # background
        base01 = "#1a1a1a"; # status
        base02 = "#242424"; # selection
        base03 = "#393939"; # comment
        base04 = "#aeaeae"; # status fg
        base05 = "#bebebe"; # text
        base06 = "#dedede"; # bright
        base07 = "#eeeeee"; # brightest
        base08 = "#c4757b"; # red
        base09 = "#bc804d"; # orange
        base0A = "#a78c41"; # yellow
        base0B = "#6e9e63"; # green
        base0C = "#38a391"; # cyan
        base0D = "#5197c6"; # blue
        base0E = "#9981c3"; # purple
        base0F = "#bb769d"; # pink
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
        fontconfig.enable = false;

        firefox.enable = false;
        neovim.enable = false;
        spicetify.enable = false;
        vesktop.enable = false;

        gtk = {
          flatpakSupport.enable = false;
          # fix ugly tooltips
          extraCss =
            let
              inherit (config.lib.stylix) colors;
            in
            # css
            ''
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
