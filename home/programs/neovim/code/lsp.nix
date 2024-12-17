{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-lightbulb.enable = true;
      lsp-lines.enable = true;
      otter.enable = true;

      lsp = {
        enable = true;
        inlayHints = true;

        keymaps = {
          diagnostic = { };
          extra = [
            {
              mode = [
                "n"
                "v"
              ];
              key = "<leader>l";
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
              key = "gK";
              lua = true;
              action = "vim.lsp.buf.signature_help";
              options.desc = "signature";
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
              key = "<leader>L";
              lua = true;
              action = "require('telescope.builtin').lsp_document_symbols";
              options.desc = "file symbols";
            }
          ];
        };

        servers = {
          basedpyright.enable = true;
          ruff.enable = true;
          lua_ls.enable = true;
          ruby_lsp.enable = true;

          clangd.enable = true;
          zls.enable = true;
          jdtls.enable = true;

          bashls.enable = true;

          vtsls.enable = true;
          cssls.enable = true;
          html.enable = true;

          jsonls.enable = true;
          yamlls.enable = true;
          taplo.enable = true;
        };
      };
    };
  };
}
