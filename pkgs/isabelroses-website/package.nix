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
  version = "0-unstable-2025-01-26";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "8603eddc4ae8bc507f49445574f01b28f56ce490";
    hash = "sha256-t2xxCubSJvnSTOhN1a9g8J/992aTYohm3ho1tiXdwxk=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-SbV7kh/V44HFdaigAyl0P1bmdISp3CzXC3TbISJ7s70=";

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
