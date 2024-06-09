{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    nvfetcher
    nixfmt-rfc-style
  ];
}
