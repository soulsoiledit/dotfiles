{...}: {
  programs.mpv.enable = true;
  programs.imv.enable = true;

  programs.xplr = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

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

      open = {
        rules = [
          {
            name = "*/";
            use = "open";
          }
          {
            mime = "text/*";
            use = "edit";
          }
          {
            mime = "application/zip";
            use = "extract";
          }
          {
            mime = "application/x-7z-compressed";
            use = "extract";
          }
          {
            mime = "application/vnd.rar";
            use = "extract";
          }
          {
            mime = "application/x-*";
            use = "untar";
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
          on = ["g" "h"];
          exec = "cd ~";
          desc = "Go to the home directory";
        }
        {
          on = ["g" "n"];
          exec = "cd /etc/nixos/";
          desc = "Go to the config directory";
        }
        {
          on = ["g" "s"];
          exec = "cd ~/stuff/pictures/screenshots/";
          desc = "Go to the screenshots directory";
        }
        {
          on = ["g" "m"];
          exec = "cd ~/.local/share/PrismLauncher/instances/Main/.minecraft/";
          desc = "Go to the MC directory";
        }
        {
          on = ["g" "r"];
          exec = "cd ~/.local/share/Trash/files";
          desc = "Go to the trash directory";
        }
        {
          on = ["g" "u"];
          exec = "cd /run/media/";
          desc = "Go to the USB directory";
        }

        # trash
        {
          on = ["'" "t"];
          exec = ["shell --block 'for file in \"$@\"; do trash-rm \"$(basename \"$file\")\"; done'"];
          desc = "Remove the files from trash";
        }
      ];
    };
  };
}
