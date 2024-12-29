{
  programs.nixvim = {
    plugins = {
      which-key.enable = true;

      rainbow-delimiters.enable = true;

      ccc = {
        enable = true;
        settings = {
          lsp = false;
          highlighter.auto_enable = true;
        };
      };

      snacks.settings.indent.enabled = true;

      mini = {
        luaConfig.pre = "vim.g.minitrailspace_disable = true";
        modules = {
          cursorword = { };
          trailspace = { };
        };
      };
    };

    # enable trailspace on real buffers
    autoCmd = [
      {
        event = "BufNew";
        callback.__raw = ''
          function(args)
            vim.g.minitrailspace_disable = false
          end
        '';
      }
    ];
  };
}
