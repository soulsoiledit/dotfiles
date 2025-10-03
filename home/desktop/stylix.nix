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
        base00 = "#0f0c10"; # background
        base01 = "#1b181c"; # status
        base02 = "#282429"; # selection
        base03 = "#353136"; # comment
        base04 = "#8f8a90"; # status fg
        base05 = "#c1bcc2"; # text
        base06 = "#e1dce2"; # bright
        base07 = "#f2ecf3"; # brightest
        base08 = "#c17273"; # red
        base09 = "#b97d4a"; # orange
        base0A = "#a4893e"; # yellow
        base0B = "#5d9d6b"; # green
        base0C = "#279ea4"; # cyan
        base0D = "#4796c0"; # blue
        base0E = "#a778b2"; # purple
        base0F = "#be728a"; # hotpink
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
