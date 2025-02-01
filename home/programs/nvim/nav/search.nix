{
  programs.nixvim.plugins = {
    grug-far = {
      enable = true;
      lazyLoad.settings.cmd = "GrugFar";
    };

    snacks = {
      settings.picker.enabled = true;
      lazyLoad.settings.keys = [
        # files
        {
          __unkeyed-1 = "<leader>f";
          __unkeyed-2.__raw = ''function() Snacks.picker.smart() end'';
          desc = "files";
        }

        # grep
        {
          __unkeyed-1 = "<leader>s";
          __unkeyed-2.__raw = ''function() Snacks.picker.grep() end'';
          desc = "grep";
        }

        {
          __unkeyed-1 = "<leader>l";
          __unkeyed-2.__raw = ''function() Snacks.picker.grep_buffers() end'';
          desc = "lines";
        }

        # nvim
        {
          __unkeyed-1 = "<leader>p";
          __unkeyed-2.__raw = ''function() Snacks.picker() end'';
          desc = "pickers";
        }

        {
          __unkeyed-1 = "<leader>c";
          __unkeyed-2.__raw = ''function() Snacks.picker.commands() end'';
          desc = "commands";
        }

        {
          __unkeyed-1 = "<leader>h";
          __unkeyed-2.__raw = ''function() Snacks.picker.help() end'';
          desc = "help";
        }
      ];
    };
  };
}
