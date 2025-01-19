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
  version = "0-unstable-2025-01-19";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "726ac0d17f9821ea91d916de95cae6973ccecf4f";
    hash = "sha256-+qGqgjLZe19zc68zZ4AYOF/fanrIDg5+kF8QDT0t8x4=";
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
