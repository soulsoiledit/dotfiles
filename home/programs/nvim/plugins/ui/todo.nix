{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    keymaps = {
      todoTelescope = {
        key = "<leader>t";
        options = {
          silent = true;
          desc = "todo";
        };
      };
    };
  };
}
