{ inputs, ... }:
{
  flake.nixosConfigurations = {
    aardvark = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/aardvark/configuration.nix
      ];
    };

    aardvark-with-dashing = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/aardvark/configuration.nix
        ../modules/dashing.nix
      ];
    };

    aardvark-with-lemp = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/aardvark/configuration.nix
        ../modules/lemp.nix
      ];
    };

    aardvark-with-lamp = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/aardvark/configuration.nix
        ../modules/lamp.nix
      ];
    };

    aardvark-with-elk = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/aardvark/configuration.nix
        ../modules/elk.nix
      ];
    };

    dashing = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/dashing/configuration.nix
        ../modules/dashing.nix
      ];
    };
  };
}
