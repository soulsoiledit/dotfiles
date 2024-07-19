{
  programs.nixvim = {

    opts = {
      autowrite = true;
      undofile = true;
      undolevels = 10000;
      number = true;
      relativenumber = true;

      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      shiftround = true;

      ignorecase = true;
      smartcase = true;

      timeoutlen = 250;

      cursorline = true;
      list = true;
      scrolloff = 4;
      showmode = false;

      splitbelow = true;
      splitright = true;

      autochdir = true;

      wrap = true;
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
