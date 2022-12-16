{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit =
      # ts
      ''
        bind \cn fzf-cd-widget

        set fish_color_autosuggestion brblack
        set fish_color_cancel -r
        set fish_color_command magenta
        set fish_color_comment brblack
        set fish_color_cwd green
        set fish_color_cwd_root red
        set fish_color_end blue
        set fish_color_error yellow
        set fish_color_escape cyan
        set fish_color_history_current --bold
        set fish_color_host normal
        set fish_color_host_remote yellow
        set fish_color_match black --background=blue
        set fish_color_normal normal
        set fish_color_operator cyan
        set fish_color_param white
        set fish_color_quote green
        set fish_color_redirection magenta
        set fish_color_search_match --background=brblack
        set fish_color_selection -r
        set fish_color_status red
        set fish_color_user brgreen
        set fish_color_valid_path --underline
        set fish_pager_color_completion normal
        set fish_pager_color_description green
        set fish_pager_color_prefix --bold --underline
        set fish_pager_color_progress black --background=green
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

    shellAliases = {
      v = "$EDITOR";
      s = "sudo";

      bt = "btop";
      btc = "bluetoothctl";

      ff = "fzf";
      de = "direnv edit .";
      g = "git";

      nc = "$EDITOR /etc/nixos/system/configuration.nix -c 'cd /etc/nixos'";
      ns = "sudo nixos-rebuild switch";
      hc = "$EDITOR /etc/nixos/home/home.nix -c 'cd /etc/nixos'";
      hs = "home-manager switch --flake /etc/nixos";
      gc = "nix store gc";

      ls = "ls -h --color";
      lsa = "ls -Ah --color";
      "..." = "../..";

      tp = "trash-put";
      trm = "trash-rm";
      trs = "trash-restore";
      tcd = "cd ~/.local/share/Trash/files/";

      vol = "pactl set-sink-volume @DEFAULT_SINK@";
      volm = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
    };
  };
}
