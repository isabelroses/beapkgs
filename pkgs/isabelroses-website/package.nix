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
  version = "0-unstable-2025-01-15";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "29ccd788262ec14b44474bf1afbdcdb03b53c6b3";
    hash = "sha256-QGIbIhif4n3sG+ygZV90/vjqQnNMrocV2r9TVaLoaq0=";
  };

  cargoHash = "sha256-IZGAxOErhGByGEVpo3bctxgSQl6AUMfBRtAHp9JFty8=";

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
