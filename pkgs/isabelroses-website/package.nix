{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "isabelroses-website";
  version = "0-unstable-2024-11-17";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "20de3520c58c42d8d435e755a79a8eb077a2e1ff";
    hash = "sha256-/PApKnetermcVz9K3RaoddJ5ldQWZd9k6clpkF8TjfQ=";
  };

  cargoHash = "sha256-PeqZC/buRYtNNVqso++9uf0y/z5jJk5LtCJAQtmJ47k=";

  passthru.updateScript = nix-update-script {
    extraArgs = [
      "--version"
      "branch=HEAD"
    ];
  };

  meta = {
    description = "isabelroses.com";
    homepage = "https://isabelroses.com/";
    license = with lib.licenses; [
      mit
      cc-by-nc-sa-40
    ];
    mainProgram = "isabelroses-website";
  };
}
