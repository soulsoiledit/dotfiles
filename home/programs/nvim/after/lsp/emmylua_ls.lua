---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = { vim.env.VIMRUNTIME } },
      semanticTokens = { enable = false },
      format = {
        externalTool = {
          program = "stylua",
          args = {
            "-",
            "--stdin-filepath=${file}",
            "--indent-type=${use_tabs?Tabs:Spaces}",
            "--indent-width=${indent_size}",
          },
        },
      },
    },
  },
}
