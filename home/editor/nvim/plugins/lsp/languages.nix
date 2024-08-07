{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
    lsp.servers = {
      # INFO: remove when nixd has more features
      nil-ls = {
        enable = true;
        settings.formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
      };

      nixd = {
        enable = true;
        settings =
          let
            getFlake = ''(builtins.getFlake "${inputs.self}")'';
            user = "${config.home.username}";
          in
          {
            formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
            options.home-manager.expr = ''${getFlake}.homeConfigurations.${user}.options'';
            diagnostic.suppress = [ "sema-escaping-with" ];
          };
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
