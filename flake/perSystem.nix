{ pkgs, ... }:
{
  perSystem = { system, pkgs, ... }: {
    # Packages per-system
    # packages.default = pkgs.hello;

    # Dev shells untuk development
    # devShells.default = pkgs.mkShell {
    #   buildInputs = with pkgs; [ git nixpkgs-fmt ];
    # };

    # Formatter
    formatter = pkgs.nixpkgs-fmt;
  };
}
