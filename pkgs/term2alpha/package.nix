{
  lib,
  pins,
  haskell,
  ...
}:
let
  version = builtins.substring 0 7 pins.term2alpha.version;
in
haskell.packages.ghc94.mkDerivation {
  pname = "term2alpha";
  inherit version;

  inherit (pins.term2alpha) src;

  isLibrary = false;
  isExecutable = true;

  executableHaskellDepends = [ haskell.packages.ghc94.base ];

  license = lib.licenses.mit;
  mainProgram = "term2alpha";
}
