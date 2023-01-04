{ lib, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withNodeJs = true;

    extraConfig = "";

    extraPackages = with pkgs; [
      gcc
      universal-ctags
      code-minimap
      ripgrep
      fd

      pandoc

      nil
      sumneko-lua-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
    ];
  };

  programs.lazygit.enable = true;
  programs.gh.enable = true;
}
