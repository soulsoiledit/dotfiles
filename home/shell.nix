{ config, pkgs, ... }:

{
  home.sessionVariables = {
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${config.xdg.configHome}"/java'';
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.xdg.dataHome}/cargo/bin"
  ];

  home.packages = with pkgs; [
    tmux

    # modern unix replacements
    dua
    du-dust
    duf

    # qol
    p7zip
    trash-cli
    xdg-utils

    steam-run
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    fd.enable = true;
    fzf.enable = true;
    jq.enable = true;

    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    zellij.enable = true;

    fastfetch.enable = true;
    hyfetch.enable = true;

    cava.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = # fish
      ''
        set fish_greeting
      '';

    shellAbbrs = {
      s = "sudo";
      e = config.home.sessionVariables.EDITOR;
      f = config.programs.yazi.shellWrapperName;
      g = "lazygit";
      a = "7z";

      ns = "nh os switch";
      nb = "nh os boot";
      hs = "nh home switch";
    };

    functions = { };
    plugins = [ ];
  };

  programs.starship.enable = true;
}
