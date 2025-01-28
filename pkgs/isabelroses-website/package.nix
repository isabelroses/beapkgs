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
  version = "0-unstable-2025-01-27";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "b22fd0c6a2ded0267cec76be44b872000215346f";
    hash = "sha256-FCVy+orp08NHRlCxOI9u1jns1lbRywCA/2d3rrlEfLY=";
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
