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
  version = "0-unstable-2025-01-17";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "6743b2f7f8338f5f3c57ced90aed17cd3c6b7d24";
    hash = "sha256-i5MwaJwoC+edTeHWP2TMFh8kDaALnPXHHPYKzBps4GE=";
  };

  cargoHash = "sha256-+svpreGMeihXlOT581COjrbqf8vBGieWQSd/I6gQ2dM=";

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
