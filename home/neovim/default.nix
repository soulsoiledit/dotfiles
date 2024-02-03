{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "soulsoiledit";
    userEmail = "soulsoill@proton.me";

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };

  programs.lazygit.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      gcc
      gnumake

      # for mason
      wget
      unzip

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
      cargo
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
