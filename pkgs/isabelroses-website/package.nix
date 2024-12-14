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
    rev = "b909ed3d41026d3b94476164649af95f4b72d03e";
    hash = "sha256-6vxzaEXkSMp5+G75ElXMDbmQpPIjpLXuhGYZg3nr9us=";
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
