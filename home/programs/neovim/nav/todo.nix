{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    lazyLoad.settings = {
      event = "DeferredUIEnter";
      keys = [
        {
          __unkeyed-1 = "<leader>t";
          __unkeyed-2.__raw = ''
            function()
              require("lz.n").trigger_load("telescope.nvim")
              require("telescope").extensions["todo-comments"].todo(git_cwd())
            end
          '';
          desc = "todo";
        }
      ];
    };
  };
}
