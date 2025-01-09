{
  lib,
  just,
  dart-sass,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "isabelroses-website";
  version = "0-unstable-2025-01-09";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "ad80cd5ead68b8a38a8aed8da2baf4b13000200b";
    hash = "sha256-jQH0gSiXm0uN4yxFSQK+zfCOMz2bP8McZsB0uxPkpik=";
  };

  cargoHash = "sha256-Ox44fchFUL4HlPw9sdnh9ciOkiGQ26P9nk12a4AR8d8=";

  nativeBuildInputs = [
    just
    dart-sass
  ];

  dontUseJustInstall = true;
  dontUseJustBuild = true;
  dontUseJustCheck = true;

  preBuild = ''
    just build-styles
  '';

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
