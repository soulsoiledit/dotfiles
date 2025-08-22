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
      format = {
        externalTool = {
          program = "stylua",
          args = {
            "-",
            "--stdin-filepath",
            "${file}",
            "--indent-type",
            "${use_tabs?Tabs:Spaces}",
            "--indent-width=${indent_size}",
          },
        },
      },
    },
  },
}
