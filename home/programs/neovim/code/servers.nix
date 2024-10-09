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
        nil_ls = {
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

        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        hls.enable = true;

        pylyzer.enable = true;
        ruff.enable = true;
        lua_ls.enable = true;
        ruby_lsp.enable = true;

        clangd.enable = true;
        zls.enable = true;
        jdtls.enable = true;

        bashls.enable = true;

        ts_ls.enable = true;
        cssls = {
          enable = true;
          extraOptions.init_options.provideFormatter = false;
        };
        html = {
          enable = true;
          extraOptions.init_options.provideFormatter = false;
        };

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
