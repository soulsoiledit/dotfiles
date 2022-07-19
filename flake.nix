{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asusctl = {
      url = "github:Cogitri/cogitri-pkgs";  
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = { self, nixpkgs, home-manager, asusctl, ... }: {
    nixosConfigurations.soilnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system/configuration.nix
        asusctl.nixosModules.asusd
        asusctl.nixosModules.supergfxd

        {
          nix.registry.nixpkgs.flake = nixpkgs;

          nixpkgs.overlays = [ asusctl.overlays.default ];

          services.asusd = {
              enable = true;
              enable-power-profiles-daemon = true;
          };

          services.supergfxd = {
            enable = true;
            gfx-mode = "Integrated";
            gfx-managed = true;
          };
        }
      ];
    };

    homeConfigurations.soil = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ 
        ./home/home.nix
      ];
    };

    apps.x86_64-linux.update-home = {
      type = "app";
      program = (nixpkgs.legacyPackages.x86_64-linux.writeScript "update-home" ''
      set -euo pipefail
      old_profile=$(nix profile list | grep home-manager-path | head -n1 | awk '{print $4}')
      echo $old_profile
      nix profile remove $old_profile
      ${self.homeConfigurations.soil.activation-script}/activate || (${nixpkgs.legacyPackages.x86_64-linux.nix}/bin/nix profile install $old_profile)
    '').outPath;
    };
  };
}
