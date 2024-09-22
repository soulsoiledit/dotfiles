{
  programs.nixvim.plugins.todo-comments = {
    enable = true;

    keymaps.todoTelescope = {
      key = "<leader>t";
      options.desc = "todo-comments";
    };
  };
}
