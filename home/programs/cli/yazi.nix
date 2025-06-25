{
  config,
  inputs,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    file
    exiftool
    ripdrag

    p7zip
    zip
  ];

  programs = {
    zathura.enable = true;
    mpv.enable = true;
    imv.enable = true;

    yazi = {
      enable = true;
      enableFishIntegration = true;

      plugins = {
        compress = inputs.compress-yazi;
      };

      settings = {
        mgr.sort_by = "natural";
        preview.wrap = "yes";
        open.prepend_rules = [
          {
            mime = "application/java-archive";
            use = [
              "open"
              "extract"
              "reveal"
            ];
          }
        ];
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
          run = "plugin compress";
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
  };
}
