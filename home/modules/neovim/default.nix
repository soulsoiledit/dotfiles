{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    withNodeJs = true;
    extraConfig = lib.readFile ./init.vim;

    plugins = with pkgs.vimPlugins; [
      # User Intereface
      vim-airline
      nvim-web-devicons
      rainbow
      indentLine # Use indent-blankline
      vim-startify

      # Integration
        # Git
        git-messenger-vim
        vim-fugitive
        vim-signify # vim-gitgutter
      # Efficiency
        # Movement
        vim-lastplace
        fzf-vim
        vim-sneak
        # Commands
        auto-pairs
        vim-repeat
        vim-surround
        vim-commentary
        vim-better-whitespace
        vim-peekaboo
        vim-easy-align
        undotree

        vim-abolish
        targets-vim
      # Development
      # nvim-lspconfig nvim-lspsaga
      # nvim-treesitter
        vim-hexokinase # nvim-colorizer.lua
      completion-nvim
        completion-buffers
        # completion-treesitter

      # telescope-nvim
      #   plenary-nvim
      #   popup-nvim

      polyglot
      syntastic
      vim-dispatch
    ];
  };
}
