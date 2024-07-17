{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake only users can ignore this input
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system:
          function (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [ rust-overlay.overlays.default ];
            }
          )
        );

      callAllPkgs =
        pkgs:
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith (
            pkgs
            // {
              pins = pkgs.callPackage ./_sources/generated.nix { };
              # override rustPlatform to use the overlay
              rustPlatform =
                let
                  toolchain = pkgs.rust-bin.stable.latest.default;
                in
                pkgs.makeRustPlatform {
                  cargo = toolchain;
                  rustc = toolchain;
                };
            }
          );
          directory = ./pkgs;
        };
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      overlays.default = final: _: callAllPkgs final;

      packages = forAllSystems callAllPkgs;

      # try getting default to merge modules using [lib.mergeModules](https://noogle.dev/f/lib/mergeModules)
      nixosModules.default = import ./modules/nixos;
      darwinModules.default = import ./modules/darwin self;
      homeManagerModules.default = import ./modules/home-manager self;
    };
}
