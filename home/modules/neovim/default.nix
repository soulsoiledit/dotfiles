{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    extraConfig = lib.readFile ./init.vim;
    extraPackages = with pkgs; [
      gcc ctags
      code-minimap
      ripgrep fd

      nodePackages.bash-language-server
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.pyright
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vim-language-server
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
      nodePackages.dockerfile-language-server-nodejs
      sumneko-lua-language-server
      solargraph
      rnix-lsp
      dart
      pandoc
    ];

    # plugins = with pkgs.vimPlugins; [
    # ];
  };

  programs.lazygit.enable = true;
  programs.gh.enable = true;
}
