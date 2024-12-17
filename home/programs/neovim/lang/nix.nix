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
      # TODO: remove when nixd has more features
      nil_ls.enable = true;

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
          };
      };
    };

    # manix
    telescope.extensions.manix.enable = true;
  };
}
