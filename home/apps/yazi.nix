{
  config,
  lib,
  pkgs,
  ...
}:

let
  expand = lib.strings.stringToCharacters;
in
{
  programs.mpv.enable = true;
  programs.imv.enable = true;

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    package = pkgs.yazi.override {
      extraPackages = builtins.attrValues {
        inherit (pkgs)
          exiftool
          mediainfo
          ripdrag
          ouch
          ;
      };
    };

    plugins.ouch = pkgs.yaziPlugins.ouch;

    settings = {
      mgr.sort_by = "natural";
      preview.wrap = "yes";
    };

    keymap.mgr.prepend_keymap = [
      {
        on = expand "gn";
        run = "cd ${config.flake}";
        desc = "nix config";
      }

      {
        on = expand "gu";
        run = "cd /run/media/$USER";
        desc = "usb";
      }

      {
        on = expand "ca";
        run = "plugin ouch tar.zst";
        desc = "create archive";
      }

      {
        on = expand "co";
        run = ''shell 'ripdrag -a -x "$@"' --block'';
        desc = "drag and drop";
      }

      # reverse upstream changes
      {
        on = "z";
        run = "plugin zoxide";
      }

      {
        on = "Z";
        run = "plugin fzf";
      }

      {
        on = "!";
        run = ''shell "$SHELL" --block'';
        desc = "open $SHELL here";
      }
    ];
  };
}
