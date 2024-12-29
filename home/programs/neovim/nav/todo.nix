{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    keymaps.todoTelescope = {
      key = "<leader>t";
      action.__raw = ''
        function() 
          require("telescope").extensions["todo-comments"].todo(git_cwd()) 
        end
      '';
      options.desc = "todo";
    };
  };
}
