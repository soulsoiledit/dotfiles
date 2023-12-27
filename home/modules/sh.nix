{
  inputs,
  config,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };

  home.sessionPath = [
    "/home/soil/.local/bin/"
    "/home/soil/.local/share/npm/bin/"
    "/home/soil/.local/share/cargo/bin/"
  ];

  programs.starship.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit =
      /*
      fish
      */
      ''
        set fish_greeting
        fish_config theme choose "Catppuccin Mocha"
        bind \cn fzf-cd-widget
      '';

    shellAbbrs = {
      v = "nvim";
      s = "sudo";
      f = "ya";
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

      "..." = "../..";
    };
  };
}
