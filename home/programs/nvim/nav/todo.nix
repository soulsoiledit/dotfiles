{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    lazyLoad.settings = {
      event = "DeferredUIEnter";
      keys = [
        {
          __unkeyed-1 = "<leader>t";
          __unkeyed-2.__raw = "function() Snacks.picker.todo_comments() end";
          desc = "todo";
        }
      ];
    };
  };
}
