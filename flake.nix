{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # flake only users can ignore this input
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;

      extLib = import ./ci.nix;

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs lib.systems.flakeExposed (
          system:
          function (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );

      packages = forAllSystems (
        pkgs:
        lib.packagesFromDirectoryRecursive {
          directory = ./pkgs;
          callPackage = lib.callPackageWith (pkgs // self.packages.${pkgs.stdenv.hostPlatform.system});
        }
      );
    in
    {
      inherit packages;
      legacyPackages = packages;

      githubActions = extLib.mkGithubMatrix {
        packages = {
          inherit (self.packages) x86_64-linux x86_64-darwin aarch64-darwin;
        };
      };

      # taken and slightly modified from
      # https://github.com/lilyinstarlight/nixos-cosmic/blob/0b0e62252fb3b4e6b0a763190413513be499c026/flake.nix#L81
      apps = forAllSystems (pkgs: {
        update = {
          type = "app";
          program = lib.getExe (
            pkgs.writeShellApplication {
              name = "update";

              text = lib.concatStringsSep "\n" (
                lib.mapAttrsToList (
                  name: pkg:
                  if pkg ? updateScript && (lib.isList pkg.updateScript) && (lib.length pkg.updateScript) > 0 then
                    lib.escapeShellArgs (
                      if (lib.match "nix-update|.*/nix-update" (lib.head pkg.updateScript) != null) then
                        [ (lib.getExe pkgs.nix-update) ]
                        ++ (lib.tail pkg.updateScript)
                        ++ [
                          "--flake"
                          "packages.${pkgs.stdenv.hostPlatform.system}.${name}"
                        ]
                      else
                        pkg.updateScript
                    )
                  else
                    builtins.toString pkg.updateScript or ""
                ) packages.${pkgs.stdenv.hostPlatform.system}
              );
            }
          );
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./shell.nix { };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      overlays.default = _: prev: self.packages.${prev.stdenv.hostPlatform.system} or { };

      # try getting default to merge modules using [lib.mergeModules](https://noogle.dev/f/lib/mergeModules)
      nixosModules.default = import ./modules/nixos;
      darwinModules.default = import ./modules/darwin self;
      homeManagerModules.default = import ./modules/home-manager self;
    };

  nixConfig = {
    extra-substituters = [ "https://isabelroses.cachix.org" ];
    extra-trusted-public-keys = [
      "isabelroses.cachix.org-1:mXdV/CMcPDaiTmkQ7/4+MzChpOe6Cb97njKmBQQmLPM="
    ];
  };
}
