{
  description = "Nix packages for nurazon59's CLI tools";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays.default = import ./overlay.nix;

      packages = forAllSystems (system: import ./pkgs { pkgs = nixpkgs.legacyPackages.${system}; });

      checks = self.packages;

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
