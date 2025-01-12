{
  programs.nixvim.plugins.flash = {
    enable = true;
    lazyLoad.settings = {
      event = "DeferredUIEnter";
      keys = [
        {
          __unkeyed-1 = "s";
          __unkeyed-2.__raw = ''
            function()
              require("flash").jump()
            end
          '';
          mode = [
            "n"
            "x"
            "o"
          ];
          desc = "flash search";
        }

        {
          __unkeyed-1 = "r";
          __unkeyed-2.__raw = ''
            function()
              require("flash").remote()
            end
          '';
          mode = "o";
          desc = "flash remote";
        }
      ];
    };
  };
}
