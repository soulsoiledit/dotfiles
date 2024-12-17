{ inputs, pkgs, ... }:

{
  programs.nixvim.plugins = {
    lastplace.enable = true;
    grug-far.enable = true;

    snacks = {
      enable = true;
      # TODO: remove when snacks is updated
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "snacks.nvim";
        version = inputs.snacks-nvim.shortRev;
        src = inputs.snacks-nvim;
        meta.homepage = "https://github.com/folke/snacks.nvim/";
      };
    };

    mini = {
      enable = true;
      modules = {
        basics = {
          options.extra_ui = true;
          navigation.windows = true;
        };
      };
    };
  };
}
