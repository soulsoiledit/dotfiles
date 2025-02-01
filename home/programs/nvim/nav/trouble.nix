{
  programs.nixvim.plugins.trouble = {
    enable = true;
    lazyLoad.settings = {
      cmd = [ "Trouble" ];
      keys = [
        {
          __unkeyed-1 = "<leader>d";
          __unkeyed-2 = "<cmd>Trouble diagnostics toggle<cr>";
          desc = "trouble";
        }
      ];
    };
  };
}
