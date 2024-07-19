{ lib, pkgs, ... }:

{
  programs.nixvim.plugins = {
    lsp.servers = {
      nil_ls = {
        enable = true;
        settings.formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
      };

      lua-ls.enable = true;

      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };

      pylsp = {
        enable = true;
        package = pkgs.python3Packages.python-lsp-server;
        settings.plugins.ruff.enabled = true;
      };
      # pylyzer.enable = true;
      ruff.enable = true;

      bashls.enable = true;
      marksman.enable = true;
      # ltex.enable = true;

      tsserver.enable = true;
      cssls.enable = true;
      eslint.enable = true;
      html.enable = true;

      jsonls.enable = true;
      yamlls.enable = true;
      taplo.enable = true;

      zls.enable = true;
      # hls.enable = true;
      java-language-server.enable = true;
      clangd.enable = true;
    };

    rustaceanvim.enable = true;
    nix.enable = true;
    # ltex-extra.enable = true;
  };
}
