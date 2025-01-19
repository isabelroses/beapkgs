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
  version = "0-unstable-2025-01-18";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "a3d714a7044dfc4c0bb82909bd1a6a48f8d73134";
    hash = "sha256-Ib0ZzDvWitwuirYZECRvzuDfhHIwTsKGLl5qEOuKtpE=";
  };

  cargoHash = "sha256-FtPe2c+rGwCKqLdsKaD7BIPc6yyDvmDVZtXcFRTJgK4=";

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
