{ lib, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraConfig = "";
    extraPackages = with pkgs; [
      gcc
      universal-ctags
      code-minimap
      ripgrep
      fd

      rnix-lsp
      pandoc

      rust-analyzer
      rustfmt
    ];

    plugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
    ];
  };

  programs.lazygit.enable = true;
  programs.gh.enable = true;
}
