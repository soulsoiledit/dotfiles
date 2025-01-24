{
  programs.nixvim.plugins = {
    lsp.servers.rust_analyzer = {
      enable = true;
      installRustc = true;
      installCargo = true;
      installRustfmt = true;
    };
  };
}
