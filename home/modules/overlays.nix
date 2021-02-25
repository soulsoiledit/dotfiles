{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (_: {
        src = builtins.fetchTarball {
          url = https://discord.com/api/download?platform=linux&format=tar.gz;
          sha256 = "0jps9dqjvzr2kg2xxcl0s3vmkpcnqnfa8m76r0n0prk239hpc63m";
        };
      });
    })
  ];
}
