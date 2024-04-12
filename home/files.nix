{ config, ... }:

{
  programs.mpv.enable = true;
  programs.imv.enable = true;

  # add gui file manager for file opening

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    theme = {
      manager = {
        cwd = {
          fg = "#94e2d5";
        };

        # Hovered
        hovered = {
          fg = "#1e1e2e";
          bg = "#89b4fa";
        };
        preview_hovered = {
          underline = true;
        };

        # Find
        find_keyword = {
          fg = "#f9e2af";
          italic = true;
        };
        find_position = {
          fg = "#f5c2e7";
          bg = "reset";
          italic = true;
        };

        # Marker
        marker_copied = {
          fg = "#a6e3a1";
          bg = "#a6e3a1";
        };
        marker_cut = {
          fg = "#f38ba8";
          bg = "#f38ba8";
        };
        marker_selected = {
          fg = "#89b4fa";
          bg = "#89b4fa";
        };

        # Tab
        tab_active = {
          fg = "#1e1e2e";
          bg = "#cdd6f4";
        };
        tab_inactive = {
          fg = "#cdd6f4";
          bg = "#45475a";
        };
        tab_width = 1;

        # Count
        count_copied = {
          fg = "#1e1e2e";
          bg = "#a6e3a1";
        };
        count_cut = {
          fg = "#1e1e2e";
          bg = "#f38ba8";
        };
        count_selected = {
          fg = "#1e1e2e";
          bg = "#89b4fa";
        };

        # Border
        border_symbol = "│";
        border_style = {
          fg = "#7f849c";
        };

        # Highlighting
        syntect_theme = "${config.xdg.configHome}/bat/themes/Catppuccin Mocha.tmTheme";
      };

      status = {
        separator_open = "";
        separator_close = "";
        separator_style = {
          fg = "#45475a";
          bg = "#45475a";
        };

        # Mode
        mode_normal = {
          fg = "#1e1e2e";
          bg = "#89b4fa";
          bold = true;
        };
        mode_select = {
          fg = "#1e1e2e";
          bg = "#a6e3a1";
          bold = true;
        };
        mode_unset = {
          fg = "#1e1e2e";
          bg = "#f2cdcd";
          bold = true;
        };

        # Progress
        progress_label = {
          fg = "#ffffff";
          bold = true;
        };
        progress_normal = {
          fg = "#89b4fa";
          bg = "#45475a";
        };
        progress_error = {
          fg = "#f38ba8";
          bg = "#45475a";
        };

        # Permissions
        permissions_t = {
          fg = "#89b4fa";
        };
        permissions_r = {
          fg = "#f9e2af";
        };
        permissions_w = {
          fg = "#f38ba8";
        };
        permissions_x = {
          fg = "#a6e3a1";
        };
        permissions_s = {
          fg = "#7f849c";
        };
      };

      input = {
        border = {
          fg = "#89b4fa";
        };
        title = { };
        value = { };
        selected = {
          reversed = true;
        };
      };

      select = {
        border = {
          fg = "#89b4fa";
        };
        active = {
          fg = "#f5c2e7";
        };
        inactive = { };
      };
      tasks = {
        border = {
          fg = "#89b4fa";
        };
        title = { };
        hovered = {
          underline = true;
        };
      };
      which = {
        mask = {
          bg = "#313244";
        };
        cand = {
          fg = "#94e2d5";
        };
        rest = {
          fg = "#9399b2";
        };
        desc = {
          fg = "#f5c2e7";
        };
        separator = "  ";
        separator_style = {
          fg = "#585b70";
        };
      };
      help = {
        on = {
          fg = "#f5c2e7";
        };
        exec = {
          fg = "#94e2d5";
        };
        desc = {
          fg = "#9399b2";
        };
        hovered = {
          bg = "#585b70";
          bold = true;
        };
        footer = {
          fg = "#45475a";
          bg = "#cdd6f4";
        };
      };
      filetype = {

        rules = [
          # Images
          {
            mime = "image/*";
            fg = "#94e2d5";
          }

          # Videos
          {
            mime = "video/*";
            fg = "#f9e2af";
          }
          {
            mime = "audio/*";
            fg = "#f9e2af";
          }

          # Archives
          {
            mime = "application/zip";
            fg = "#f5c2e7";
          }
          {
            mime = "application/gzip";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-tar";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-bzip";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-bzip2";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-7z-compressed";
            fg = "#f5c2e7";
          }
          {
            mime = "application/x-rar";
            fg = "#f5c2e7";
          }

          # Fallback
          {
            name = "*";
            fg = "#cdd6f4";
          }
          {
            name = "*/";
            fg = "#89b4fa";
          }
        ];
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
