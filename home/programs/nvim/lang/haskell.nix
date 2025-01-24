{
  programs.nixvim.plugins = {
    lsp.servers.hls = {
      enable = true;
      installGhc = true;
    };
  };
}
