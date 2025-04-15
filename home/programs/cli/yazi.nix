{ pkgs, inputs, ... }:

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
        manager = {
          sort_by = "natural";
          sort_translit = true;
        };

        preview = {
          wrap = "yes";
        };

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

      keymap.manager.prepend_keymap = [
        # goto
        {
          on = [
            "g"
            "h"
          ];
          run = "cd ~";
          desc = "home";
        }
        {
          on = [
            "g"
            "n"
          ];
          run = "cd ~/code/dotfiles/";
          desc = "nix config";
        }
        {
          on = [
            "g"
            "s"
          ];
          run = "cd ~/pictures/screenshots/";
          desc = "screenshots";
        }
        {
          on = [
            "g"
            "m"
          ];
          run = "cd ~/.local/share/PrismLauncher/instances/";
          desc = "minecraft";
        }
        {
          on = [
            "g"
            "t"
          ];
          run = "cd ~/.local/share/Trash/files";
          desc = "trash";
        }
        {
          on = [
            "g"
            "u"
          ];
          run = "cd /run/media/";
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
