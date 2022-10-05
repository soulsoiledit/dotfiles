{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraConfig = "luafile ~/.config/nvim/luainit.lua";
    extraPackages = with pkgs; [
      gcc
      universal-ctags
      code-minimap
      ripgrep
      fd

      rnix-lsp
      pandoc

      nodePackages.live-server
    ];

    plugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
    ];
  };

  programs.lazygit.enable = true;
  programs.gh.enable = true;
}
