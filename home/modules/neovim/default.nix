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
      vim-devicons
      rainbow
      indentLine # Use indent-blankline
      # Integration
        # Git
        git-messenger-vim
        vim-fugitive
        vim-gitgutter
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
      coc-nvim
      # nvim-lspconfig

      polyglot
      vim-dispatch
      syntastic


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
