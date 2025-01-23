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
  version = "0-unstable-2025-01-22";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "8a429131b54d40a80342635d020438720a45d720";
    hash = "sha256-y7xe+ZvwD/mJvF/T5yvpQkOERpXBIBr6yAdjCNEW2iU=";
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
