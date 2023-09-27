{
  programs.fzf.enable = true;
  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    "_JAVA_OPTIONS" = "-Djava.util.prefs.userRoot='${config.xdg.configHome}/java'";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    NIXOS_OZONE_WL = 1;
  };

  home.sessionPath = [
    "/home/soil/.local/bin/"
    "/home/soil/.local/share/npm/bin/"
    "/home/soil/.local/share/cargo/bin/"
  ];

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
      nb = "sudo nixos-rebuild boot";
      ns = "sudo nixos-rebuild switch";
      hc = "$EDITOR /etc/nixos/home/home.nix -c 'cd /etc/nixos'";
      hs = "home-manager switch --flake /etc/nixos";
      gc = "sudo nix store gc --verbose";

      zp = "7z";

      ff = "fzf";
      de = "direnv edit .";

      btc = "bluetoothctl";

      "..." = "../..";

      lsa = "ls -a";
      lsl = "ls -l";
      lsal = "ls -al";
    };
  };
}
