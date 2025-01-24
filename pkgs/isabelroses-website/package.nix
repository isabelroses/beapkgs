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
  version = "0-unstable-2025-01-23";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "0fdf951bea2e45917b58d23f4c138ad9ee3b75ff";
    hash = "sha256-uneT9LOegMnllUZIZxtkyRkidULPCe7gfMQKdqLXAIU=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-NkUGik6WGv6Xsi5vEuyOSb9X6mMrrPFkJNdi2ofEC0s=";

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
