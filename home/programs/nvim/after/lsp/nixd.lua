return {
  cmd = { "nixd", "--semantic-tokens=true" },
  settings = {
    nixd = {
      options = {
        home_manager = {
          expr = string.format(
            "(builtins.getFlake (builtins.toString %s)).homeConfigurations.%s.options",
            nix.flake_dir,
            nix.user
          ),
        },
      },
      formatting = { command = { "nixfmt" } },
    },
  },
}
