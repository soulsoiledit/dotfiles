{
  programs.nixvim = {
    plugins = {
      lsp.servers.rust_analyzer = {
        installCargo = true;
        installRustc = true;
      };

      rustaceanvim.enable = true;
    };
  };
}
