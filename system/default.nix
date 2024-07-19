{
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    ./config
    ./hardware
    ./programs
    ./services
  ];
}
