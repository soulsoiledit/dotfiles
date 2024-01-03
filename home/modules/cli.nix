{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    tmux

    # Modern Unix replacements
    gdu
    fd
    duf

    acpi
    brightnessctl
    playerctl

    # Qol Tools
    zip
    unzip
    (p7zip.override {enableUnfree = true;})

    nix-tree

    trash-cli
    xdg-utils

    steam-run
  ];

  programs.fzf.enable = true;
  programs.ripgrep.enable = true;
  programs.nix-index.enable = true;
  programs.hyfetch.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha.theme";
      vim_keys = true;

      proc_tree = true;
      proc_gradient = false;
      proc_filter_kernel = true;
    };
  };

  xdg.enable = true;
  xdg.configFile."btop/themes".source = "${inputs.catppuccin-btop}/themes";

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "base16";
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
  };
}
