{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    keymaps = {
      todoTelescope = {
        key = "<leader>ft";
        options = {
          silent = true;
          desc = "todo";
        };
      };
    };
  };
}
