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
  version = "0-unstable-2024-12-19";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "6f7cf02af1c83520c61ccc3bb3abcc5cff6c9838";
    hash = "sha256-eNFNfi+uF3D9QIs52Ww8/vrwwMbLrgIhTi39TbLMQ5o=";
  };

  cargoHash = "sha256-Dq6I4zN+1DVBbyMlsS/Tf6J49PYX+rW/sy/qIGWABdQ=";

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
