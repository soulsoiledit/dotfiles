{
  programs.nixvim = {
    plugins.flash.enable = true;

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = "function() require('flash').jump() end";
        lua = true;
        options.desc = "flash search";
      }
      {
        mode = "o";
        key = "r";
        action = "function() require('flash').remote() end";
        lua = true;
        options.desc = "flash remote";
      }
    ];
  };
}
