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
    "$HOME/.local/bin"
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

    btop.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
      };
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
    };
  };

  # slows builds down
  programs.man.generateCaches = false;

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
