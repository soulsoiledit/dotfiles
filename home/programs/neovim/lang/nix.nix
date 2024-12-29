{
  programs.nixvim.plugins = {

    lsp.servers = {
      nil_ls = {
        enable = true;
        settings.nix.flake.autoArchive = false;
      };

      nixd = {
        enable = true;
        # settings.options.home.expr =
        #   let
        #     getFlake = ''builtins.getFlake "${inputs.self}"'';
        #     user = config.home.username;
        #   in
        #   ''(${getFlake}).homeConfigurations.${user}.options'';
      };
    };
  };
}
