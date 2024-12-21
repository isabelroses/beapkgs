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
    rev = "4c199b98440f3fb0ae623e766ab19014e343d83a";
    hash = "sha256-AYmY2Ko4E7b+EgDzYz9oUE6hElEWlsEYiGzDYklSHdA=";
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
