{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim = {
    plugins = {
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

        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        hls.enable = true;

        pylyzer.enable = true;
        ruff.enable = true;
        lua-ls.enable = true;
        ruby-lsp.enable = true;

        clangd.enable = true;
        zls.enable = true;
        jdt-language-server.enable = true;

        texlab.enable = true;
        marksman.enable = true;

        bashls.enable = true;

        ts-ls.enable = true;
        cssls.enable = true;
        html.enable = true;

        jsonls.enable = true;
        yamlls.enable = true;
        taplo.enable = true;
      };

      # rustaceanvim.enable = true;
      # haskell-tools.enable = true;
      # ltex-extra.enable = true;
    };
  };
}
