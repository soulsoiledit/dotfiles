{ config, ... }:

let
  inherit (config.lib.stylix.colors) withHashtag;
in
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    themes = {
      stylix = {
        meta = {
          name = "Stylix";
          version = "1.0.0";
          variant = "dark";
          description = "Generated from stylix colors";
        };
        colors = {
          core = {
            accent = withHashtag.base0D;
            accent_foreground = withHashtag.base00;
            background = withHashtag.base00;
            foreground = withHashtag.base05;
            secondary_background = withHashtag.base01;
            border = withHashtag.base01;
          };
          accents = {
            red = withHashtag.base08;
            orange = withHashtag.base09;
            yellow = withHashtag.base0A;
            green = withHashtag.base0B;
            cyan = withHashtag.base0C;
            blue = withHashtag.base0D;
            purple = withHashtag.base0E;
            magenta = withHashtag.base0F;
          };
        };
      };
    };
  };
}
