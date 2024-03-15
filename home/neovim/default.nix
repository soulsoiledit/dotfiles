{ pkgs, config, ... }:

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

  xdg.configFile."nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/dotfiles/home/neovim/lua";

  programs.helix.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      gcc
      gnumake

      # for mason
      wget
      unzip
      cargo

      # multi
      ltex-ls
      nodePackages.prettier

      # nix
      nil
      nixfmt-rfc-style

      # lua
      lua-language-server
      stylua

      # json/yaml/toml
      vscode-langservers-extracted
      yaml-language-server
      taplo-lsp

      # sh
      nodePackages.bash-language-server
      shfmt

      # markdown
      marksman

      # rust
      rust-analyzer
      rustfmt

      # python
      python3Packages.python-lsp-server
      ruff
      ruff-lsp

      # haskell
      haskellPackages.haskell-language-server
      ormolu

      # zig
      zls

      # c
      clang-tools

      # js/ts
      javascript-typescript-langserver

      # java
      jdt-language-server
      google-java-format
    ];
  };
}
