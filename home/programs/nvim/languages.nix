{ pkgs, ... }:

{
  programs.neovim.extraPackages = with pkgs; [
    # vim
    lua-language-server

    # nix
    nil
    nixd
    nixfmt-rfc-style

    # python
    basedpyright
    ruff

    # main
    rust-analyzer
    rustc
    cargo
    rustfmt

    haskell-language-server
    ghc
    ormolu
    haskellPackages.cabal-gild

    zls

    # shell
    bash-language-server
    fish-lsp
    shfmt

    # text
    iwe
    marksman

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

    # format
    efm-langserver
    nodePackages.prettier

    # misc
    ruby-lsp
    jdt-language-server
    kotlin-language-server
    clang-tools
  ];

  xdg.configFile."biome.json".source = pkgs.writers.writeJSON "biome.json" {
    formatter.indentStyle = "space";
  };
}
