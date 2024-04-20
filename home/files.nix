{ config, ... }:

{
  programs.mpv = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.imv = {
    enable = true;
    catppuccin.enable = true;
  };

  # add gui file manager for file opening

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    catppuccin.enable = true;

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
        rules =
          let
            # generate rules for archive files automatically
            mkMimeOpeners =
              mimeList: useList:
              map (mime: {
                mime = "${mime}";
                use = useList;
              }) mimeList;

            archiveFormats = [
              "application/zip"
              "application/gzip"
              "application/x-xz"
              "application/zstd"
              "application/x-rar"
              "application/x-7z-compressed"
            ];

            editFormats = [
              "text/*"
              "inode/x-empty"
              "application/json"
              "*/javascript"
            ];

            openFormats = [
              "image/*"
              "video/*"
              "audio/*"
            ];

            editRules = mkMimeOpeners editFormats "edit";
            openRules = mkMimeOpeners openFormats "open";
            archiveRules = mkMimeOpeners archiveFormats "extract";
          in
          editRules
          ++ openRules
          ++ archiveRules
          ++ [
            {
              name = "*/";
              use = [
                "edit"
                "open"
              ];
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
