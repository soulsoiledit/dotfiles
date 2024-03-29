{ config, ... }:

{
  programs.mpv.enable = true;
  programs.imv.enable = true;

  programs.xplr = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    theme = {
      manager = {
        syntect_theme = "${config.xdg.configHome}/bat/themes/Catppuccin-mocha.tmTheme";
      };
    };

    settings = {
      manager = {
        sort_dir_first = true;
      };

      opener = {
        edit = [
          {
            run = ''$EDITOR "$@"'';
            block = true;
          }
        ];
        open = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open";
          }
        ];
        untar = [
          {
            run = ''tar axvf "$1" --one-top-level'';
            desc = "Extract tarballs";
          }
        ];
        extract = [
          {
            run = ''7z -y x "$1" -spe -o\*'';
            desc = "Extract other archives";
          }
        ];
      };

      # TODO: create/find archive keybind
      open = {
        rules = [
          {
            name = "*/";
            use = [
              "edit"
              "open"
            ];
          }

          {
            mime = "text/*";
            use = "edit";
          }

          {
            mime = "inode/x-empty";
            use = "edit";
          }

          {
            mime = "application/json";
            use = "edit";
          }

          {
            mime = "*/javascript";
            use = "edit";
          }

          {
            mime = "image/*";
            use = "open";
          }

          {
            mime = "video/*";
            use = "open";
          }

          {
            mime = "audio/*";
            use = "open";
          }

          {
            mime = "application/zip";
            use = "extract";
          }

          {
            mime = "application/gzip";
            use = "untar";
          }

          {
            mime = "application/x-xz";
            use = "untar";
          }

          {
            mime = "application/zstd";
            use = "untar";
          }

          {
            mime = "application/x-rar";
            use = "extract";
          }

          {
            mime = "application/x-7z-compressed";
            use = "extract";
          }

          {
            mime = "application/java-archive";
            use = [
              "open"
              "extract"
            ];
          }

          {
            mime = "*";
            use = "open";
          }
        ];
      };
    };

    keymap = {
      manager.append_keymap = [
        # Goto
        {
          on = [
            "g"
            "h"
          ];
          run = "cd ~";
          desc = "Go to the home directory";
        }

        {
          on = [
            "g"
            "n"
          ];
          run = "cd ~/code/dotfiles/";
          desc = "Go to the config directory";
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
          desc = "Go to the MC directory";
        }

        {
          on = [
            "g"
            "r"
          ];
          run = "cd ~/.local/share/Trash/files";
          desc = "Go to the trash directory";
        }

        {
          on = [
            "g"
            "u"
          ];
          run = "cd /run/media/";
          desc = "Go to the USB directory";
        }

        # trash
        {
          on = [
            "'"
            "t"
          ];
          run = [ "shell --block 'for file in \"$@\"; do trash-rm \"$(basename \"$file\")\"; done'" ];
          desc = "Remove the files from trash";
        }
      ];
    };
  };
}
