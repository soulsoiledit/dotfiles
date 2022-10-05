{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    master.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asusctl = {
      url = "github:Cogitri/cogitri-pkgs";  
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
  };

  outputs = { self, nixpkgs, home-manager, asusctl, ... }@inputs: {
    nixosConfigurations.soilnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system/configuration.nix
        asusctl.nixosModules.asusd
        asusctl.nixosModules.supergfxd

        {
          nix.registry.nixpkgs.flake = nixpkgs;
          nixpkgs.overlays = [ 
            asusctl.overlays.default
          ];
        }
      ];
    };

    homeConfigurations.soil = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      system = "x86_64-linux";
      username = "soil";
      homeDirectory = "/home/soil";
      stateVersion = "22.05";
      configuration.imports = [
          ./home/home.nix 
          { nixpkgs.overlays = [ asusctl.overlays.default]; }
        ];
      extraSpecialArgs = { inherit inputs; };
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
