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
          desc = "go to the home directory";
        }
        {
          on = [
            "g"
            "n"
          ];
          run = "cd ~/code/dotfiles/";
          desc = "go to the nix config directory";
        }
        {
          on = [
            "g"
            "s"
          ];
          run = "cd ~/pictures/screenshots/";
          desc = "Go to the screenshots directory";
        }
        {
          on = [
            "g"
            "m"
          ];
          run = "cd ~/.local/share/PrismLauncher/instances/Main/.minecraft/";
          desc = "go to the mc directory";
        }
        {
          on = [
            "g"
            "t"
          ];
          run = "cd ~/.local/share/Trash/files";
          desc = "go to the trash directory";
        }
        {
          on = [
            "g"
            "u"
          ];
          run = "cd /run/media/";
          desc = "go to the usb directory";
        }
        {
          on = [
            "g"
            "a"
          ];
          run = "cd /nix/store/";
          desc = "go to the nix store";
        }

        # compress
        {
          on = [
            "c"
            "a"
          ];
          run = "plugin compress";
          desc = "archive selected files";
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
