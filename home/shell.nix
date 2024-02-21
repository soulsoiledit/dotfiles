{ pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
    MANPAGER = "nvim +Man!";

    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
  };

  home.sessionPath = [
    "/home/soil/.local/bin"
    "$XDG_DATA_HOME/cargo/bin"
  ];

  home.packages = with pkgs; [
    tmux

    # modern unix replacements
    gdu
    du-dust
    dua
    fd
    duf

    # i neeeed it
    acpi
    brightnessctl
    playerctl

    # qol
    (p7zip.override { enableUnfree = true; })

    trash-cli
    xdg-utils

    steam-run
  ];

  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
    hyfetch.enable = true;
    jq.enable = true;
    cava.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # TODO: declaratively set btop theme and config
    btop.enable = true;

    # TODO: contribute manpage themeing for catppuccin theme
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-mocha";
      };
    };

    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
  };

  # TODO: fetch fish theme automagically
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      fish_config theme choose "Catppuccin Mocha"
    '';

    shellAbbrs = {
      v = "nvim";
      s = "sudo";
      f = "ya";
      g = "lazygit";
      x = "7z";

      ns = "sudo nixos-rebuild switch --flake ~/code/dotfiles";
      hs = "home-manager switch --flake ~/code/dotfiles";
    };

    functions = { };
    plugins = [ ];
  };

  programs.starship.enable = true;
}
