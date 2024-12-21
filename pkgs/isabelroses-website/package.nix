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
  version = "0-unstable-2024-12-20";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "7f3e6e19a22a29067fadac6ef19a1977acd6b4b9";
    hash = "sha256-IVYPxsiroXzYcS+jZA5zDJ4Ix0HUbS/jgFg6ZdlVGmU=";
  };

  cargoHash = "sha256-oADW3b/h+aXg8iam9c2CVLkIjjzYMC2fAty6BG1OhhY=";

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
