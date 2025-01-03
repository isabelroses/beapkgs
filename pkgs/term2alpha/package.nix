{
  lib,
  fetchFromSourcehut,
  haskell,
}:
haskell.packages.ghc94.mkDerivation {
  pname = "term2alpha";
  version = "d1d3b51071e099d0473d9ef228e9bb8bf7b016ca";

  src = fetchFromSourcehut {
    owner = "~zethra";
    repo = "term2alpha";
    rev = "d1d3b51071e099d0473d9ef228e9bb8bf7b016ca";
    hash = "sha256-TqGryK4a+zizTq/5xS4HYF6JCeRHP27ZVkGJq22bAbk=";
  };

  isLibrary = false;
  isExecutable = true;

  executableHaskellDepends = [ haskell.packages.ghc94.base ];

  # passthru.updateScript = nix-update-script {
  #   extraArgs = [
  #     "--version"
  #     "branch=HEAD"
  #   ];
  # };

  license = lib.licenses.mit;
  mainProgram = "term2alpha";
}
