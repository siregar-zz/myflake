{ inputs, ... }:
{
  flake.nixosConfigurations = {
    aardvark = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/aardvark/configuration.nix
      ];
    };

    dashing = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../hosts/dashing/configuration.nix
      ];
    };
  };
}
