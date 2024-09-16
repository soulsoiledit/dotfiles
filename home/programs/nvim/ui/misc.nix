{
  programs.nixvim = {
    plugins = {
      which-key.enable = true;
      rainbow-delimiters.enable = true;
      nvim-colorizer.enable = true;
      trouble.enable = true;

      mini.modules = {
        indentscope = { };
        trailspace = { };
        cursorword = { };
      };
    };
  };
}
