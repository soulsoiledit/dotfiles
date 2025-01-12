{
  programs.nixvim.plugins = {
    lsp.servers.tinymist = {
      enable = true;
      extraOptions.single_file_support = true;
      settings.formatterMode = "typstyle";
    };
  };
}
