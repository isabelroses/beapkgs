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
  version = "0-unstable-2024-12-29";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "5d2f477b1320099abbefe5fe88e94853df4f7765";
    hash = "sha256-vhbzG6FAO1POlqOJ5rKS7VEJqSkr9tvGAdj51lMlwrE=";
  };

  cargoHash = "sha256-/0owXF6WhTTjlt4o0bIONX2o5PZqlhj2I3Vv157lXRI=";

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
