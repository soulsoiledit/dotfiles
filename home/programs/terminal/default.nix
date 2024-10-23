{ lib, ... }:

{
  options.terminal = lib.mkOption {
    type = lib.types.enum [
      "footclient"
      "wezterm"
    ];
    description = "set the default terminal";
  };
}
