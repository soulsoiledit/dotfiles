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
      # coc-nvim
      # nvim-lspconfig
      nvim-treesitter
        vim-hexokinase # nvim-colorizer.lua
      completion-nvim
        completion-buffers
        completion-tabnine
        completion-treesitter

      # telescope-nvim
        # plenary-nvim
        # popup-nvim

      polyglot
      syntastic
      vim-dispatch

      # gruvbox-material?
      (pkgs.vimUtils.buildVimPlugin {
        name = "miramare";
        src = pkgs.fetchFromGitHub {
          owner = "franbach";
          repo = "miramare";
          rev = "master";
          sha256 = "Sxb36AYsFH2QXT5wXufAQqTSsTxPc09CPfIBDeVvDMo=";
        };
      })
    ];
  };

  xdg.configFile."nvim/coc-settings.json".source = ./coc-settings.json;
}
