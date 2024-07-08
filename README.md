A collection of often broken packages. Hence the name bea for break and pkgs for packages.

The packages are always on the latest git version hence why they may be broken.

# Installation

You can use this as either a flake or with channels, not that I know how to use channels.

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    beapkgs = {
      url = "github:isabelroses/beapkgs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compact.follows = "";
      };
    };
  };
}
```

## Using the modules

You can import the modules like so:

```nix
{inputs, ...}:
{
  imports = [
    inputs.beapkgs.homeManagerModules.default
    inputs.beapkgs.nixosModules.default
    inputs.beapkgs.darwinModules.default
  ];
}
```
