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
  version = "0-unstable-2024-12-14";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "34ed9927beb6e66bb38639b0437f1530145b8751";
    hash = "sha256-DxfZEW2twI/1Hx9bZcdihaQ/KV1Dyesl+yQNzyo8vAQ=";
  };

  cargoHash = "sha256-6DJjw66U9kWA+4szHRXcToMmvY/xPAfI/cvC+r2xoGQ=";

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
