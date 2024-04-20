{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";

    FLAKE = "${config.home.homeDirectory}/code/dotfiles";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "${config.xdg.dataHome}/cargo/bin"
  ];

  home.packages = with pkgs; [
    tmux

    # modern unix replacements
    gdu
    du-dust
    dua
    fd
    duf

    # qol
    (p7zip.override { enableUnfree = true; })

    trash-cli
    xdg-utils

    steam-run
  ];

  programs = {
    fzf = {
      enable = true;
      catppuccin.enable = true;
    };

    ripgrep.enable = true;
    hyfetch.enable = true;
    jq.enable = true;

    cava = {
      enable = true;
      catppuccin.enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    btop = {
      enable = true;
      catppuccin.enable = true;
    };

    bat = {
      enable = true;
      catppuccin.enable = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
    };
  };

  programs.fish = {
    enable = true;
    catppuccin.enable = true;

    interactiveShellInit = ''
      set fish_greeting
    '';

    shellAbbrs = {
      v = "nvim";
      s = "sudo";
      f = "ya";
      g = "lazygit";
      x = "7z";

      ns = "nh os switch";
      hs = "nh home switch";
    };

    functions = { };
    plugins = [ ];
  };

  programs.starship = {
    enable = true;
    catppuccin.enable = true;
  };
}
