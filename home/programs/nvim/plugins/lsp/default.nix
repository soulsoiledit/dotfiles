{
  programs.nixvim = {
    plugins = {
      nvim-lightbulb.enable = true;

      lsp = {
        enable = true;
        inlayHints = true;

        onAttach = # lua
          ''
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
          '';

        keymaps = {
          diagnostic = { };
          extra = [
            {
              mode = [
                "n"
                "v"
              ];
              key = "<leader>la";
              lua = true;
              action = "vim.lsp.buf.code_action";
              options.desc = "code action";
            }
            {
              mode = [ "n" ];
              key = "gr";
              lua = true;
              action = "vim.lsp.buf.rename";
              options.desc = "rename";
            }
            {
              mode = [ "n" ];
              key = "gd";
              lua = true;
              action = "require('telescope.builtin').lsp_definitions";
              options.desc = "definition";
            }
            {
              mode = [ "n" ];
              key = "gld";
              lua = true;
              action = "vim.lsp.buf.declaration";
              options.desc = "declaration";
            }
            {
              mode = [ "n" ];
              key = "K";
              lua = true;
              action = "vim.lsp.buf.hover";
              options.desc = "hover";
            }
            {
              mode = [ "n" ];
              key = "gD";
              lua = true;
              action = "require('telescope.builtin').lsp_type_definitions";
              options.desc = "type definition";
            }
            {
              mode = [ "n" ];
              key = "gI";
              lua = true;
              action = "require('telescope.builtin').lsp_implementations";
              options.desc = "implementation";
            }
            {
              mode = [ "n" ];
              key = "gR";
              lua = true;
              action = "require('telescope.builtin').lsp_references";
              options.desc = "references";
            }
            {
              mode = [ "n" ];
              key = "<leader>ld";
              lua = true;
              action = "require('telescope.builtin').lsp_document_symbols";
              options.desc = "file symbols";
            }
            {
              mode = [ "n" ];
              key = "<leader>lw";
              lua = true;
              action = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
              options.desc = "project symbols";
            }
          ];
        };
      };
    };
  };
}
