{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit =
      ''
        bind \cn fzf-cd-widget

        set fish_greeting
        fish_config theme choose "Catppuccin Mocha"
      '';

    functions = {
      f = ''
        set tmp (mktemp)
          lf -last-dir-path=$tmp $argv
          if test -f "$tmp"
            set dir (cat $tmp)
            rm -f $tmp
            if test -d "$dir"
              if test "$dir" != (pwd)
              cd $dir
            end
          end
        end
      '';
    };

    shellAbbrs = {
      v = "nvim";
      s = "sudo";

      bt = "btop";

      g = "git";

      tp = "trash-put";
      td = "trash-rm";
      ts = "trash-restore";
      tf = "cd ~/.local/share/Trash/files/";

      nc = "$EDITOR /etc/nixos/system/configuration.nix -c 'cd /etc/nixos'";
      ns = "sudo nixos-rebuild switch";
      hc = "$EDITOR /etc/nixos/home/home.nix -c 'cd /etc/nixos'";
      hs = "home-manager switch --flake /etc/nixos";
      gc = "nix store gc";
    };

    shellAliases = {
      btc = "bluetoothctl";

      ff = "fzf";
      de = "direnv edit .";


      ls = "ls -h --color";
      lh = "ls -Ah --color";
      "..." = "../..";
    };
  };
}
