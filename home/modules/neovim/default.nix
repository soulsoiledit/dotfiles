{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;

    extraConfig = "";

    extraPackages = with pkgs; [
      patchelf
      gcc
      gnumake
      unzip
      cargo

      # nix
      nil
      alejandra

      # lua
      lua-language-server
      stylua

      # python
      pyright
      ruff-lsp
      ruff
      black

      # rust
      rust-analyzer
      rustfmt

      # haskell

      # mult
      prettierd
      ltex-ls
      ast-grep

      # latex
      texlab

      # markdown
      marksman
      cbfmt

      # js/ts
      javascript-typescript-langserver

      # shell
      nodePackages.bash-language-server
      shfmt

      # c/cpp
      clang-tools
      uncrustify

      # java
      jdt-language-server
      google-java-format

      # zig
      zls
    ];
  };
}
