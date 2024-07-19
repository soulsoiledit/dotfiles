{
  programs.nixvim = {
    extraConfigLua = # lua
      ''
        local signs = {
          Error = " ",
          Warn  = " ",
          Hint  = "󰌶 ",
          Info  = " ",
        }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      '';

    plugins.lsp.onAttach = # lua
      ''
        if client.server_capabilities.inlayHintProvider then 
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr }) 
        end 
      '';

    plugins = {
      lsp-lines.enable = true;
      lspkind.enable = true;

      nvim-lightbulb = {
        enable = true;
        settings = {
          autocmd.enabled = true;
          sign.text = "󰌵";
        };
      };
    };
  };
}
