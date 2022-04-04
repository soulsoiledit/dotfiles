{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = "github:vlaci/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.soilnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system/configuration.nix

        {
          nix.registry.nixpkgs.flake = nixpkgs;
        }
      ];
    };

    homeConfigurations.soil = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      homeDirectory = "/home/soil";
      username = "soil";
      stateVersion = "22.05";
      configuration = { pkgs, ... }: {
        imports = [ inputs.nix-doom-emacs.hmModule ./home/home.nix ];
        nixpkgs.config.allowUnfree = true;
      };
    };
  };
}
