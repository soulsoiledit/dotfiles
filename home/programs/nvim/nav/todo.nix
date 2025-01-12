{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    lazyLoad.settings = {
      event = "DeferredUIEnter";
      cmd = "TodoTelescope";
      keys = [
        {
          __unkeyed-1 = "<leader>t";
          __unkeyed-2 = "<cmd>TodoTelescope<cr>";
          desc = "todo";
        }
      ];
    };
  };
}
