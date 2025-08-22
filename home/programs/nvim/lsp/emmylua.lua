---@type vim.lsp.Config
return {
  cmd = { "emmylua_ls" },
  filetypes = { "lua" },
  root_markers = {
    ".git",
    ".luarc.json",
    ".emmyrc.json",
    ".luacheckrc",
  },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
      semanticTokens = {
        enable = false,
      },
    },
  },
}
