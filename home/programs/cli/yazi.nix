{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-utils
    exiftool
    zip
    p7zip
    ripdrag
  ];

  programs = {
    zathura.enable = true;
    mpv.enable = true;
    imv.enable = true;

    yazi = {
      enable = true;
      enableFishIntegration = true;

      plugins = {
        compress = pkgs.fetchFromGitHub {
          owner = "KKV9";
          repo = "compress.yazi";
          rev = "main";
          hash = "sha256-Yf5R3H8t6cJBMan8FSpK3BDSG5UnGlypKSMOi0ZFqzE=";
        };
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
            mime = "application/zstd";
            use = [
              "extract"
              "reveal"
            ];
          }
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
      ];
    };
  };
}
