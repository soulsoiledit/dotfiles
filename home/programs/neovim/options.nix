{
  programs.nixvim = {
    opts = {
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      relativenumber = true;
      scrolloff = 4;
      wrap = true;

      timeoutlen = 250;
    };

    globals = {
      mapleader = " ";
      localleader = "\\";
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
  };
}
