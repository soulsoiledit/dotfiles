{
  config,
  lib,
  pkgs,
  ...
}:

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

    theme =
      let
        inherit (config.lib.stylix.colors) withHashtag;
        mkFg = fg: { inherit fg; };
        mkBg = bg: { inherit bg; };
        mkBoth = fg: bg: { inherit fg bg; };
      in
      {
        indicator.current = mkBg withHashtag.base02 // {
          bold = true;
        };
        indicator.preview = mkBg withHashtag.base02 // {
          bold = true;
        };

        cmp = {
          border = mkFg withHashtag.blue;
          active = mkBoth withHashtag.magenta withHashtag.base03;
          inactive = mkFg withHashtag.base05;
        };

        filetype.rules = lib.mkBefore [
          {
            url = "*/";
            fg = withHashtag.blue;
            bold = config.stylix.targets.yazi.boldDirectory;
          }
        ];
      };
  };
}
