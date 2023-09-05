{ lib, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withNodeJs = true;

    extraConfig = "";

    extraPackages = with pkgs; [
      gcc
      gnumake
      unzip
      cargo

      pandoc
      ripgrep
      fd
    ];

    # plugins = with pkgs.vimPlugins; [
    #   # mason-nvim
    #   # markdown-preview-nvim
    # ];
  };

  programs.lazygit.enable = true;
  programs.gh.enable = true;
}
