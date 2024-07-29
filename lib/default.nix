{ nixpkgs, ... }:

{
  autoimport =
    path: nixpkgs.lib.fileset.toList (nixpkgs.lib.fileset.fileFilter (file: file.hasExt "nix") path);
}
