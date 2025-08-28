{ config, pkgs, ... }:

{
  programs.mpv.enable = true;
  programs.imv.enable = true;

  programs.yazi = {
    enable = true;
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
      # goto
      {
        on = [
          "g"
          "n"
        ];
        run = "cd ${config.flake}";
        desc = "nix config";
      }

      {
        on = [
          "g"
          "m"
        ];
        run = "cd $XDG_DATA_HOME/PrismLauncher/instances/";
        desc = "minecraft";
      }

      {
        on = [
          "g"
          "u"
        ];
        run = "cd /run/media/$USER";
        desc = "usb";
      }

      # compress
      {
        on = [
          "c"
          "a"
        ];
        run = "plugin ouch tar.zst";
        desc = "create archive";
      }

      # drag & drop
      {
        on = [
          "c"
          "o"
        ];
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
    ];
  };
}
