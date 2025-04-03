---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".git",
    ".luarc.json", ".luarc.jsonc",
    "stylua.toml", ".stylua.toml",
  },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME }
      },
      diagnostics = { disable = { "lowercase-global" }, },
      hint = { enable = true }
    },
  },
}
