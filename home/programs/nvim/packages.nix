{ pkgs, ... }:

{
  programs.neovim.extraPackages = with pkgs; [
    # vim
    lua-language-server
    emmylua-ls
    stylua

    # nix
    nil
    nixd
    nixfmt

    # python
    basedpyright
    ruff

    # main
    rust-analyzer
    rustc
    cargo
    rustfmt

    # haskell-language-server
    # ghc
    # ormolu
    # haskellPackages.cabal-gild

    zls

    # shell
    bash-language-server
    fish-lsp
    shfmt

    texlab
    tectonic
    texlivePackages.latexindent
    zathura

    tinymist
    typst
    typstyle

    # web
    vscode-langservers-extracted
    vtsls
    biome

    # data
    yaml-language-server
    taplo

    # formatting
    efm-langserver
    nodePackages.prettier

    # misc
    ruby-lsp
    jdt-language-server
    kotlin-language-server
    clang-tools
  ];
}
