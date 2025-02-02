{
  programs.nixvim.plugins = {
    snacks = {
      settings.lazygit.enabled = true;
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>g";
          __unkeyed-2.__raw = "function() Snacks.lazygit() end";
          desc = "git";
        }
      ];
    };

    mini.modules.diff = {
      view.style = "sign";
    };
  };
}
