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

        lua-ls.enable = true;

        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        #
        pylsp = {
          enable = true;
          package = pkgs.python3Packages.python-lsp-server;
        };
        #     # pylyzer.enable = true;
        # pyright = {
        #   enable = true;
        #   package = pkgs.basedpyright;
        # };
        ruff.enable = true;
        ruff-lsp.enable = true;

        ruby-lsp.enable = true;
        # solargraph.enable = true;

        bashls.enable = true;
        texlab.enable = true;
        marksman.enable = true;

        tsserver.enable = true;
        cssls.enable = true;
        html.enable = true;

        jsonls.enable = true;
        yamlls.enable = true;
        taplo.enable = true;

        zls.enable = true;
        hls.enable = true;
        jdt-language-server.enable = true;
        clangd.enable = true;
      };

      # rustaceanvim.enable = true;
      # haskell-tools.enable = true;
      # ltex-extra.enable = true;

      trouble.enable = true;
      vimtex.enable = true;

      markdown-preview.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [ render-markdown ];
  };
}
