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
  version = "0-unstable-2025-02-10";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "476ec14fdcb39839adeb910a4f8e33d695081df3";
    hash = "sha256-4k8tAOEiYODa7AE4bVMbTiza40rPVw9XFolRdr7l0bs=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-QZRNOodvaxIcXmeAWNdq0WVwg8B5fKNtrRvzYqASvMg=";

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
    maintainers = with lib.maintainers; [ isabelroses ];
  };
}
