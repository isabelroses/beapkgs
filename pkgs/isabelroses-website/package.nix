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
  version = "0-unstable-2024-12-21";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "52f724ebd4dfca166423aadf2d51fc11381cc276";
    hash = "sha256-LA0DTTf9XSrRh3RdmTa8USWCBnZjDg+gFooqf5n7bOM=";
  };

  cargoHash = "sha256-kL4S5mM/b/3Bl2RRtdKiSz0qkXnNG8jc/yE6pxF7CO0=";

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
