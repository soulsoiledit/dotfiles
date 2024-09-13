{ pkgs, ... }:

{
  programs.nixvim = {
    editorconfig.enable = true;

    plugins.none-ls = {
      enable = true;

      settings.on_attach = # lua
        ''
          function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({async = false})
                end,
              })
            end
          end
        '';

      sources = {
        code_actions = {
          proselint.enable = true;
          refactoring.enable = true;
          statix.enable = true;
        };

        completion = {
          spell.enable = true;
          tags.enable = true;
        };

        diagnostics = {
          # alex.enable = true;
          # codespell.enable = true;
          # deadnix.enable = true;
          # editorconfig_checker.enable = true;
          # markdownlint_cli2.enable = true;
        };

        formatting = {
          nixfmt.enable = true;
          nixfmt.package = pkgs.nixfmt-rfc-style;

          stylua.enable = true;

          shfmt.enable = true;
          # textlint.enable = true;
          # mdformat.enable = true;

          prettier.enable = true;
          prettier.disableTsServerFormatter = true;

          google_java_format.enable = true;
          clang_format.enable = true;
        };

        hover = {
          dictionary.enable = true;
        };
      };
    };
  };
}
