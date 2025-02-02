{ lib, ... }:

{
  # define type so lists will be merged
  options.programs.nixvim.plugins.snacks.lazyLoad.settings.keys = lib.mkOption {
    type = lib.types.listOf lib.types.attrs;
  };

  config.programs.nixvim.plugins = {
    lz-n = {
      enable = true;
      luaConfig.pre = ''
        vim.loader.enable()
      '';
    };

    ts-comments = {
      enable = true;
      lazyLoad.settings.event = "DeferredUIEnter";
    };

    snacks = {
      enable = true;
      lazyLoad.settings.lazy = false;
      settings = {
        bigfile.enabled = true;
        quickfile.enabled = true;
      };
    };

    mini = {
      enable = true;
      lazyLoad.settings.lazy = false;

      modules = {
        basics = {
          options.extra_ui = true;
          mappings.windows = true;
        };

        misc = { };
      };

      # setup misc functions
      luaConfig.post = ''
        MiniMisc.setup_termbg_sync()
        MiniMisc.setup_restore_cursor()
        MiniMisc.setup_auto_root()
      '';
    };
  };
}
