# this imports all files in a directory (besides default.nix)
# with our modified arguments
{
  lib,
  pkgs,
  self,
  ...
}@args:
dir:
let
in
lib.pipe dir [
  builtins.readDir
  builtins.attrNames
  (lib.remove "default.nix")

  # instead of letting `evalModules` pass arguments to each file
  # in our list, we import them directly
  (map (file: _: import "${dir}/${file}" args))
]
