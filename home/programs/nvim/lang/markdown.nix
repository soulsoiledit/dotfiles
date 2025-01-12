{
  programs.nixvim.plugins = {
    lsp.servers.marksman.enable = true;

    render-markdown = {
      enable = true;
      lazyLoad.settings.ft = [
        "markdown"
        "norg"
        "rmd"
        "org"
      ];
    };

    # markview.enable = true;

    markdown-preview = {
      enable = true;
      autoLoad = false;
    };

    lz-n.plugins = [
      {
        __unkeyed-1 = "markdown-preview.nvim ";
        ft = "markdown";
      }
    ];
  };
}
