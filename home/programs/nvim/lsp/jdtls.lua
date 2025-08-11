local jdtls_dir = vim.fs.normalize("$XDG_CACHE_HOME/jdtls")
---@type vim.lsp.Config
return {
  cmd = {
    "jdtls",
    "-configuration",
    jdtls_dir .. "/config",
    "-data",
    jdtls_dir .. "/workspace",
  },
  filetypes = { "java" },
  root_markers = {
    ".git",
    "settings.gradle.kts",
    "settings.gradle",
    "build.gradle.kts",
    "build.gradle",
  },
}
