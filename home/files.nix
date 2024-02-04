{ ... }:
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
        syntect_theme = "~/.config/bat/themes/Catppuccin-mocha.tmTheme";
      };
    };

    settings = {
      manager = {
        sort_by = "alphabetical";
        sort_reverse = false;
        sort_sensitive = false;
      };

      opener = {
        edit = [
          {
            exec = ''$EDITOR "$@"'';
            block = true;
          }
        ];
        open = [
          {
            exec = ''xdg-open "$@"'';
            desc = "Open";
          }
        ];
        untar = [
          {
            exec = ''tar axvf "$1"'';
            desc = "Extract tarballs";
          }
        ];
        extract = [
          {
            exec = ''7z -y x "$1" -o\*'';
            desc = "Extract other archives";
          }
        ];
      };

      # TODO: make sure extraction binds are working properly
      # create/find archive keybind
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
          exec = "cd ~";
          desc = "Go to the home directory";
        }
        {
          on = [
            "g"
            "n"
          ];
          exec = "cd ~/code/dotfiles/";
          desc = "Go to the config directory";
        }
        {
          on = [
            "g"
            "s"
          ];
          exec = "cd ~/pictures/screenshots/";
          desc = "Go to the screenshots directory";
        }
        {
          on = [
            "g"
            "m"
          ];
          exec = "cd ~/.local/share/PrismLauncher/instances/Main/.minecraft/";
          desc = "Go to the MC directory";
        }
        {
          on = [
            "g"
            "r"
          ];
          exec = "cd ~/.local/share/Trash/files";
          desc = "Go to the trash directory";
        }
        {
          on = [
            "g"
            "u"
          ];
          exec = "cd /run/media/";
          desc = "Go to the USB directory";
        }

        # trash
        {
          on = [
            "'"
            "t"
          ];
          exec = [ "shell --block 'for file in \"$@\"; do trash-rm \"$(basename \"$file\")\"; done'" ];
          desc = "Remove the files from trash";
        }
      ];
    };
  };
}
