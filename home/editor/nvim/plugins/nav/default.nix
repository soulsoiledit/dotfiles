{
  imports = [
    ./flash.nix
    ./telescope.nix
  ];

  programs.nixvim.plugins = {
    nvim-tree.enable = true;
    lastplace.enable = true;
  };
}
