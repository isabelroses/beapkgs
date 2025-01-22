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
  version = "0-unstable-2025-01-21";

  src = fetchFromGitHub {
    owner = "isabelroses";
    repo = "website";
    rev = "d494dcc71c991c5b5cc27a9c2127583a89235e05";
    hash = "sha256-U+yAVtpsCPjIi9XWoQJq/DajHUHSxVSV+cY7TesBbGo=";
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
