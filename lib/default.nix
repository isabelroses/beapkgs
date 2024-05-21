{ lib }:
let
  mkImportNames =
    dir:
    lib.pipe dir [
      builtins.readDir
      builtins.attrNames
      (lib.remove "default.nix")
    ];

  mkImports = dir: builtins.map (file: "${dir}/${file}") (mkImportNames dir);

  mkModules =
    dir:
    lib.attrsets.genAttrs (builtins.map (x: lib.strings.removeSuffix ".nix" x) (mkImportNames dir)) (
      file: "${dir}/${file}.nix"
    );
in
{
  inherit mkImports mkImportNames mkModules;
}
