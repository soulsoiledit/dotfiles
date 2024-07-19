{
  programs.nixvim = {
    colorscheme = "catppuccin";

    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          integrations = {
            aerial = true;
            noice = true;
            notify = true;
            which_key = true;
          };
        };
      };
    };
  };
}
