---@type vim.lsp.Config
return {
  settings = {
    emmylua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = { vim.env.VIMRUNTIME } },
      semanticTokens = { enable = false }
    }
  }
}
